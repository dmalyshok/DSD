-- Function: gpReport_GoodsMI_ProductionUnion ()

DROP FUNCTION IF EXISTS gpReport_GoodsMI_ProductionUnion (TDateTime, TDateTime,  Boolean, Boolean, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsMI_ProductionUnion (
    IN inStartDate          TDateTime ,  
    IN inEndDate            TDateTime ,
    IN inIsMovement         Boolean   ,
    IN inIsPartion          Boolean   ,
    IN inGoodsGroupId       Integer   ,
    IN inGoodsId            Integer   ,
    IN inChildGoodsGroupId  Integer   ,
    IN inChildGoodsId       Integer   ,
    IN inFromId             Integer   ,    -- �� ���� 
    IN inToId               Integer   ,    -- ����
    IN inSession            TVarChar       -- ������ ������������
)
RETURNS TABLE (InvNumber TVarChar, OperDate TDateTime
             , isPeresort Boolean, DocumentKindName TVarChar
             , PartionGoods TVarChar, GoodsGroupName TVarChar, GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar
             , Amount TFloat, HeadCount TFloat, Summ TFloat
             , ChildPartionGoods TVarChar, ChildGoodsGroupName TVarChar, ChildGoodsCode Integer, ChildGoodsName TVarChar, ChildGoodsKindName TVarChar
             , ChildAmount TFloat, ChildSumm TFloat
             , MainPrice TFloat, ChildPrice TFloat
             )   
AS
$BODY$
BEGIN

    -- ����������� �� ������
    CREATE TEMP TABLE _tmpGoods (GoodsId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpChildGoods (ChildGoodsId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpFromGroup (FromId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpToGroup (ToId  Integer) ON COMMIT DROP;
  
    IF inGoodsGroupId <> 0
    THEN
        INSERT INTO _tmpGoods (GoodsId)
          SELECT GoodsId FROM  lfSelect_Object_Goods_byGoodsGroup (inGoodsGroupId) AS lfObject_Goods_byGoodsGroup;
    ELSE IF inGoodsId <> 0
         THEN
             INSERT INTO _tmpGoods (GoodsId)
              SELECT inGoodsId;
         ELSE
             INSERT INTO _tmpGoods (GoodsId)
               SELECT Object.Id FROM Object WHERE DescId = zc_Object_Goods();
         END IF;
    END IF;

    IF inChildGoodsGroupId <> 0
    THEN
        INSERT INTO _tmpChildGoods (ChildGoodsId)
          SELECT GoodsId FROM  lfSelect_Object_Goods_byGoodsGroup (inChildGoodsGroupId) AS lfObject_Goods_byGoodsGroup;
    ELSE IF inChildGoodsId <> 0
         THEN
             INSERT INTO _tmpChildGoods (ChildGoodsId)
              SELECT inChildGoodsId;
         ELSE
             INSERT INTO _tmpChildGoods (ChildGoodsId)
               SELECT Object.Id FROM Object WHERE DescId = zc_Object_Goods();
         END IF;
    END IF;


    -- ����������� �� �� ����
    IF inFromId <> 0
    THEN
        INSERT INTO _tmpFromGroup (FromId)
           SELECT UnitId FROM lfSelect_Object_Unit_byGroup (inFromId) AS lfSelect_Object_Unit_byGroup;
    ELSE
         INSERT INTO _tmpFromGroup (FromId)
          SELECT Id FROM Object_Unit_View;  --SELECT Id FROM Object WHERE DescId = zc_Object_Unit();
    END IF;

    -- ����������� �� ����
    IF inToId <> 0
    THEN
        INSERT INTO _tmpToGroup (ToId)
           SELECT UnitId FROM lfSelect_Object_Unit_byGroup (inToId) AS lfSelect_Object_Unit_byGroup;
    ELSE
        INSERT INTO _tmpToGroup (ToId)
          SELECT Id FROM Object_Unit_View ;   --SELECT Id FROM Object WHERE DescId = zc_Object_Unit();
    END IF;

  
    -- ���������
    RETURN QUERY
      WITH tmpMI_ContainerIn AS
                       (SELECT CASE WHEN inIsMovement = FALSE THEN 0 ELSE MIContainer.MovementId END AS MovementId
                             , COALESCE (MovementBoolean_Peresort.ValueData, FALSE) AS isPeresort
                             , COALESCE (MLO_DocumentKind.ObjectId, 0)              AS DocumentKindId
                             , MIContainer.DescId                 AS MIContainerDescId
                             , MIContainer.ContainerId            AS ContainerId
                             , MIContainer.ObjectId_Analyzer      AS GoodsId
                             , CASE WHEN inIsPartion = FALSE THEN 0 ELSE COALESCE (MIContainer.ObjectIntId_Analyzer, 0) END AS GoodsKindId
                             , SUM (MIContainer.Amount)           AS Amount
                        FROM MovementItemContainer AS MIContainer
			     INNER JOIN _tmpFromGroup ON _tmpFromGroup.FromId = MIContainer.ObjectExtId_Analyzer
 		             INNER JOIN _tmpToGroup   ON _tmpToGroup.ToId     = MIContainer.WhereObjectId_Analyzer
 		             INNER JOIN _tmpGoods ON _tmpGoods.GoodsId = MIContainer.ObjectId_Analyzer
                             LEFT JOIN MovementBoolean AS MovementBoolean_Peresort
                                                        ON MovementBoolean_Peresort.MovementId = MIContainer.MovementId
                                                       AND MovementBoolean_Peresort.DescId = zc_MovementBoolean_Peresort()
                             LEFT JOIN MovementLinkObject AS MLO_DocumentKind
                                                          ON MLO_DocumentKind.MovementId = MIContainer.MovementId
                                                         AND MLO_DocumentKind.DescId = zc_MovementLinkObject_DocumentKind()
                        WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                          AND MIContainer.isActive = TRUE
                          AND MIContainer.MovementDescId = zc_Movement_ProductionUnion()
                        GROUP BY CASE WHEN inIsMovement = FALSE THEN 0 ELSE MIContainer.MovementId END
                               , MovementBoolean_Peresort.ValueData
                               , MLO_DocumentKind.ObjectId
                               , MIContainer.DescId
                               , MIContainer.ContainerId
                               , MIContainer.ObjectId_Analyzer
                               , CASE WHEN inIsPartion = FALSE THEN 0 ELSE COALESCE (MIContainer.ObjectIntId_Analyzer, 0) END
                       )
         , tmpContainer_in AS (SELECT DISTINCT tmpMI_ContainerIn.ContainerId
                                    , tmpMI_ContainerIn.GoodsId
                                    , tmpMI_ContainerIn.GoodsKindId
                                    , CASE WHEN inIsPartion = FALSE THEN 0 ELSE COALESCE (ContainerLO_PartionGoods.ObjectId, 0) END AS PartionGoodsId
                               FROM tmpMI_ContainerIn
                                    LEFT JOIN ContainerLinkObject AS ContainerLO_PartionGoods
                                                                  ON ContainerLO_PartionGoods.ContainerId = tmpMI_ContainerIn.ContainerId
                                                                 AND ContainerLO_PartionGoods.DescId      = zc_ContainerLinkObject_PartionGoods()
                              )
         , tmpMI_ContainerOut AS
                       (SELECT CASE WHEN inIsMovement = FALSE THEN 0 ELSE MIContainer.MovementId END AS MovementId
                             , MIContainer.DescId                AS MIContainerDescId
                             , COALESCE (MovementBoolean_Peresort.ValueData, FALSE) AS isPeresort
                             , COALESCE (MLO_DocumentKind.ObjectId, 0)              AS DocumentKindId
                             , tmpContainer_in.GoodsId           AS GoodsId_in
                             , tmpContainer_in.GoodsKindId       AS GoodsKindId_in
                             , tmpContainer_in.PartionGoodsId    AS PartionGoodsId_in
                             , MIContainer.ContainerId           AS ContainerId
                             , MIContainer.ObjectId_Analyzer     AS GoodsId       
                             , CASE WHEN inIsPartion = FALSE THEN 0 ELSE MIContainer.ObjectIntId_Analyzer END AS GoodsKindId
                             , -1 * SUM (MIContainer.Amount)     AS Amount
                        FROM tmpContainer_in
			     INNER JOIN MovementItemContainer AS MIContainer
                                                              ON MIContainer.ContainerId_Analyzer = tmpContainer_in.ContainerId
                                                             AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                             AND MIContainer.isActive = FALSE
 		             INNER JOIN _tmpChildGoods ON _tmpChildGoods.ChildGoodsId = MIContainer.ObjectId_Analyzer
                             LEFT JOIN MovementBoolean AS MovementBoolean_Peresort
                                                        ON MovementBoolean_Peresort.MovementId = MIContainer.MovementId
                                                       AND MovementBoolean_Peresort.DescId = zc_MovementBoolean_Peresort()
                             LEFT JOIN MovementLinkObject AS MLO_DocumentKind
                                                          ON MLO_DocumentKind.MovementId = MIContainer.MovementId
                                                         AND MLO_DocumentKind.DescId = zc_MovementLinkObject_DocumentKind()
                        GROUP BY CASE WHEN inIsMovement = FALSE THEN 0 ELSE MIContainer.MovementId END
                               , MIContainer.DescId
                               , MovementBoolean_Peresort.ValueData
                               , MLO_DocumentKind.ObjectId
                               , tmpContainer_in.GoodsId
                               , tmpContainer_in.GoodsKindId
                               , tmpContainer_in.PartionGoodsId
                               , MIContainer.ContainerId
                               , MIContainer.ObjectId_Analyzer
                               , CASE WHEN inIsPartion = FALSE THEN 0 ELSE MIContainer.ObjectIntId_Analyzer END
                       )
      -- ��������� 
      SELECT Movement.InvNumber
           , Movement.OperDate
           
           , tmpOperationGroup.isPeresort :: Boolean AS isPeresort
           , Object_DocumentKind.ValueData  AS DocumentKindName

           , Object_PartionGoods.ValueData AS PartionGoods
           
           , Object_GoodsGroup.ValueData AS GoodsGroupName 
           , Object_Goods.ObjectCode     AS GoodsCode
           , Object_Goods.ValueData      AS GoodsName  
           , Object_GoodsKind.ValueData  AS GoodsKindName
           
           , tmpOperationGroup.OperCount :: TFloat AS Amount
           , 0                           :: TFloat AS HeadCount
           , tmpOperationGroup.OperSumm  :: TFloat AS Summ

           , Object_PartionGoodsChild.ValueData AS ChildPartionGoods
           
           , Object_GoodsGroupChild.ValueData AS ChildGoodsGroupName 
           , Object_GoodsChild.ObjectCode     AS ChildGoodsCode
           , Object_GoodsChild.ValueData      AS ChildGoodsName
           , Object_GoodsKindChild.ValueData  AS ChildGoodsKindName
           
           , tmpOperationGroup.OperCount_out  :: TFloat AS ChildAmount
           , tmpOperationGroup.OperSumm_out   :: TFloat AS ChildSumm
           
           , CASE WHEN tmpOperationGroup.OperCount     <> 0 THEN tmpOperationGroup.OperSumm     / tmpOperationGroup.OperCount     ELSE 0 END :: TFloat AS MainPrice
           , CASE WHEN tmpOperationGroup.OperCount_out <> 0 THEN tmpOperationGroup.OperSumm_out / tmpOperationGroup.OperCount_out ELSE 0 END :: TFloat AS ChildPrice
           
      FROM (SELECT tmpMI_in.MovementId
                 , tmpMI_in.isPeresort
                 , tmpMI_in.DocumentKindId
                 , tmpMI_in.PartionGoodsId
                 , tmpMI_in.GoodsId       
                 , tmpMI_in.GoodsKindId 
                 , tmpMI_in.OperCount
                 , tmpMI_in.OperSumm

                 , tmpMI_out.PartionGoodsId AS PartionGoodsId_out
                 , tmpMI_out.GoodsId        AS GoodsId_out
                 , tmpMI_out.GoodsKindId    AS GoodsKindId_out
                 , tmpMI_out.OperCount      AS OperCount_out
                 , tmpMI_out.OperSumm       AS OperSumm_out

            FROM (SELECT tmpMI_ContainerIn.MovementId
                       , tmpMI_ContainerIn.isPeresort
                       , tmpMI_ContainerIn.DocumentKindId
                       , COALESCE (tmpContainer_in.PartionGoodsId, 0) AS PartionGoodsId
                       , tmpMI_ContainerIn.GoodsId       
                       , tmpMI_ContainerIn.GoodsKindId 
                       , SUM (CASE WHEN tmpMI_ContainerIn.MIContainerDescId = zc_MIContainer_Count() THEN tmpMI_ContainerIn.Amount ELSE 0 END) AS OperCount
                       , SUM (CASE WHEN tmpMI_ContainerIn.MIContainerDescId = zc_MIContainer_Summ()  THEN tmpMI_ContainerIn.Amount ELSE 0 END) AS OperSumm
                  FROM tmpMI_ContainerIn
                       LEFT JOIN tmpContainer_in ON tmpContainer_in.ContainerId = tmpMI_ContainerIn.ContainerId
                  GROUP BY tmpMI_ContainerIn.MovementId
                         , tmpMI_ContainerIn.isPeresort
                         , tmpMI_ContainerIn.DocumentKindId
                         , COALESCE (tmpContainer_in.PartionGoodsId, 0)
                         , tmpMI_ContainerIn.GoodsId       
                         , tmpMI_ContainerIn.GoodsKindId 
                 ) AS tmpMI_in
                 LEFT JOIN (SELECT tmpMI_ContainerOut.MovementId
                                 , tmpMI_ContainerOut.isPeresort
                                 , tmpMI_ContainerOut.DocumentKindId
                                 , tmpMI_ContainerOut.GoodsId_in
                                 , tmpMI_ContainerOut.GoodsKindId_in
                                 , tmpMI_ContainerOut.PartionGoodsId_in
                                 , tmpMI_ContainerOut.GoodsId       
                                 , tmpMI_ContainerOut.GoodsKindId 
                                 , CASE WHEN inIsPartion = FALSE THEN 0 ELSE COALESCE (ContainerLO_PartionGoods.ObjectId, 0) END AS PartionGoodsId
                                 , SUM (CASE WHEN tmpMI_ContainerOut.MIContainerDescId = zc_MIContainer_Count() THEN tmpMI_ContainerOut.Amount ELSE 0 END) AS OperCount
                                 , SUM (CASE WHEN tmpMI_ContainerOut.MIContainerDescId = zc_MIContainer_Summ()  THEN tmpMI_ContainerOut.Amount ELSE 0 END) AS OperSumm
                            FROM tmpMI_ContainerOut
                                 LEFT JOIN ContainerLinkObject AS ContainerLO_PartionGoods
                                                               ON ContainerLO_PartionGoods.ContainerId = tmpMI_ContainerOut.ContainerId
                                                              AND ContainerLO_PartionGoods.DescId      = zc_ContainerLinkObject_PartionGoods()
                            GROUP BY tmpMI_ContainerOut.MovementId
                                   , tmpMI_ContainerOut.isPeresort
                                   , tmpMI_ContainerOut.DocumentKindId
                                   , tmpMI_ContainerOut.GoodsId_in
                                   , tmpMI_ContainerOut.GoodsKindId_in
                                   , tmpMI_ContainerOut.PartionGoodsId_in
                                   , tmpMI_ContainerOut.GoodsId       
                                   , tmpMI_ContainerOut.GoodsKindId 
                                   , CASE WHEN inIsPartion = FALSE THEN 0 ELSE COALESCE (ContainerLO_PartionGoods.ObjectId, 0) END
                           ) AS tmpMI_out ON tmpMI_out.MovementId        = tmpMI_in.MovementId
                                         AND tmpMI_out.isPeresort        = tmpMI_in.isPeresort
                                         AND tmpMI_out.DocumentKindId    = tmpMI_in.DocumentKindId
                                         AND tmpMI_out.GoodsId_in        = tmpMI_in.GoodsId
                                         AND tmpMI_out.GoodsKindId_in    = tmpMI_in.GoodsKindId
                                         AND tmpMI_out.PartionGoodsId_in = tmpMI_in.PartionGoodsId
            ) AS tmpOperationGroup

             LEFT JOIN Movement ON Movement.Id = tmpOperationGroup.MovementId

             LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpOperationGroup.GoodsId
             LEFT JOIN Object AS Object_GoodsChild on Object_GoodsChild.Id = tmpOperationGroup.GoodsId_out

             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpOperationGroup.GoodsKindId
             LEFT JOIN Object AS Object_GoodsKindChild ON Object_GoodsKindChild.Id = tmpOperationGroup.GoodsKindId_out
                    
             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                  ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
             LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupChild
                                  ON ObjectLink_Goods_GoodsGroupChild.ObjectId = Object_GoodsChild.Id
                                 AND ObjectLink_Goods_GoodsGroupChild.DescId = zc_ObjectLink_Goods_GoodsGroup()
             LEFT JOIN Object AS Object_GoodsGroupChild ON Object_GoodsGroupChild.Id = ObjectLink_Goods_GoodsGroupChild.ChildObjectId

             LEFT JOIN Object AS Object_PartionGoods ON Object_PartionGoods.Id = tmpOperationGroup.PartionGoodsId
             LEFT JOIN Object AS Object_PartionGoodsChild ON Object_PartionGoodsChild.Id = tmpOperationGroup.PartionGoodsId_out

             LEFT JOIN Object AS Object_DocumentKind ON Object_DocumentKind.Id = tmpOperationGroup.DocumentKindId

       /*ORDER BY Movement.InvNumber
              , Movement.OperDate
              , Object_PartionGoods.ValueData
              , Object_PartionGoodsChild.ValueData
              , Object_GoodsGroup.ValueData 
              , Object_Goods.ObjectCode     
              , Object_Goods.ValueData      
              , Object_GoodsKind.ValueData 
              , Object_GoodsKindChild.ValueData */
  ;
         
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.02.16                                        * ALL
 24.09.15         * add GoodsKind
 28.11.14         *
*/

-- ����
-- SELECT * FROM gpReport_GoodsMI_ProductionUnion (inStartDate:= '03.06.2016', inEndDate:= '03.06.2016', inIsMovement:= FALSE, inIsPartion:= FALSE, inGoodsGroupId:= 0, inGoodsId:= 0, inChildGoodsGroupId:= 0, inChildGoodsId:=0, inFromId:= 0, inToId:= 0, inSession:= zfCalc_UserAdmin());

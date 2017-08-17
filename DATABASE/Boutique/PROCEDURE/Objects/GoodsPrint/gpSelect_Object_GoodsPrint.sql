-- Function: gpSelect_Object_GoodsPrint (Integer, Integer, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_GoodsPrint (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_GoodsPrint(
    IN inUnitId      Integer,       --  ������������� 
    IN inUserId      Integer,       --  ���������� 
    IN inSession     TVarChar       --  ������ ������������
)
RETURNS TABLE (Id                   Integer
             , UnitId               Integer
             , UnitName             TVarChar
             , UserId               Integer
             , UserName             TVarChar
             , Amount               TFloat
             , InsertDate           TDateTime

             , InvNumber            TVarChar  
             , InvNumber_full       TVarChar
             , GoodsName            TVarChar  
             , GroupNameFull        TVarChar  
             , CurrencyName         TVarChar  
             , BrandName            TVarChar  
             , PeriodName           TVarChar  
             , PeriodYear           Integer  
             , FabrikaName          TVarChar  
             , GoodsGroupName       TVarChar  
             , MeasureName          TVarChar  
             , CompositionName      TVarChar  
             , GoodsInfoName        TVarChar  
             , LineFabricaName      TVarChar  
             , LabelName            TVarChar  
             , CompositionGroupName TVarChar  
             , GoodsSizeName        TVarChar
 ) 
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight(inSession, zc_Enum_Process_Select_Object_GoodsPrint());
     vbUserId:= lpGetUserBySession (inSession);


     -- ���������
     RETURN QUERY 
       SELECT 
             Object_GoodsPrint.Id                AS Id
           , Object_Unit.Id                      AS UnitId
           , Object_Unit.ValueData               AS UnitName
           , Object_User.Id                      AS UserId
           , Object_User.ValueData               AS UserName 
           , Object_GoodsPrint.Amount            AS Amount       
           , Object_GoodsPrint.InsertDate        AS InsertDate
           
           , Movement.InvNumber                  AS InvNumber
           , ('� ' || Movement.InvNumber ||' �� '||zfConvert_DateToString(Movement.OperDate) ) :: TVarChar AS InvNumber_full
           , Object_Goods.ValueData              AS GoodsName
           , Object_GroupNameFull.ValueData      As GroupNameFull
           , Object_Currency.ValueData           AS CurrencyName
           , Object_Brand.ValueData              AS BrandName
           , Object_Period.ValueData             AS PeriodName
           , Object_PartionGoods.PeriodYear      AS PeriodYear
           , Object_Fabrika.ValueData            AS FabrikaName
           , Object_GoodsGroup.ValueData         AS GoodsGroupName
           , Object_Measure.ValueData            AS MeasureName    
           , Object_Composition.ValueData        AS CompositionName
           , Object_GoodsInfo.ValueData          AS GoodsInfoName
           , Object_LineFabrica.ValueData        AS LineFabricaName
           , Object_Label.ValueData              AS LabelName
           , Object_CompositionGroup.ValueData   AS CompositionGroupName
           , Object_GoodsSize.ValueData          AS GoodsSizeName
                      
       FROM Object_GoodsPrint
            LEFT JOIN Object AS Object_Unit  ON Object_Unit.Id         = Object_GoodsPrint.UnitId 
            LEFT JOIN Object AS Object_User  ON Object_User.Id         = Object_GoodsPrint.UserId 
            
            LEFT JOIN Object_PartionGoods    ON Object_PartionGoods.Id = Object_GoodsPrint.PartionId 
            LEFT JOIN Movement               ON Movement.Id            = Object_PartionGoods.MovementId
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id        = Object_PartionGoods.GoodsId 
            
            LEFT JOIN  ObjectString AS Object_GroupNameFull
                                    ON Object_GroupNameFull.ObjectId = Object_Goods.Id
                                   AND Object_GroupNameFull.DescId = zc_ObjectString_Goods_GroupNameFull()                   
            LEFT JOIN  Object AS Object_Currency         ON Object_Currency.Id         = Object_PartionGoods.CurrencyId
            LEFT JOIN  Object AS Object_Brand            ON Object_Brand.Id            = Object_PartionGoods.BrandId
            LEFT JOIN  Object AS Object_Period           ON Object_Period.Id           = Object_PartionGoods.PeriodId
            LEFT JOIN  Object AS Object_Fabrika          ON Object_Fabrika.Id          = Object_PartionGoods.FabrikaId
            LEFT JOIN  Object AS Object_GoodsGroup       ON Object_GoodsGroup.Id       = Object_PartionGoods.GoodsGroupId
            LEFT JOIN  Object AS Object_Measure          ON Object_Measure.Id          = Object_PartionGoods.MeasureId
            LEFT JOIN  Object AS Object_Composition      ON Object_Composition.Id      = Object_PartionGoods.CompositionId
            LEFT JOIN  Object AS Object_GoodsInfo        ON Object_GoodsInfo.Id        = Object_PartionGoods.GoodsInfoId
            LEFT JOIN  Object AS Object_LineFabrica      ON Object_LineFabrica.Id      = Object_PartionGoods.LineFabricaId
            LEFT JOIN  Object AS Object_Label            ON Object_Label.Id            = Object_PartionGoods.LabelId
            LEFT JOIN  Object AS Object_CompositionGroup ON Object_CompositionGroup.Id = Object_PartionGoods.CompositionGroupId
            LEFT JOIN  Object AS Object_GoodsSize        ON Object_GoodsSize.Id        = Object_PartionGoods.GoodsSizeId


     WHERE (Object_GoodsPrint.UserId = inUserId OR inUserId = 0)
       AND (Object_GoodsPrint.UnitId = inUnitId OR inUnitId = 0)
     ORDER BY Object_User.ValueData
            , Object_Unit.ValueData
            , Object_GoodsPrint.Id
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.    ��������� �.�.
17.08.17          *
*/

-- ����
-- SELECT * FROM gpSelect_Object_GoodsPrint (inUnitId:=0, inUserId:= 0, inSession:=zfCalc_UserAdmin())
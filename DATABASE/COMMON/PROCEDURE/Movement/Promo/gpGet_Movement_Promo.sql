-- Function: gpGet_Movement_Promo()

DROP FUNCTION IF EXISTS gpGet_Movement_Promo (Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Promo(
    IN inMovementId        Integer  , -- ���� ���������
    IN inOperDate          TDateTime, -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id               Integer     --�������������
             , InvNumber        Integer    --����� ���������
             , OperDate         TDateTime   --���� ���������
             , StatusCode       Integer     --��� �������
             , StatusName       TVarChar    --������
             , PromoKindId      Integer     --��� �����
             , PromoKindName    TVarChar    --��� �����
             , PriceListId      Integer     --����� ����
             , PriceListName    TVarChar    --����� ����
             , StartPromo       TDateTime   --���� ������ �����
             , EndPromo         TDateTime   --���� ��������� �����
             , StartSale        TDateTime   --���� ������ �������� �� ��������� ����
             , EndSale          TDateTime   --���� ��������� �������� �� ��������� ����
             , EndReturn        TDateTime   --���� ��������� ��������� �� ��������� ����
             , OperDateStart    TDateTime   --���� ������ ����. ������ �� �����
             , OperDateEnd      TDateTime   --���� ��������� ����. ������ �� �����
             , MonthPromo       TDateTime   --����� �����
             , CheckDate        TDateTime   --���� ������������
             , CostPromo        TFloat      --��������� ������� � �����
             , Comment          TVarChar    --����������
             , CommentMain      TVarChar    --���������� (�����)
             , UnitId           INTEGER     --�������������
             , UnitName         TVarChar    --�������������
             , PersonalTradeId  INTEGER     --������������� ������������� ������������� ������
             , PersonalTradeName TVarChar   --������������� ������������� ������������� ������
             , PersonalId       INTEGER     --������������� ������������� �������������� ������	
             , PersonalName     TVarChar    --������������� ������������� �������������� ������	
             , isPromo          Boolean     --����� (��/���)
             , Checked          Boolean     --����������� (��/���)
             , strSign          TVarChar    -- ��� �������������. - ���� ��. �������
             , strSignNo        TVarChar    -- ��� �������������. - ��������� ��. �������
             )
AS
$BODY$
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_Promo());
    IF COALESCE (inMovementId, 0) = 0
    THEN
        RETURN QUERY
        SELECT
            0                                                 AS Id
          , CAST (NEXTVAL ('movement_Promo_seq') AS Integer)  AS InvNumber
          , inOperDate	                                      AS OperDate
          , Object_Status.Code               	              AS StatusCode
          , Object_Status.Name              		      AS StatusName
          , NULL::Integer                                     AS PromoKindId         --��� �����
          , NULL::TVarChar                                    AS PromoKindName       --��� �����
          , Object_PriceList.Id                               AS PriceListId         --����� ����
          , Object_PriceList.ValueData                        AS PriceListName       --����� ����
          , NULL::TDateTime                                   AS StartPromo          --���� ������ �����
          , NULL::TDateTime                                   AS EndPromo            --���� ��������� �����
          , NULL::TDateTime                                   AS StartSale           --���� ������ �������� �� ��������� ����
          , NULL::TDateTime                                   AS EndSale             --���� ��������� �������� �� ��������� ����
          , NULL::TDateTime                                   AS EndReturn           --���� ��������� ��������� �� ��������� ����
          , NULL::TDateTime                                   AS OperDateStart       --���� ������ ����. ������ �� �����
          , NULL::TDateTime                                   AS OperDateEnd         --���� ��������� ����. ������ �� �����
          , NULL::TDateTime                                   AS MonthPromo          --����� �����
          , inOperDate                                        AS CheckDate           --���� ������������
          , NULL::TFloat                                      AS CostPromo           --��������� ������� � �����
          , NULL::TVarChar                                    AS Comment             --����������
          , NULL::TVarChar                                    AS CommentMain         --���������� (�����)
          , NULL::Integer                                     AS UnitId              --�������������
          , NULL::TVarChar                                    AS UnitName            --�������������
          , NULL::Integer                                     AS PersonalTradeId     --������������� ������������� ������������� ������
          , NULL::TVarChar                                    AS PersonalTradeName   --������������� ������������� ������������� ������
          , NULL::Integer                                     AS PersonalId          --������������� ������������� �������������� ������	
          , NULL::TVarChar                                    AS PersonalName        --������������� ������������� �������������� ������
          , CAST (TRUE  AS Boolean)                           AS isPromo
          , CAST (FALSE AS Boolean)         		      AS Checked
          , NULL::TVarChar                                    AS strSign
          , NULL::TVarChar                                    AS strSignNo
        FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status
            LEFT OUTER JOIN Object AS Object_PriceList ON Object_PriceList.Id = zc_PriceList_Basis();
    ELSE
        RETURN QUERY
        SELECT
            Movement_Promo.Id                 --�������������
          , Movement_Promo.InvNumber          --����� ���������
          , Movement_Promo.OperDate           --���� ���������
          , Movement_Promo.StatusCode         --��� �������
          , Movement_Promo.StatusName         --������
          , Movement_Promo.PromoKindId        --��� �����
          , Movement_Promo.PromoKindName      --��� �����
          , Movement_Promo.PriceListId        --��� �����
          , Movement_Promo.PriceListName      --��� �����
          , Movement_Promo.StartPromo         --���� ������ �����
          , Movement_Promo.EndPromo           --���� ��������� �����
          , Movement_Promo.StartSale          --���� ������ �������� �� ��������� ����
          , Movement_Promo.EndSale            --���� ��������� �������� �� ��������� ����
          , Movement_Promo.EndReturn          --���� ��������� ��������� �� ��������� ����
          , Movement_Promo.OperDateStart      --���� ������ ����. ������ �� �����
          , Movement_Promo.OperDateEnd        --���� ��������� ����. ������ �� �����
          , Movement_Promo.MonthPromo         -- ����� �����
          , Movement_Promo.CheckDate          --���� ������������
          , Movement_Promo.CostPromo          --��������� ������� � �����
          , Movement_Promo.Comment            --����������
          , Movement_Promo.CommentMain        --���������� (�����)
          , Movement_Promo.UnitId             --�������������
          , Movement_Promo.UnitName           --�������������
          , Movement_Promo.PersonalTradeId    --������������� ������������� ������������� ������
          , Movement_Promo.PersonalTradeName  --������������� ������������� ������������� ������
          , Movement_Promo.PersonalId         --������������� ������������� �������������� ������	
          , Movement_Promo.PersonalName       --������������� ������������� �������������� ������
          , Movement_Promo.isPromo            --�����
          , Movement_Promo.Checked            --�����������
          , tmpSign.strSign
          , tmpSign.strSignNo             
        FROM Movement_Promo_View AS Movement_Promo
             LEFT JOIN lpSelect_MI_Promo_Sign (inMovementId:= Movement_Promo.Id ) AS tmpSign ON tmpSign.Id = Movement_Promo.Id   -- ��.�������  --
        WHERE Movement_Promo.Id =  inMovementId;
    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Movement_Promo (Integer, TDateTime, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 01.08.17         * CheckedDate
 25.07.17         *
 13.10.15                                                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_Promo (inMovementId:= 1, inOperDate:= '30.11.2015', inSession:= zfCalc_UserAdmin())

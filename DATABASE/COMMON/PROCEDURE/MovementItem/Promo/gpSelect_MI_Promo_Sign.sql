-- Function: gpSelect_MI_Promo_Sign (Integer, Boolean, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_MI_Promo_Sign (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_Promo_Sign(
    IN inMovementId  Integer      , -- ���� ���������
    IN inIsErased    Boolean      , -- 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, SignInternalId Integer, SignInternalName TVarChar
             , Ord Integer
             , UserId Integer, UserCode Integer, UserName TVarChar
             , OperDate TDateTime
             , isSign Boolean
             , isErased Boolean
              )
AS
$BODY$
  DECLARE vbUserId Integer;

  DECLARE vbMovementDescId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MI_Promo());
     vbUserId := inSession;


     -- ��������� �� ��������� - ��� ����������� <������ ����������� �������>
     SELECT Movement.DescId  AS MovementDescId
            INTO vbMovementDescId
     FROM Movement
     WHERE Movement.Id = inMovementId;

     
     -- ���������
     RETURN QUERY 
        WITH -- ������ �� ������ ��� ������� ���������
             tmpObject AS (SELECT * FROM lpSelect_Object_SignInternalItem (vbMovementDescId, 0, 0))
             -- ������ �� ��� ����������� ��������� �������
           , tmpMI AS (SELECT MovementItem.Id
                            , MovementItem.ObjectId   AS SignInternalId
                            , MovementItem.Amount     AS Ord
                            , MILO_Insert.ObjectId    AS UserId
                            , MIDate_Insert.ValueData AS OperDate
                            , MovementItem.isErased
                       FROM MovementItem
                            LEFT JOIN MovementItemDate AS MIDate_Insert
                                                       ON MIDate_Insert.MovementItemId = MovementItem.Id
                                                      AND MIDate_Insert.DescId = zc_MIDate_Insert()
                            LEFT JOIN MovementItemLinkObject AS MILO_Insert
                                                             ON MILO_Insert.MovementItemId = MovementItem.Id
                                                            AND MILO_Insert.DescId = zc_MILinkObject_Insert()
                       WHERE MovementItem.MovementId = inMovementId
                         AND MovementItem.DescId     = zc_MI_Sign()
                      )
     -- ���������
     SELECT tmpMI.Id                      AS Id
          , Object_SignInternal.Id        AS SignInternalId
          , Object_SignInternal.ValueData AS SignInternalName
       
          , COALESCE (tmpMI.Ord, tmpObject.Ord) :: Integer AS Ord
          , Object_User.Id         AS UserId
          , Object_User.ObjectCode AS UserCode
          , Object_User.ValueData  AS UserName
 
          , tmpMI.OperDate
       
          , CASE WHEN tmpMI.Ord > 0 THEN TRUE ELSE FALSE END AS isSign

          , COALESCE (tmpMI.isErased, FALSE) AS isErased
     FROM tmpObject
          FULL JOIN tmpMI ON tmpMI.SignInternalId = tmpObject.SignInternalId
                         AND tmpMI.UserId         = tmpObject.UserId
                         AND tmpMI.isErased       = FALSE
          LEFT JOIN Object AS Object_SignInternal ON Object_SignInternal.Id = COALESCE (tmpObject.SignInternalId, tmpMI.SignInternalId)
          LEFT JOIN Object AS Object_User         ON Object_User.Id         = COALESCE (tmpObject.UserId,         tmpMI.UserId)
     ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.08.16         * 
*/

-- ����
-- SELECT * FROM gpSelect_MI_Promo_Sign (inMovementId:= 4135607, inIsErased:= TRUE,  inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MI_Promo_Sign (inMovementId:= 4135607, inIsErased:= FALSE, inSession:= zfCalc_UserAdmin())

-- Function: gpSelect_MI_IncomeFuel_Child (Integer, Boolean, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_MI_IncomeFuel_Child (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_IncomeFuel_Child(
    IN inMovementId  Integer      , -- ���� ���������
    IN inIsErased    Boolean      , -- 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, RouteMemberId Integer, RouteMemberCode TVarChar, RouteMemberName TBlob
             , OperDate TDateTime
             , Amount TFloat, StartOdometre TFloat, EndOdometre TFloat
             , Distance_calc TFloat
             , isErased Boolean
              )
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MI_IncomeFuel());
     vbUserId := inSession;

     RETURN QUERY 
       SELECT
             MovementItem.Id
           , Object_RouteMember.Id                      AS RouteMemberId
           , Object_RouteMember.ObjectCode ::TVarChar   AS RouteMemberCode
           , OB_RouteMember_Description.ValueData       AS RouteMemberName
           , MIDate_OperDate.ValueData                  AS OperDate
           , MovementItem.Amount
           , MIFloat_StartOdometre.ValueData    AS StartOdometre
           , MIFloat_EndOdometre.ValueData      AS EndOdometre

           , CAST ((MIFloat_EndOdometre.ValueData -MIFloat_StartOdometre.ValueData)  AS TFloat) AS Distance_calc

           , MovementItem.isErased

       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                             AND MovementItem.DescId     = zc_MI_Child()
                             AND MovementItem.isErased   = tmpIsErased.isErased
            LEFT JOIN MovementItemFloat AS MIFloat_StartOdometre
                                        ON MIFloat_StartOdometre.MovementItemId = MovementItem.Id
                                       AND MIFloat_StartOdometre.DescId = zc_MIFloat_StartOdometre()
            LEFT JOIN MovementItemFloat AS MIFloat_EndOdometre
                                        ON MIFloat_EndOdometre.MovementItemId = MovementItem.Id
                                       AND MIFloat_EndOdometre.DescId = zc_MIFloat_EndOdometre()
            LEFT JOIN Object AS Object_RouteMember ON Object_RouteMember.Id =  MovementItem.ObjectId 
            LEFT JOIN ObjectBlob AS OB_RouteMember_Description
                                 ON OB_RouteMember_Description.ObjectId =  Object_RouteMember.Id
                                AND OB_RouteMember_Description.DescId = zc_ObjectBlob_RouteMember_Description()

            LEFT JOIN MovementItemDate AS MIDate_OperDate
                                        ON MIDate_OperDate.MovementItemId = MovementItem.Id
                                       AND MIDate_OperDate.DescId = zc_MIDate_OperDate()

      ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MI_IncomeFuel_Child (Integer, Boolean, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.01.16         * 
 
*/

-- ����
-- SELECT * FROM gpSelect_MI_IncomeFuel_Child (inMovementId:= 25173, inIsErased:= TRUE, inSession:= '2')
-- SELECT * FROM gpSelect_MI_IncomeFuel_Child (inMovementId:= 25173, inIsErased:= FALSE, inSession:= '2')
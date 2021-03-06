-- Function: gpUpdate_Movement_Income_OrderExternalOrdspr 

DROP FUNCTION IF EXISTS gpUpdate_Movement_Income_OrderExternal (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Movement_Income_OrderExternal (
    IN inId                  Integer   , -- Ключ объекта <Документ>
    IN inOrderExternalId     Integer   , -- 
    IN inSession             TVarChar    -- сессия пользователя
)
RETURNS Void 
AS
$BODY$
    DECLARE vbUserId Integer;
BEGIN
     -- проверка
     -- проверка прав пользователя на вызов процедуры
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Sale());
     vbUserId:= lpGetUserBySession (inSession);
      
     -- сохранили связь с <документом заявка поставщику>
     PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_Order(), inId, inOrderExternalId);

     -- сохранили протокол
     PERFORM lpInsert_MovementProtocol (inId, vbUserId, FALSE);
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Манько Д.
 06.05.16         * 
*/


-- тест
-- SELECT * FROM gpUpdate_Movement_Income_OrderExternal (inId:= 1898475 , inOrderExternalId := 1659212 , inSession:= '5')

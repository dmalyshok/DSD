-- Function: lpInsertUpdate_Object_ContractSettings()

DROP FUNCTION IF EXISTS lpInsertUpdate_Object_ContractSettings(Integer, TVarChar);
DROP FUNCTION IF EXISTS lpInsertUpdate_Object_ContractSettings(Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object_ContractSettings(
        IN inMainJuridicalId   Integer   ,    -- ��. ��. ����
        IN inContractId        Integer   ,    -- �������
       OUT outisErased         Boolean   ,
        IN inSession           TVarChar       -- ������ ������������
)
RETURNS Boolean
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbId Integer;
BEGIN

   vbUserId:= inSession;
   --vbObjectId := lpGet_DefaultValue('zc_Object_MainJuridical', vbUserId);

   -- ���� ������� <��������� ��� ���������> �� ����� ����.���� - �������
   vbId := (SELECT ObjectLink_MainJuridical.ObjectId AS Id
            FROM ObjectLink AS ObjectLink_MainJuridical
                 INNER JOIN ObjectLink AS ObjectLink_Contract
                                       ON ObjectLink_Contract.ObjectId = ObjectLink_MainJuridical.ObjectId
                                      AND ObjectLink_Contract.DescId = zc_ObjectLink_ContractSettings_Contract()
                                      AND ObjectLink_Contract.ChildObjectId = inContractId
            WHERE ObjectLink_MainJuridical.DescId = zc_ObjectLink_ContractSettings_MainJuridical()
              AND ObjectLink_MainJuridical.ChildObjectId = inMainJuridicalId
            );

   IF COALESCE (vbId, 0) = 0 -- ���� ����� �� ����������, ����� ������� ��
   THEN
        -- ��������� <������>
        vbId := lpInsertUpdate_Object (0, zc_Object_ContractSettings(), 0, '');
      
        -- ��������� ����� <��. ��. ����>
        PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_ContractSettings_MainJuridical(), vbId, inMainJuridicalId);
        -- ��������� ����� <�������>
        PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_ContractSettings_Contract(), vbId, inContractId);
     
   END IF;

   -- ��������
   PERFORM lpUpdate_Object_isErased (inObjectId:= vbId, inUserId:= vbUserId);
   
   outisErased := (SELECT Object.isErased FROM Object WHERE Object.Id = vbId AND Object.DescId = zc_Object_ContractSettings());

   -- ��������� �������� -
   PERFORM lpInsert_ObjectProtocol (vbId, vbUserId);
 

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.11.16         *
*/

-- ����
-- 
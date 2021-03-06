-- Function: gpInsertUpdate_Object_MemberSP()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_MemberSP (Integer, Integer, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_MemberSP (Integer, Integer, TVarChar, Integer, Integer, TDateTime, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_MemberSP (Integer, Integer, TVarChar, Integer, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_MemberSP(
 INOUT ioId	             Integer   ,    -- ���� ������� <����������� ����� ���������� ������ (���. ������)> 
    IN inCode                Integer   ,    -- ��� ������� 
    IN inName                TVarChar  ,    -- �������� ������� <>
    IN inPartnerMedicalId    Integer   ,    -- ���. ������.
    IN inGroupMemberSPId     Integer   ,    -- ��������� ���.
--    IN inHappyDate           TDateTime ,    -- ���� ��������
    IN inHappyDate           TVarChar ,    -- ���� ��������
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   
   DECLARE vbHappyDate TDateTime;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId := PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_MemberSP());
   vbUserId := inSession;
   
    -- �������� ����� ���
   IF ioId <> 0 AND COALESCE (inCode, 0) = 0 THEN inCode := (SELECT ObjectCode FROM Object WHERE Id = ioId); END IF;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_MemberSP());
   
   -- �������� ���������� ���.������.
   IF COALESCE (inPartnerMedicalId, 0) = 0
   THEN
       RAISE EXCEPTION '������.�������� <����������� ����������> �� �����������.';
   END IF;
   -- �������� ������������ <������������>
   --PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_MemberSP(), inName);
   IF EXISTS (SELECT 1 
              FROM Object AS Object_MemberSP
                   LEFT JOIN ObjectLink AS OL_PartnerMedical
                          ON OL_PartnerMedical.ObjectId = Object_MemberSP.Id
                         AND OL_PartnerMedical.DescId = zc_ObjectLink_MemberSP_PartnerMedical()
              WHERE Object_MemberSP.DescId = zc_Object_MemberSP()
                AND Object_MemberSP.ValueData = TRIM(inName)
                AND OL_PartnerMedical.ChildObjectId = inPartnerMedicalId
                AND Object_MemberSP.Id <> ioId
              )
   THEN
       RAISE EXCEPTION '������.�������� <%> �� ��������� ��� �����������' , inName;
   END IF;
   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_MemberSP(), vbCode_calc);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_MemberSP(), vbCode_calc, inName);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_MemberSP_PartnerMedical(), ioId, inPartnerMedicalId);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_MemberSP_GroupMemberSP(), ioId, inGroupMemberSPId);   

   -- ��������� �������� <>
   IF COALESCE (inHappyDate, '') <> ''
      THEN
          vbHappyDate := ('01.01.' || TRIM (inHappyDate)) :: TDatetime;   -- ������ ������ ��� ��������, ������� ��� ���� ��������� 01,01
          PERFORM lpInsertUpdate_ObjectDate( zc_ObjectDate_MemberSP_HappyDate(), ioId, vbHappyDate);
   END IF;
   
      
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);
   
END;$BODY$

LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.02.18         *
 18.01.18         *
 14.02.17         * 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_MemberSP()

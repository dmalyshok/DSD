-- Function: gpGet_Movement_Email_FileName(Integer, TVarChar)

-- DROP FUNCTION IF EXISTS gpGet_Movement_XML_FileName (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Movement_Email_FileName (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Email_FileName(
   OUT outFileName            TVarChar  ,
   OUT outDefaultFileExt      TVarChar  ,
   OUT outEncodingANSI        Boolean   ,
    IN inMovementId           Integer   ,
    IN inSession              TVarChar
)
  RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_XML_Mida());
     vbUserId:= lpGetUserBySession (inSession);


     -- ���������
     SELECT tmp.outFileName, tmp.outDefaultFileExt, tmp.outEncodingANSI
            INTO outFileName, outDefaultFileExt, outEncodingANSI
     FROM
    (WITH tmpExportJuridical AS (SELECT DISTINCT tmp.PartnerId, tmp.ExportKindId FROM lpSelect_Object_ExportJuridical_list() AS tmp)
     SELECT CASE WHEN tmpExportJuridical.ExportKindId = zc_Enum_ExportKind_Mida35273055()
                      THEN COALESCE (ObjectString_GLNCode.ValueData, '')
                 || '_' || REPLACE (zfConvert_DateShortToString (MovementDate_OperDatePartner.ValueData), '.', '')
                 || '_' || Movement.InvNumber
                 -- || '.xml'
                 WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Vez37171990(), zc_Enum_ExportKind_Brusn34604386())
                      THEN COALESCE (Object_JuridicalBasis.ValueData, 'Alan')
                 || '_' || Movement.InvNumber
                 || '_' || COALESCE (Object_Retail.ValueData, '�������� ����') || ' �' || CASE WHEN tmpExportJuridical.ExportKindId = zc_Enum_ExportKind_Brusn34604386()
                                                                                                    THEN Object_Partner.Id :: TVarChar -- COALESCE (ObjectString_RoomNumber.ValueData, '0')
                                                                                               ELSE COALESCE (ObjectString_RoomNumber.ValueData, '0')
                                                                                          END
                 WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Dakort39135074())
                      THEN COALESCE (Object_JuridicalBasis.ValueData, 'Alan')
                 || '_' || Movement.InvNumber
                 --|| '_' || COALESCE (Object_Retail.ValueData, '�������� ����') || ' �' || CASE WHEN tmpExportJuridical.ExportKindId = zc_Enum_ExportKind_Brusn34604386()
                 --                                                                                   THEN Object_Partner.Id :: TVarChar -- COALESCE (ObjectString_RoomNumber.ValueData, '0')
                 --                                                                              ELSE COALESCE (ObjectString_RoomNumber.ValueData, '0')
                 --                                                                         END
                 --|| '_' || zfConvert_DateShortToString (MovementDate_OperDatePartner.ValueData)
                 -- || '.csv'
                 
            END AS outFileName
          , CASE WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Mida35273055(), zc_Enum_ExportKind_Brusn34604386())
                      THEN 'xml'
                 WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Vez37171990(), zc_Enum_ExportKind_Dakort39135074())
                      THEN 'csv'
            END AS outDefaultFileExt
          , CASE WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Mida35273055(), zc_Enum_ExportKind_Brusn34604386())
                      THEN FALSE
                 WHEN tmpExportJuridical.ExportKindId IN (zc_Enum_ExportKind_Vez37171990(), zc_Enum_ExportKind_Dakort39135074())
                      THEN TRUE
            END AS outEncodingANSI
     FROM Movement
          LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                 ON MovementDate_OperDatePartner.MovementId = Movement.Id
                                AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                       ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                      AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                       ON MovementLinkObject_Contract.MovementId = Movement.Id
                                      AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
          LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalDocument
                               ON ObjectLink_Contract_JuridicalDocument.ObjectId = MovementLinkObject_Contract.ObjectId
                              AND ObjectLink_Contract_JuridicalDocument.DescId = zc_ObjectLink_Contract_JuridicalDocument()
                              AND MovementLinkObject_PaidKind.ObjectId = zc_Enum_PaidKind_SecondForm()
          LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis
                               ON ObjectLink_Contract_JuridicalBasis.ObjectId = MovementLinkObject_Contract.ObjectId
                              AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
          LEFT JOIN Object AS Object_JuridicalBasis ON Object_JuridicalBasis.Id = COALESCE (ObjectLink_Contract_JuridicalDocument.ChildObjectId, ObjectLink_Contract_JuridicalBasis.ChildObjectId)

          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                       ON MovementLinkObject_To.MovementId = Movement.Id
                                      AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()

          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = CASE WHEN Movement.DescId = zc_Movement_Sale() THEN MovementLinkObject_To.ObjectId ELSE MovementLinkObject_From.ObjectId END
          LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                               ON ObjectLink_Partner_Juridical.ObjectId = Object_Partner.Id
                              AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
          LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                               ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                              AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
          LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId

          LEFT JOIN ObjectString AS ObjectString_RoomNumber
                                 ON ObjectString_RoomNumber.ObjectId = Object_Partner.Id
                                AND ObjectString_RoomNumber.DescId = zc_ObjectString_Partner_RoomNumber()
                                AND ObjectString_RoomNumber.ValueData <> ''
          LEFT JOIN ObjectString AS ObjectString_GLNCode
                                 ON ObjectString_GLNCode.ObjectId = Object_Partner.Id
                                AND ObjectString_GLNCode.DescId = zc_ObjectString_Partner_GLNCode()
          LEFT JOIN tmpExportJuridical ON tmpExportJuridical.PartnerId = Object_Partner.Id
     WHERE Movement.Id = inMovementId) AS tmp
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 23.03.16                                        *
 25.02.16                                        *
*/


-- ����
-- SELECT * FROM gpGet_Movement_Email_FileName (inMovementId:= 3376510, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Mida35273055()
-- SELECT * FROM gpGet_Movement_Email_FileName (inMovementId:= 3252496, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Vez37171990()
-- SELECT * FROM gpGet_Movement_Email_FileName (inMovementId:= 3438890, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Brusn34604386()

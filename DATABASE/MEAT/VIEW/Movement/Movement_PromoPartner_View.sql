DROP VIEW IF EXISTS Movement_PromoPartner_View;

CREATE OR REPLACE VIEW Movement_PromoPartner_View AS 
    SELECT       
        Movement_Promo.Id                                                 --�������������
      , Movement_Promo.ParentId                                           --������ �� �������� �������� <�����> (zc_Movement_Promo)
      , MovementLinkObject_Partner.ObjectId    AS PartnerId               --���������� ��� �����
      , Object_Partner.ObjectCode              AS PartnerCode             --���������� ��� �����
      , Object_Partner.ValueData               AS PartnerName             --���������� ��� �����
      , Object_Partner.DescId                  AS PartnerDescId           --��� ���������� ��� �����
      , ObjectDesc_Partner.ItemName            AS PartnerDescName         --��� ���������� ��� �����
      , Object_Juridical.ValueData             AS Juridical_Name
      , Object_Retail.ValueData                AS Retail_Name
      , CASE 
            WHEN Movement_Promo.StatusId = zc_Enum_Status_Erased()
                THEN TRUE
        ELSE FALSE
        END                                    AS isErased                --������
            
    FROM Movement AS Movement_Promo 

        LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                     ON MovementLinkObject_Partner.MovementId = Movement_Promo.Id
                                    AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
        LEFT JOIN Object AS Object_Partner 
                         ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId
        LEFT OUTER JOIN ObjectDesc AS ObjectDesc_Partner
                                   ON ObjectDesc_Partner.Id = Object_Partner.DescId
        LEFT OUTER JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                   ON ObjectLink_Partner_Juridical.ObjectId = Object_Partner.Id
                                  AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                                  AND Object_Partner.DescId = zc_Object_Partner()
        LEFT OUTER JOIN Object AS Object_Juridical
                               ON Object_Juridical.id = ObjectLink_Partner_Juridical.ChildObjectId
                              AND Object_Juridical.DescId = zc_Object_Juridical()
        LEFT OUTER JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                   ON ObjectLink_Juridical_Retail.ObjectId = CASE 
                                                                                 WHEN Object_Partner.DescId = zc_Object_Partner() THEN Object_Juridical.Id
                                                                                 WHEN Object_Partner.DescId = zc_Object_Juridical() THEN Object_Partner.Id
                                                                             END
                                  AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                                  AND Object_Partner.DescId in (zc_Object_Partner(),zc_Object_Juridical())
        LEFT OUTER JOIN Object AS Object_Retail
                               ON Object_Retail.id = ObjectLink_Juridical_Retail.ChildObjectId
                              AND Object_Retail.DescId = zc_Object_Retail() 
    WHERE Movement_Promo.DescId = zc_Movement_Promo()
      AND Movement_Promo.ParentId is not null;

ALTER TABLE Movement_Promo_View
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ��������� �.�.
 31.10.15                                                         * 
*/

-- ����
-- SELECT * FROM Movement_Promo_View  where id = 805
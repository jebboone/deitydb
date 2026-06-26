BEGIN;
UPDATE entity_citations SET quote='Nuadu Argetlam son of Echtach s. Etarlam was king among the Tuatha De Danann at that time.', evidence_grade='primary-verbatim', work_title='Lebor Gabála Érenn (Macalister, Vol. IV)', translator='R. A. S. Macalister', translation_year=1941, source_url='https://archive.org/details/leborgablare04macauoft', verify_method='pointer→verbatim upgrade; substring-gated against Macalister Vol. IV OCR (English-translation regions); eyeballed for Irish/apparatus/OCR-column bleed', verified_on=DATE '2026-06-26' WHERE citation_id='CIT_CEL_NUADA_SEC';
COMMIT;

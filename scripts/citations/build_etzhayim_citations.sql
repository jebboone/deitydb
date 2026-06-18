INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,original_text_url,evidence_grade,evidence_note,needs_review,review_reason,verified_on,verify_method,display_order) VALUES

ON CONFLICT (citation_id) DO UPDATE SET quote=EXCLUDED.quote,locus=EXCLUDED.locus,verify_method=EXCLUDED.verify_method;

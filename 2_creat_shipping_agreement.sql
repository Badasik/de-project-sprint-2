DROP TABLE IF EXISTS public.shipping_agreement CASCADE;

--shipping_agreement
CREATE TABLE public.shipping_aggreement(
	agreementid				    BIGINT,
	agreement_number			TEXT,
	agreement_rate    			NUMERIC(14,3),
	agreement_comission			NUMERIC(14,3),
	PRIMARY KEY (agreementid)
);

INSERT INTO public.shipping_aggreement (agreementid, agreement_number, agreement_rate, agreement_comission )
SELECT  description[1]::BIGINT, description[2], description[3]::NUMERIC(14,3), description[4]::NUMERIC(14,3)
  FROM (
		SELECT distinct (regexp_split_to_array(vendor_agreement_description , E'\\:+')) as description
  		  FROM public.shipping s) AS a
ORDER BY 1;


--SELECT *
--  FROM public.shipping_aggreement sa;
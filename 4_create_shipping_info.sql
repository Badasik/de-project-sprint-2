DROP TABLE IF EXISTS public.shipping_info CASCADE;

--shipping_info
CREATE TABLE public.shipping_info (
	shippingid					BIGINT,
	vendorid					BIGINT,
	payment_amount				NUMERIC(14,2),
	shipping_plan_datetime		TIMESTAMP,
	transfer_type_id 			BIGINT,
	shipping_country_id			BIGINT,
	agreementid					BIGINT,
	PRIMARY KEY (shippingid),
	FOREIGN KEY (transfer_type_id) REFERENCES public.shipping_transfer(transfer_type_id) ON UPDATE CASCADE,
	FOREIGN KEY (shipping_country_id) REFERENCES public.shipping_country_rates(shipping_country_id) ON UPDATE CASCADE,
	FOREIGN KEY (agreementid) REFERENCES public.shipping_aggreement(agreementid) ON UPDATE CASCADE
);


INSERT INTO public.shipping_info(shippingid, 
								  shipping_plan_datetime,
								  vendorid,
								  payment_amount,
								  agreementid,
								  shipping_country_id,
								  transfer_type_id)
SELECT DISTINCT shippingid, 
				shipping_plan_datetime, 
				vendorid, 
				payment_amount,
				(regexp_split_to_array(vendor_agreement_description , E'\\:+'))[1]::BIGINT, 
				scr.shipping_country_id,
				st.transfer_type_id 
  FROM public.shipping s
  INNER JOIN public.shipping_country_rates scr ON scr.shipping_country = s.shipping_country 
  INNER JOIN public.shipping_transfer st ON st.transfer_type = (regexp_split_to_array(shipping_transfer_description  , E'\\:+'))[1]
  										    AND st.transfer_model = (regexp_split_to_array(shipping_transfer_description  , E'\\:+'))[2] 
  ;
  

--SELECT count(*)
--  FROM public.shipping_info si;
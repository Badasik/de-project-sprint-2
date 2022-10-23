DROP TABLE IF EXISTS public.shipping_transfer CASCADE; 

--shipping_transfer
CREATE TABLE public.shipping_transfer(
	transfer_type_id			SERIAL,
	transfer_type				TEXT,
	transfer_model				TEXT,
	shipping_transfer_rate   	NUMERIC(14,3),
	PRIMARY KEY (transfer_type_id)
);

INSERT INTO public.shipping_transfer (transfer_type, transfer_model, shipping_transfer_rate)
SELECT description[1], description[2], shipping_transfer_rate 
  FROM (
		SELECT DISTINCT regexp_split_to_array(shipping_transfer_description  , E'\\:+') AS description, shipping_transfer_rate 
  		  FROM public.shipping s) AS a;
  		 
  		 
--SELECT *
--  FROM public.shipping_transfer st;
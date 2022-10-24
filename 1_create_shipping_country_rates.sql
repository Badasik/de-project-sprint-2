DROP TABLE IF EXISTS public.shipping_country_rates CASCADE;


--shipping_country_rate
CREATE TABLE public.shipping_country_rates(
	shipping_country_id 		SERIAL,
	shipping_country			TEXT,
	shipping_country_base_rate	NUMERIC(14,3),
	PRIMARY KEY (shipping_country_id)
);

CREATE INDEX shipping_country_rate_id ON public.shipping_country_rates(shipping_country_id);

INSERT INTO public.shipping_country_rates (shipping_country, shipping_country_base_rate)
SELECT DISTINCT shipping_country, shipping_country_base_rate
  FROM public.shipping s;


SELECT *
  FROM public.shipping_country_rates sr
 LIMIT 10;
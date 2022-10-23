CREATE OR REPLACE VIEW shipping_datamart AS 
SELECT si.shippingid,
	   si.vendorid,
       st.transfer_type,
       CASE
       	   WHEN status = 'finished' THEN date_part('day',age(shipping_end_fact_datetime,shipping_start_fact_datetime))
       	   ELSE  NULL
       END AS full_day_at_shipping,
       CASE
       	   WHEN ss.shipping_end_fact_datetime > si.shipping_plan_datetime THEN 1
       	   ELSE 0
       END AS is_delay,
       CASE 
       	   WHEN status = 'finished' THEN 1
       	   ELSE 0
       END AS is_shipping_finish,
       CASE 
       	   WHEN ss.shipping_end_fact_datetime > si.shipping_plan_datetime THEN date_part('day',age(shipping_end_fact_datetime,shipping_plan_datetime))
           ELSE 0
       END AS delay_day_at_shipping,
       si.payment_amount,
       si.payment_amount * (scr.shipping_country_base_rate + sa.agreement_rate  + st.shipping_transfer_rate) AS vat,
       si.payment_amount * sa.agreement_comission AS profit
  FROM public.shipping_info si 
 INNER JOIN public.shipping_transfer st ON st.transfer_type_id = si.transfer_type_id
 INNER JOIN public.shipping_status ss ON ss.shippingid = si.shippingid
 INNER JOIN public.shipping_aggreement sa ON sa.agreementid =si.agreementid 
 INNER JOIN public.shipping_country_rates scr ON scr.shipping_country_id = si.shipping_country_id 
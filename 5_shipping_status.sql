DROP TABLE IF EXISTS public.shipping_status CASCADE;

--shipping_status
CREATE TABLE public.shipping_status(
	shippingid						BIGINT,
	status							TEXT,
	state							TEXT,
	shipping_start_fact_datetime	TIMESTAMP,
	shipping_end_fact_datetime		TIMESTAMP,
	PRIMARY KEY (shippingid)
	--FOREIGN KEY (shippingid) REFERENCES public.shipping(shippingid) ON UPDATE CASCADE
)


INSERT INTO public.shipping_status (shippingid,
									status,
									state,
									shipping_start_fact_datetime,
									shipping_end_fact_datetime)  
  WITH cte1 AS (
		  SELECT shippingid, state_datetime, state 
	        FROM public.shipping s2 
	       WHERE state = 'booked'),
	   cte2 AS (
	 	  SELECT shippingid, state_datetime, state 
	        FROM public.shipping s2 
	       WHERE state = 'recieved'),
	   cte3 AS (
	   	  SELECT shippingid, max(state_datetime) AS state_datetime 
	   	    FROM public.shipping s3 
	   	   GROUP BY 1)
SELECT s.shippingid, s.status, s.state, ct1.state_datetime, ct2.state_datetime
  FROM cte3 AS ct3
  LEFT JOIN public.shipping s ON s.state_datetime = ct3.state_datetime 
  LEFT JOIN cte1 ct1 ON s.shippingid = ct1.shippingid   
  LEFT JOIN cte2 ct2 ON s.shippingid = ct2.shippingid AND s.state = ct2.state

  --SELECT *
  -- FROM public.shipping_status ss;
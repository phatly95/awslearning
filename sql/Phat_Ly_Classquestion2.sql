with cal_cust as (SELECT 
	tf.tran_date, 
	tf.stat_cd, 
	SUM(population_cnt) OVER (PARTITION BY tf.tran_date ORDER BY tf.stat_cd) AS Total_Cust,
	SUM(potential_customer_cnt) OVER (PARTITION BY tf.tran_date ORDER BY tf.stat_cd) AS Total_Poten
FROM cards_ingest.tran_fact AS tf
JOIN lkp_data.lkp_state_details AS sd 
ON sd.stat_cd = tf.stat_cd),
pol_cust as (
SELECT 
	tran_date, 
	stat_cd,
	Total_Cust,
	Total_Poten,
	(Total_Cust - Total_Poten) * 5 AS cal_poten
FROM cal_cust),

rank_cust AS(
SELECT 
	DISTINCT tran_date, 
	stat_cd,
	Total_Cust,
	Total_Poten,
	cal_poten,
	RANK() OVER (PARTITION BY stat_cd ORDER BY cal_poten) AS rnk
FROM pol_cust)

SELECT * FROM rank_cust WHERE rnk = 2
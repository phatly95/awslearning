--show me all the tran_date,tran_ammt and total tansaction ammount per tran_date
SELECT 
	tran_date, 
	tran_ammt,
    stat_cd,
	SUM(tran_ammt) OVER (PARTITION BY tran_date) AS "total_transaction"
FROM cards_ingest.tran_fact;

--show me all the tran_date,tran_ammt and 
--total tansaction ammount per tran_date 
--and rank of the transaction ammount desc within per tran_date

SELECT 
	tran_date, 
	tran_ammt,
    stat_cd,
	RANK() OVER (PARTITION BY tran_date ORDER BY tran_ammt DESC),
	SUM(tran_ammt) OVER (PARTITION BY tran_date) AS "total_transaction"
FROM cards_ingest.tran_fact;

--show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction ammount desc within per tran_date
 --(Here you are using he question2 but filtering only for rank 2)
SELECT 
	*
FROM (
	SELECT
		tran_date, 
		tran_ammt,
        stat_cd,
		RANK() OVER (PARTITION BY tran_date ORDER BY tran_ammt DESC) AS rnk1,
		SUM(tran_ammt) OVER (PARTITION BY tran_date) AS "total_transaction"
	FROM cards_ingest.tran_fact
) AS T
WHERE rnk1 = 2;

--Join tran_fact and cust_dim_details on cust_id and tran_dt between start_date and end_date


SELECT * 
FROM cards_ingest.cust_dim_details AS cd
JOIN cards_ingest.tran_fact AS tf ON tf.cust_id = cd.cust_id
AND tran_date BETWEEN cd.start_date AND  cd.end_date;



--show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction
--ammount desc within per tran_date(Here you are using he question2 but filtering only for rank 2) and join
--cust_dim_details on cust_id and tran_dt between start_date and end_date


SELECT 
	*
FROM (
	SELECT
		tf.tran_date, 
		tf.tran_ammt,
		RANK() OVER (PARTITION BY tran_date ORDER BY tran_ammt DESC) AS rnk1,
		SUM(tran_ammt) OVER (PARTITION BY tran_date) AS "total_transaction"
	FROM cards_ingest.tran_fact AS tf
    JOIN cards_ingest.cust_dim_details AS cd ON tf.cust_id = cd.cust_id
    AND tran_date BETWEEN cd.start_date AND cd.end_date
) AS T
WHERE rnk1 = 2;

--From question 2 : when stat_cd is not euqal to state_cd then data issues else good data as stae_cd_status
--[Note NUll from left side is not equal NUll from other side  >> means lets sayd NULL value from fact table if compared
--to NULL Value to right table then it should be data issues]

SELECT
		tf.tran_date, 
		tf.tran_ammt,
        tf.stat_cd,
        tf.cust_id,
        cd.state_cd,
		RANK() OVER (PARTITION BY tran_date ORDER BY tran_ammt DESC) AS rnk1,
		SUM(tran_ammt) OVER (PARTITION BY tran_date) AS "total_transaction",
        cd.zip_cd,
        CASE 
            WHEN 
                COALESCE(stat_cd, 'AA') !=  COALESCE (state_cd, 'BB') THEN 'data issues'
            ELSE 'good data'
        END AS stae_cd_status
FROM cards_ingest.tran_fact AS tf
JOIN cards_ingest.cust_dim_details AS cd ON tf.cust_id = cd.cust_id
AND tran_date BETWEEN cd.start_date AND cd.end_date;



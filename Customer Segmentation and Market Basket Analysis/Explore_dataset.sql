--Dataset info
SELECT		COLUMN_NAME,
			DATA_TYPE,
			CHARACTER_MAXIMUM_LENGTH,
			NUMERIC_PRECISION,
			NUMERIC_SCALE,
			IS_NULLABLE
FROM		INFORMATION_SCHEMA.COLUMNS
WHERE		TABLE_NAME = 'Dataset' AND 
			TABLE_SCHEMA = 'dbo'
ORDER BY	ORDINAL_POSITION


--Backup orginal dataset
SELECT		*
INTO		Dataset_Backup
FROM		[Dissertation].[dbo].[Dataset]


--Change 'product_price' data type from decimal to float
ALTER TABLE [Dissertation].[dbo].[Dataset]
ALTER COLUMN product_price FLOAT



/* IMPUTATION PROCESS */

--Initial dataset
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]

select top 10 * from [Dissertation].[dbo].[Dataset]
select distinct user_last_order_date from [Dissertation].[dbo].[Dataset] order by 1

--574.855


--Identify all columns that contains null values
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		product_name IS NULL --135
OR			product_category IS NULL --5
OR			f0_ IS NULL --13


--Identify 'product_name' null values for non-null 'product_category' values
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) IN (
			N'Healthy Αλμυρά Snacks ',
			N'Make A Wish ',
			N'Αρνί ',
			N'Αρτοσκευάσματα ',
			N'Αυγά ',
			N'Γλυκά ',
			N'Είδη επάλειψης ',
			N'Έτοιμες Σαλάτες ',
			N'Ζύμες, Πίτες & Πίτσες ',
			N'Κρέατα & Πουλερικά ',
			N'Κρουασάν & Τσουρέκια ',
			N'Πατατάκια & Αλμυρά Snacks ',
			N'Πατατάκια & Γαριδάκια ',
			N'Προϊόντα Κρεάτων & Πουλερικών ',
			N'Σοκολάτες',
			N'Χοιρινό ',
			N'Ψωμί '
			)
AND			product_name IS NULL
ORDER BY	product_category,
			product_price
--130


--Identify 'product_name' null values for null 'product_category' values
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		product_name IS NULL
AND			product_category IS NULL
--5


--1a. Identify null product_name values for product_category 'Healthy Αλμυρά Snacks'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Healthy Αλμυρά Snacks'
AND			product_name IS NULL --(1.6)


--1b. Finding mode for non-null product_name values for product_category 'Healthy Αλμυρά Snacks'
SELECT		product_name,
			COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Healthy Αλμυρά Snacks'
AND			product_name IS NOT NULL
AND			product_price = '1.6'
GROUP BY	product_name
ORDER BY	2 DESC
--'Nestle Fitness Multigrain Chips Δημητριακών Θαλασσινό Αλάτι 75g'


--2a. Identify null product_name values for product_category 'Make A Wish'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Make A Wish'
AND			product_name IS NULL


--2b. Finding mode for non-null product_name values for product_category 'Make A Wish'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Make A Wish'
GROUP BY	product_name
--NoName


--3a. Identify null product_name values for product_category 'Αρνί'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αρνί'
AND			product_name IS NULL


--3b. Finding mode for non-null product_name values for product_category 'Αρνί'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αρνί'
AND			product_name IS NOT NULL
GROUP BY	product_name
--NoName


--4a. Identify null product_name values for product_category 'Αρτοσκευάσματα'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αρτοσκευάσματα'
AND			product_name IS NULL --(1.6)


--4b. Finding mode for non-null product_name values for product_category 'Αρτοσκευάσματα'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αρτοσκευάσματα'
AND			product_name IS NOT NULL
AND			product_price = '1.6'
GROUP BY	product_name
--ELITE Φρυγανιές Σικάλεως 180g


--5a. Identify null product_name values for product_category 'Αυγά'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αυγά'
AND			product_name IS NULL --(3, 4, 7.25)
ORDER BY	product_price


--5b. Finding mode for non-null product_name values for product_category 'Αυγά'
SELECT		product_name,
			product_price,
			COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Αυγά'
AND			product_name IS NOT NULL
--AND			product_price = '7.25'
GROUP BY	product_name,
			product_price
ORDER BY	3 DESC
-- 3='Χρυσά Αυγά Αχυρώνα με Βιταμίνη D 53-63g 6τεμ -0.5€', 4='Χρυσά Αυγά Μεσαία 10τεμ σε Πλαστική Θήκη', 7.25='NoName'


--6a. Identify null product_name values for product_category 'Γλυκά'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Γλυκά'
AND			product_name IS NULL --(6.75)
ORDER BY	product_price


--6b. Finding mode for non-null product_name values for product_category 'Γλυκά'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Γλυκά'
AND			product_name IS NOT NULL
AND			product_price = '6.75'
GROUP BY	product_name
--'Μακεδονικός Χαλβάς Κακάο 400g'


--7a. Identify null product_name values for product_category 'Είδη επάλειψης'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Είδη επάλειψης'
AND			product_name IS NULL --(6.75)
ORDER BY	product_price


--7b. Finding mode for non-null product_name values for product_category 'Είδη επάλειψης'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Είδη επάλειψης'
AND			product_name IS NOT NULL
AND			product_price = '6.75'
GROUP BY	product_name
--'Μακεδονικός Χαλβάς Κακάο 400g'


--8a. Identify null product_name values for product_category 'Έτοιμες Σαλάτες'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Έτοιμες Σαλάτες'
AND			product_name IS NULL --(3.5)
ORDER BY	product_price


--8b. Finding mode for non-null product_name values for product_category 'Έτοιμες Σαλάτες'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Έτοιμες Σαλάτες'
AND			product_name IS NOT NULL
AND			product_price = '3.5'
GROUP BY	product_name
--'NoName'


--9a. Identify null product_name values for product_category 'Ζύμες, Πίτες & Πίτσες'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Ζύμες, Πίτες & Πίτσες'
AND			product_name IS NULL --(5.8)
ORDER BY	product_price


--9b. Finding mode for non-null product_name values for product_category 'Ζύμες, Πίτες & Πίτσες'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Ζύμες, Πίτες & Πίτσες'
AND			product_name IS NOT NULL
AND			product_price = '5.88'
GROUP BY	product_name
--'Alfa Κασερόπιτα Τσαλακωτή Πηλίου 850g'


--10a. Identify null product_name values for product_category 'Κρέατα & Πουλερικά'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Κρέατα & Πουλερικά'
AND			product_name IS NULL --(28.05)
ORDER BY	product_price


--10b. Finding mode for non-null product_name values for product_category 'Κρέατα & Πουλερικά'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Κρέατα & Πουλερικά'
AND			product_name IS NOT NULL
AND			product_price = '28.05'
GROUP BY	product_name
--'NoName'


--11a. Identify null product_name values for product_category 'Κρουασάν & Τσουρέκια'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Κρουασάν & Τσουρέκια'
AND			product_name IS NULL --(5.1,6.1)
ORDER BY	product_price


--11b. Finding mode for non-null product_name values for product_category 'Κρουασάν & Τσουρέκια'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Κρουασάν & Τσουρέκια'
AND			product_name IS NOT NULL
AND			product_price IN ('5.1','6.1')
GROUP BY	product_name
--'NoName'


--12a. Identify null product_name values for product_category 'Πατατάκια & Αλμυρά Snacks'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Πατατάκια & Αλμυρά Snacks'
AND			product_name IS NULL --(1.7)
ORDER BY	product_price


--12b. Finding mode for non-null product_name values for product_category 'Πατατάκια & Αλμυρά Snacks'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Πατατάκια & Αλμυρά Snacks'
AND			product_name IS NOT NULL
AND			product_price IN ('1.7')
GROUP BY	product_name
ORDER BY 2 DESC
--'Lay`s Πατατάκια στο Φούρνο Γιαούρτι & Μυρωδικά 105g'


--13a. Identify null product_name values for product_category 'Πατατάκια & Γαριδάκια'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Πατατάκια & Γαριδάκια'
AND			product_name IS NULL --(1.7)
ORDER BY	product_price


--13b. Finding mode for non-null product_name values for product_category 'Πατατάκια & Γαριδάκια'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Πατατάκια & Γαριδάκια'
AND			product_name IS NOT NULL
AND			product_price IN ('1.7')
GROUP BY	product_name
ORDER BY 2 DESC
--'Tasty Πιτσίνια 110g'


--14a. Identify null product_name values for product_category 'Προϊόντα Κρεάτων & Πουλερικών'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Προϊόντα Κρεάτων & Πουλερικών'
AND			product_name IS NULL --(4.62,5.39,6.16,6.94,9.91)
ORDER BY	product_price


--14b. Finding mode for non-null product_name values for product_category 'Προϊόντα Κρεάτων & Πουλερικών'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Προϊόντα Κρεάτων & Πουλερικών'
AND			product_name IS NOT NULL
AND			product_price IN ('4.62','5.39','6.16','6.94','9.91')
GROUP BY	product_name
ORDER BY 2 DESC
--'NoName'


--15a. Identify null product_name values for product_category 'Σοκολάτες'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Σοκολάτες'
AND			product_name IS NULL --(0.5,1.8,3.6)
ORDER BY	product_price


--15b. Finding mode for non-null product_name values for product_category 'Σοκολάτες'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Σοκολάτες'
AND			product_name IS NOT NULL
AND			product_price IN ('0.5','1.8','3.6')
GROUP BY	product_name
ORDER BY 2 DESC
--0.5='Παυλίδης Kiss Σοκολάτα Γάλακτος 27.5g',1.8='Ίον Break Σοκολάτα Γάλακτος με Φουντούκι 85g',3.6='NoName'


--16a. Identify null product_name values for product_category 'Χοιρινό'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Χοιρινό'
AND			product_name IS NULL --(7.3)
ORDER BY	product_price


--16b. Finding mode for non-null product_name values for product_category 'Χοιρινό'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Χοιρινό'
AND			product_name IS NOT NULL
AND			product_price IN ('7.3')
GROUP BY	product_name
ORDER BY 2 DESC
--'NoName'


--17a. Identify null product_name values for product_category 'Ψωμί'
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Ψωμί'
AND			product_name IS NULL --()
ORDER BY	product_price


--17b. Finding mode for non-null product_name values for product_category 'Ψωμί'
SELECT		product_name, COUNT(*) AS ProductCount
FROM		[Dissertation].[dbo].[Dataset]
WHERE		TRIM(product_category) = N'Ψωμί'
AND			product_name IS NOT NULL
AND			product_price IN ('1.6')
GROUP BY	product_name
ORDER BY 2 DESC
--'Παπαδοπούλου Γεύση2 Ψωμί Τοστ Σίτου 700g'



--Final dataset with non-null values
DROP TABLE	IF EXISTS #FilledNull
SELECT		order_id,
			customer_id,
			order_timestamp,
  CASE WHEN product_name IS NULL AND TRIM(product_category) = N'Healthy Αλμυρά Snacks'         AND product_price = '1.6'                                 THEN N'Nestle Fitness Multigrain Chips Δημητριακών Θαλασσινό Αλάτι 75g'
       WHEN product_name IS NULL AND TRIM(product_category) = N'Make A Wish'                   AND product_price = '2'                                   THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Αρνί'                          AND product_price IN ('16.2','43.52')                     THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Αρτοσκευάσματα'                AND product_price = '1.6'                                 THEN N'ELITE Φρυγανιές Σικάλεως 180g'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Αυγά' THEN 
            CASE 
                WHEN product_price = '3' THEN N'Χρυσά Αυγά Αχυρώνα με Βιταμίνη D 53-63g 6τεμ -0.5€'
                WHEN product_price = '4' THEN N'Χρυσά Αυγά Μεσαία 10τεμ σε Πλαστική Θήκη'
                WHEN product_price = '7.25' THEN N'NoName'
                ELSE product_name 
            END
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Γλυκά'                         AND product_price = '6.75'                                THEN N'Μακεδονικός Χαλβάς Κακάο 400g'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Είδη επάλειψης'                AND product_price = '6.75'                                THEN N'Μακεδονικός Χαλβάς Κακάο 400g' --wrong value found
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Έτοιμες Σαλάτες'               AND product_price = '3.5'                                 THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Ζύμες, Πίτες & Πίτσες'         AND product_price = '5.8'                                 THEN N'Alfa Κασερόπιτα Τσαλακωτή Πηλίου 850g'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Κρέατα & Πουλερικά'	           AND product_price = '28.05'                               THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Κρουασάν & Τσουρέκια'          AND product_price IN ('5.1','6.1')                        THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Πατατάκια & Αλμυρά Snacks'     AND product_price = '1.7'                                 THEN N'Lay`s Πατατάκια στο Φούρνο Γιαούρτι & Μυρωδικά 105g'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Πατατάκια & Γαριδάκια'         AND product_price = '1.7'                                 THEN N'Tasty Πιτσίνια 110g'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Προϊόντα Κρεάτων & Πουλερικών' AND product_price IN ('4.62','5.39','6.16','6.94','9.91') THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Σοκολάτες' THEN 
            CASE 
                WHEN product_price = '0.5' THEN N'Παυλίδης Kiss Σοκολάτα Γάλακτος 27.5g'
                WHEN product_price = '1.8' THEN N'Ίον Break Σοκολάτα Γάλακτος με Φουντούκι 85g'
                WHEN product_price = '3.6' THEN N'NoName'
                ELSE product_name 
            END
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Χοιρινό'                       AND product_price IN ('7.3')                              THEN N'NoName'
	   WHEN product_name IS NULL AND TRIM(product_category) = N'Ψωμί'                          AND product_price IN ('1.6')                              THEN N'Παπαδοπούλου Γεύση2 Ψωμί Τοστ Σίτου 700g'
	   WHEN product_name IS NULL AND product_category IS NULL THEN N'NoName'
	   ELSE product_name END AS product_name,
  CASE WHEN product_category IS NULL THEN N'NoCategory' ELSE product_category END AS product_category,
			product_price,
			items_sold,
			geographical_region_of_user,
			user_last_order_date,
			CASE 
				WHEN f0_ IS NULL THEN (SELECT MIN(order_timestamp) FROM [Dissertation].[dbo].[Dataset] WHERE customer_id = 'c4b990d9f8cc112c80ee56e7c8a0ebf8')
				ELSE f0_
			END AS f0_
INTO		#FilledNull
FROM		[Dissertation].[dbo].[Dataset]


--Check if 'f0_' values are older than 'order_timestamp' values
SELECT		*
FROM		[Dissertation].[dbo].[Dataset]
WHERE		f0_> order_timestamp


--Control: Check columns for remaing null values (should be blank)
SELECT		*
FROM		#FilledNull
WHERE		product_name IS NULL
OR			product_category IS NULL
OR			f0_ IS NULL


--Change the datetime columns format to remove miliseconds and form final dataset
DROP TABLE	IF EXISTS [Dissertation].[dbo].[ProcessedDataset]
SELECT		order_id,
			customer_id,
			FORMAT(order_timestamp, 'yyyy-MM-dd HH:mm:ss') as order_timestamp,
			product_name,
			product_category,
			product_price,
			items_sold,
			geographical_region_of_user,
			FORMAT(user_last_order_date, 'yyyy-MM-dd HH:mm:ss') as user_last_order_date,
			FORMAT(f0_, 'yyyy-MM-dd HH:mm:ss') as f0_
INTO		[Dissertation].[dbo].[ProcessedDataset]
FROM		#FilledNull


--Identify rows where product_name is manually assigned as 'NoName'
SELECT		*
FROM		[Dissertation].[dbo].[ProcessedDataset]
WHERE		product_name='NoName'
ORDER BY	product_category
--91

--Identify possible free giveaways
SELECT		*
FROM		[Dissertation].[dbo].[ProcessedDataset]
WHERE		product_price = 0.0
--489, Πρώτο Θέμα


--Export to csv using command prompt
bcp "SELECT * FROM [Dissertation].[dbo].[ProcessedDataset]" queryout "C:\\Users\\User\\Desktop\\Dissertation\\test1.csv" -c -t, -T -S NIKOS-LAPTOP\SQLEXPRESS


--Create a table with the first order dates per customer
DROP TABLE	IF EXISTS #CustomerFirstOrders
CREATE TABLE #CustomerFirstOrders
			(
			customer_id NVARCHAR(50),
			first_order_date DATE
			)


--Get the first (minimum) order date for each customer
INSERT INTO	#CustomerFirstOrders
SELECT		customer_id,
			MIN(CAST(order_timestamp AS DATE)) AS first_order_date
FROM		[Dissertation].[dbo].[ProcessedDataset]
GROUP BY	customer_id

--select * from #CustomerFirstOrders


--Count new customers by their first order month
DROP TABLE	IF EXISTS [Dissertation].[dbo].[NewCustomers]
SELECT		FORMAT(first_order_date, 'yyyy-MM') AS first_order_month,
			COUNT(customer_id) AS new_customer_count
INTO		[Dissertation].[dbo].[NewCustomers]
FROM		#CustomerFirstOrders
GROUP BY	FORMAT(first_order_date, 'yyyy-MM')
ORDER BY	first_order_month

--select * from [Dissertation].[dbo].[NewCustomers]



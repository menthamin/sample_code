/* 테이블 생성 쿼리 */
DROP TABLE IF EXISTS mst_users;
CREATE TABLE mst_users(
    user_id         varchar(255)
  , sex             varchar(255)
  , birth_date      varchar(255)
  , register_date   varchar(255)
  , register_device varchar(255)
  , withdraw_date   varchar(255)
);

INSERT INTO mst_users
VALUES
    ('U001', 'M', '1977-06-17', '2016-10-01', 'pc' , NULL        )
  , ('U002', 'F', '1953-06-12', '2016-10-01', 'sp' , '2016-10-10')
  , ('U003', 'M', '1965-01-06', '2016-10-01', 'pc' , NULL        )
  , ('U004', 'F', '1954-05-21', '2016-10-01', 'pc' , NULL        )
  , ('U005', 'M', '1987-11-23', '2016-10-01', 'sp' , NULL        )
  , ('U006', 'F', '1950-01-21', '2016-10-01', 'pc' , '2016-10-10')
  , ('U007', 'F', '1950-07-18', '2016-10-01', 'app', NULL        )
  , ('U008', 'F', '2006-12-09', '2016-10-01', 'sp' , NULL        )
  , ('U009', 'M', '2004-10-23', '2016-10-01', 'pc' , NULL        )
  , ('U010', 'F', '1987-03-18', '2016-10-01', 'pc' , NULL        )
  , ('U011', 'F', '1993-10-21', '2016-10-01', 'pc' , NULL        )
  , ('U012', 'M', '1993-12-22', '2016-10-01', 'app', NULL        )
  , ('U013', 'M', '1988-02-09', '2016-10-01', 'app', NULL        )
  , ('U014', 'F', '1994-04-07', '2016-10-01', 'sp' , NULL        )
  , ('U015', 'F', '1994-03-01', '2016-10-01', 'app', NULL        )
  , ('U016', 'F', '1991-09-02', '2016-10-01', 'pc' , NULL        )
  , ('U017', 'F', '1972-05-21', '2016-10-01', 'app', NULL        )
  , ('U018', 'M', '2009-10-12', '2016-10-01', 'app', NULL        )
  , ('U019', 'M', '1957-05-18', '2016-10-01', 'pc' , NULL        )
  , ('U020', 'F', '1954-04-17', '2016-10-02', 'app', NULL        )
  , ('U021', 'M', '2002-08-14', '2016-10-02', 'sp' , NULL        )
  , ('U022', 'M', '1979-12-09', '2016-10-02', 'app', NULL        )
  , ('U023', 'M', '1992-01-12', '2016-10-02', 'sp' , NULL        )
  , ('U024', 'F', '1962-10-16', '2016-10-02', 'app', NULL        )
  , ('U025', 'F', '1958-06-26', '2016-10-02', 'app', NULL        )
  , ('U026', 'M', '1969-02-21', '2016-10-02', 'sp' , NULL        )
  , ('U027', 'F', '2001-07-10', '2016-10-02', 'pc' , NULL        )
  , ('U028', 'M', '1976-05-26', '2016-10-02', 'app', NULL        )
  , ('U029', 'M', '1964-04-06', '2016-10-02', 'pc' , NULL        )
  , ('U030', 'M', '1959-10-07', '2016-10-02', 'sp' , NULL        )

;

DROP TABLE IF EXISTS action_log;
CREATE TABLE action_log(
    session  varchar(255)
  , user_id  varchar(255)
  , action   varchar(255)
  , stamp    varchar(255)
);

INSERT INTO action_log
VALUES
    ('989004ea', 'U001', 'view'   ,'2016-10-01 18:00:00')
  , ('989004ea', 'U001', 'view'   ,'2016-10-01 18:01:00')
  , ('989004ea', 'U001', 'view'   ,'2016-10-01 18:10:00')
  , ('47db0370', 'U001', 'follow' ,'2016-10-05 19:00:00')
  , ('47db0370', 'U001', 'view'   ,'2016-10-05 19:10:00')
  , ('47db0370', 'U001', 'follow' ,'2016-10-05 20:30:00')
  , ('5asfv583', 'U001', 'follow' ,'2016-10-20 19:00:00')
  , ('5asfv583', 'U001', 'view'   ,'2016-10-20 19:10:00')
  , ('5asfv583', 'U001', 'follow' ,'2016-10-20 20:30:00')
  , ('87b5725f', 'U002', 'follow' ,'2016-10-01 12:00:00')
  , ('87b5725f', 'U002', 'follow' ,'2016-10-01 12:01:00')
  , ('87b5725f', 'U002', 'follow' ,'2016-10-01 12:02:00')
  , ('9afaf87c', 'U002', 'view'   ,'2016-10-02 13:00:00')
  , ('9afaf87c', 'U002', 'comment','2016-10-02 15:00:00')
;

CREATE TABLE report_download_log AS (
SELECT 
		di."SN"	AS sn
	,	di."USER_ID" AS user_id
	,	di."FILE_NM" AS file_nm
	,	ri."CTGR" AS ctgr
	,	ri."CREATE_DATE" AS create_date
	,	di."DOWNLOAD_DT" AS donwload_dt
FROM hmall.t_download_info di
LEFT JOIN hmall.t_report_info ri
ON di."FILE_NM" = ri."FILE_NM"
);

CREATE TABLE mst_users AS (	
	SELECT 
			"USER_ID" AS user_id
		,	"CTGR" AS ctgr
		,	to_date('2020-06-01', 'YYYY-MM-DD') AS register_date
	FROM hmall.t_user_map
);

CREATE TABLE mst_users1 AS (
SELECT 
		user_id
	,	ctgr
	,	register_date + ((CAST(user_id AS INT) - 1000) % 30) AS register_date
FROM mst_users
);


-- 데이터 1/20 으로 축소
DELETE FROM report_download_log
WHERE (CAST(sn AS INT) % 10) != 1;
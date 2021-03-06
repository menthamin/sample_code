/* 실행 계획 확인 하기 
 *
 * 주의: 대개 실행계획대로 쿼리를 실행하지만, 다른방식으로 실행하는 경우도 있음
 * (어디까지나 실행 계획임)
 * 
 * 병원에서의 치료에 비유하면 비침습적 치료인 혈압 측정, 청진기 진료 등으로 볼 수 있음.
 *
 */

-- 실행 계획 확인 명령어
-- explain plan for [쿼리]
-- explain plan set statement_id = '저장할실행계획이름' for [쿼리]
explain plan SET statement_id = 'query_01' FOR 
SELECT *
FROM dev.emp
WHERE empno = '7369';

-- plan_table 에서 조회하기
SELECT
		operation
	,	OPTIONS
	,	object_name
	,	cost
	,	CARDINALITY
	,	bytes
FROM plan_table
WHERE statement_id = 'query_01';

-- dbms_xplan.display() 함수 사용하기
SELECT * FROM table(dbms_xplan.display('PLAN_TABLE', 'query_01', 'BASIC'));
SELECT * FROM table(dbms_xplan.display('PLAN_TABLE', 'query_01', 'BASIC ROWS BYTES COST')); 
SELECT * FROM table(dbms_xplan.display('PLAN_TABLE', 'query_01', 'ALL')); 

-- plan table 확인해보기
SELECT * FROM plan_table;

-- Oracle 10g 이후로는 오라클이 sys.plan_table$ 테이블을 만들고 
-- 아래와 같이 plan_table로 명명한 public synonym도 생성하므로
-- 사용자가 별도로 plan_table을 만들 필요가 없다고 합니다. -- 친절한 SQL 튜닝(조시형 저, 디비안) 531page

SELECT * FROM ALL_SYNONYMS
WHERE synonym_name = 'PLAN_TABLE';

/* sqlplus 의 utlxpls 스크립트로 도 확인 가능
SQL> @?/rdbms/admin/utlxpls

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 2949544139

--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------

Predicate Information (identified by operation id):

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------

   2 - access("EMPNO"=7369)

14 rows selected.
*/

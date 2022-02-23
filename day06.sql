-- DML()(INSERT, UPDATE, DELETE), CRUD
-- COMMIT, ROLLBACK
/*
무결성 제약
            부모       자식
UPDATE       X          O
INSERT       O          O
DELETE       X          O

-- 데이터 갱신 구문
/*
UPDATE  TABLE_NAME
SET     COLUMN_NAME - VALUE | SUBQUERY, [COLUMN_NAME - VALUE]
[WHERE  CONDITION]
*/

SELECT  *
FROM    EMPLOYEE;

-- UPDATE  EMPLOYEE
-- SET     JOB_ID = 'J8', DEPT_ID = '90' -> J8은 없는 데이터이므로 외래키의 제약이 걸려서 오류남
-- WHERE   EMP_NAME = '심하균';

UPDATE  EMPLOYEE
SET     JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '성해교'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '심하균';

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME(COLUMN_NAME)
VALUES (VALUE1, VALUE2, DEFAULT)

INSERT INTO TABLE_NAME(COLUMN_NAME)
SUBQUERY
- 데이터 타입 일치
- 순서 일치
- 개수 일치
*/
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO)
VALUES('900', '임정섭', '123456-1234567');

-- DELETE: 테이블에 포함된 기존 데이터를 삭제
/*
DELETE FROM TABLE_NAME
[WHERE CONDITION];

TRUNCATE TABLE TABLE_NAME - ROLLBACK 사용 불가
*/

/*
데이터 무결성 제약
SELECT  *
FROM    DEPARTMENT
WHERE   LOC_ID LIKE 'A%';
*/

/*
자식을 갖고 있는 부모테이블이기 때문에 삭제 불가
DELETE
FROM    JOB
WHERE   JOB_ID = 'J2';

DELETE
FROM    EMPLOYEE
WHERE   EMP_ID = '141';
*/

-- TRANSACTION
-- 데이터의 일관성을 유지하기 위해서 사용하는 논리적으로 연관된 작업들의 집합
-- 하나이상의 연관된 DML 구문
/*
INSERT~~
UPDATE~~
COMMIT/ROLLBACK

UPDATE
DELETE
CREATE - AUTO COMMIT
*/

-- 동시성 제어: 동시접근을 막아줌, 한 쪽이 데이터 수정 중이면 COMMIT 전까지 다른 한쪽은 데이터 수정이 LOCK 걸림
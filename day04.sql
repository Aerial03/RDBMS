-- SUBQUERY, DDL(CONSTRAINT 제약)
-- 서브쿼리(하나의 쿼리가 다른 쿼리를 포함하는 구조)
/*
SELECT  EXPR(SELECT) --SCALAR SUBQUERY
FROM    (SELECT) -- INLINE VIEW
WHERE   (SELECT) -- SUBQUERY

유형
- 단일 행 서브쿼리(단일 컬럼, 다중 컬럼)
- 다중 행 서브쿼리(단일 컬럼, 다중 컬럼) - (IN, ANY, ALL)
*/

-- '나승원' 직원과 같은 부서원을 조회한다면?
SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT  DEPT_ID
                   FROM    EMPLOYEE
                   WHERE   EMP_NAME = '나승원');
                   
-- '나승원' 직원과 같은 직급이면서 급여가 '나승원' 보다 많이 받는 직원을 조회한다면?
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '나승원') AND
        SALARY > (SELECT    SALARY
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '나승원');

-- 최저급여를 받는 사원의 정보를 검색한다면?
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                  FROM      EMPLOYEE);
                  
-- 부서별 급여총합이 가장 높은 부서의 부서이름, 급여총합을 조회한다면?
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY    DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                       FROM     EMPLOYEE
                       GROUP BY DEPT_ID);

/*
다중 행 서브쿼리
> ANY, < ANY
> ALL, < ALL
*/

-- 관리자들만 조회한다면?
-- MGR_ID에 EMP_ID가 있다면 관리자
SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS "관리자 유무"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID
                   FROM     EMPLOYEE);
                   
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS "관리자 유무"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT   MGR_ID
                       FROM     EMPLOYEE
                       WHERE    MGR_ID IS NOT NULL)
ORDER BY 3;

-- 대리, 과장직급의 사원의 이름, 급여 조회
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '과장';

-- 과장직급보다 많은 급여를 받는 대리직의 사원이름, 급여를 조회한다면?
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
AND     SALARY < ANY (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '과장');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
AND     SALARY > ANY (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '과장');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
AND     SALARY < ALL (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '과장');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
AND     SALARY > ALL (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '과장');

-- 직급별 평균급여를 조회하고 싶다면?
SELECT  JOB_TITLE,
        TRUNC(AVG(SALARY),-5)
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY    JOB_TITLE;

-- 자기 직급의 평균 급여를 받는 직원의 이름, 직급, 급여 조회한다면? / 다중컬럼
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_TITLE, SALARY) IN (SELECT  JOB_TITLE, TRUNC(AVG(SALARY),-5)
                                FROM    EMPLOYEE
                                JOIN    JOB USING(JOB_ID)
                                GROUP BY    JOB_TITLE);

-- FROM SUBQUERY / 하나의 가상 테이블로 취급
SELECT  E.EMP_NAME,
        JOB_TITLE,
        V.JOBAVG
FROM    (SELECT  JOB_ID, TRUNC(AVG(SALARY),-5) JOBAVG
        FROM    EMPLOYEE
        JOIN    JOB USING(JOB_ID)
        GROUP BY    JOB_ID) V
JOIN    EMPLOYEE E ON (JOBAVG = SALARY AND E.JOB_ID = V.JOB_ID)
JOIN    JOB J ON (J.JOB_ID = E.JOB_ID);

-- 상관관계 서브쿼리(CORRELATED SUBQUERRY)
-- 메인쿼리에서 처리되는 각 행의 값에 따라 서브쿼리의 결과값이 달라지는 경우
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY), -5)
                  FROM      EMPLOYEE
                  WHERE     JOB_ID = E.JOB_ID);
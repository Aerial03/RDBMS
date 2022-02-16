/*
 PARSING
 - FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
 WHERE SEARCH_CONDITION : 행에 대한 제한
 ORDER BY 기준컬럼 [ASC | DESC] : 오름차순, 내림차순
 GROUP BY 기준컬럼 : 그룹핑
 HAVING SEARCH_CONDITION : 그룹에 대한 조건
 행 마지막에 한번만 넣을 수 있음
*/

-- ORDER BY
SELECT  *
FROM    EMPLOYEE
ORDER BY    SALARY DESC, EMP_NAME DESC;

SELECT  EMP_NAME 이름,
        HIRE_DATE 입사일,
        DEPT_ID 부서코드
FROM    EMPLOYEE
ORDER BY    부서코드 DESC, 입사일, 이름; -- 별칭 사용가능

SELECT  EMP_NAME 이름,
        HIRE_DATE 입사일,
        DEPT_ID 부서코드
FROM    EMPLOYEE
ORDER BY    3 DESC, 2, 1; -- 인덱스 사용가능

-- GROUP BY: 하위 데이터 그룹
SELECT  DEPARTMENT_NO 학과번호, -- GROUP BY에 정의된 컬럼은 사용가능
        COUNT(*) "학생수(명)"
FROM    TB_STUDENT
GROUP BY    DEPARTMENT_NO
ORDER BY    1;

-- 부서별 평균 급여를 조회
SELECT  DEPT_ID 부서코드,
        ROUND(AVG(SALARY),0) 평균급여
FROM    EMPLOYEE
GROUP BY    DEPT_ID;

-- 성별에 따른 평균급여도 조회
SELECT  DECODE(SUBSTR(EMP_NO, 8, 1),
        '1', '남자',
        '3', '남자',
        '여자') 성별,
        ROUND(AVG(SALARY),-4) 급여
FROM    EMPLOYEE
GROUP BY    SUBSTR(EMP_NO, 8, 1);

SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, EMP_NAME;

SELECT  DEPT_ID 부서코드,
        SUM(SALARY) 급여총합
FROM    EMPLOYEE
GROUP BY    DEPT_ID
HAVING  SUM(SALARY) > 9000000;


-- ROLLUP()
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    ROLLUP(DEPT_ID, JOB_ID); -- 중간중간에 그룹별 계산 결과가 출력됨

-- ERD
-- 사원의 이름, 부서이름을 조회하고 싶다면?
-- 즉, 두개의 컬럼을 한번에 볼 수 있는 방법
-- JOIN
SELECT  EMP_NAME,
        DEPT_NAME,
        D.DEPT_ID
FROM    EMPLOYEE E, DEPARTMENT D -- 두 컬럼
WHERE   E.DEPT_ID = D.DEPT_ID; -- 두 컬럼의 교집합

-- ANSI JOIN
/*
SELECT ...
FROM TABLE1
JOIN TABLE2 ON   (CONDITION)
JOIN TABLE3 USING   (COLUMN)
*/
SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) -- USING을 쓰면 'O.컬럼' 별칭을 쓸 수 없음
JOIN    JOB J USING(JOB_ID)
JOIN    LOCATION L ON(L.LOCATION_ID = D.LOC_ID); -- 부모의 기본키와 자식의 외래키 이름이 달라서 USING 사용 불가

SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON(D.DEPT_ID = E.DEPT_ID) -- ON을 쓰면 'O.컬럼' 별칭을 쓸 수 있음
JOIN    JOB J ON(E.JOB_ID = J.JOB_ID)
JOIN    LOCATION L ON(L.LOCATION_ID = D.LOC_ID);

SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE
JOIN    SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST)
ORDER BY    SLEVEL;

-- OUTER JOIN
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
WHERE   E.DEPT_ID = D.DEPT_ID;

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
LEFT JOIN   DEPARTMENT D USING(DEPT_ID); -- 오른쪽 컬럼의 NULL값도 포함하여 조회

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
RIGHT JOIN  DEPARTMENT D USING(DEPT_ID); -- 왼쪽 컬럼의 NULL값도 포함하여 조회

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN   DEPARTMENT D USING(DEPT_ID); -- 모든 NULL값 포함하여 조회

-- 사원의 이름과 사수의 이름을 셀프조인으로 조회한다면?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE M ON(E.MGR_ID = M.EMP_ID)
LEFT JOIN    EMPLOYEE S ON(M.MGR_ID = S.EMP_ID);

-- LOC_DESCRIBE 아시아로 시작하고 직급이 대리인 사원의 이름, 부서이름을 조회한다면?
SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE USING(JOB_ID)
JOIN    DEPARTMENT USING(DEPT_ID)
JOIN    LOCATION ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE LIKE '아시아%' AND JOB_TITLE = '대리';

-- SET 연산자
/*
두 개 이상의 쿼리 결과를 하나로 결합시키는 연산자
- UNION: 중복제거하고 표시
- UNION ALL: 모두 표시
- INTERSECT: 교집합
- MINUS: 차집합
주의) 반드시 동일(컬럼 개수, 데이터 타입) -- 오류
*/

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE
UNION
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY;

SELECT  EMP_NAME,
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL -- 컬럼의 개수가 맞지 않으므로 더미컬럼을 정의하여 통일
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

SELECT  TO_CHAR(SALARY), -- SALARY를 문자열로 변환하여 데이터타입 통일
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

-- 부서번호가 50번 부서의 부서원을 관리자와 직원으로 구분하여 표시하고 싶다면?
-- 기준 EMP_ID = '141' 이면 관리자
SELECT  EMP_NAME,
        DEPT_ID,
        '관리자' 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID = '141'
UNION
SELECT  EMP_NAME,
        DEPT_ID,
        '직원'
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID != '141';

SELECT  EMP_NAME 사원이름,
        DEPT_ID 부서번호,
        DECODE(EMP_ID,
        '141', '관리자',
        '직원') 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = 50;

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('대리', '사원');

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '사원'
ORDER BY    2,1;
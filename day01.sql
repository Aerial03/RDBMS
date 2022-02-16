-- 검색(SELECT)
/*
키워드는 대문자, 데이터는 대소문자를 구별
가독성을 위해서 각 절을 개행해서 작성
SELECT * | [DISTINCT] COLUMN_NAME | 표현식 | [AS] ALIAS(별칭 주기, AS생략 가능) - 가져오고자 하는 컬럼리스트
FROM TABLE_NAME - 대상 테이블
WHERE SEARCH_CONDITION - 행에 대한 제한, 조건
*/

SELECT  *
FROM    EMPLOYEE;

SELECT  EMP_ID,
        EMP_NAME,
        DEPT_ID
FROM    EMPLOYEE;

SELECT  EMP_ID,
        EMP_NAME,
        DEPT_ID
FROM    EMPLOYEE
WHERE   DEPT_ID = '90';

SELECT  EMP_ID,
        EMP_NAME,
        DEPT_ID
FROM    EMPLOYEE
WHERE   JOB_ID = 'J1'; -- 데이터를 ''으로 명시

-- 표현식(컬럼 값에 대한 산술 연산)
-- 별칭 주의: 특수문자(공백, 괄호, 기호 등)가 포함될 경우, 숫자로 시작할 경우 반드시 ""으로 명시
SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 ANNUL_SALARY, -- AS
        (SALARY + (SALARY * BONUS_PCT)) * 12 "연봉(+보너스)" -- AS
FROM    EMPLOYEE;

-- 더미 컬럼 추가
SELECT  EMP_ID,
        EMP_NAME,
        '재직' AS 근무여부
FROM    EMPLOYEE;

-- DISTINCT: 중복된 데이터를 1개만 표시
-- SELECT 절에 단 한번만 기술할 수 있다.
SELECT  DISTINCT EMP_ID
FROM    EMPLOYEE;

-- 급여가 4000000 보다 많은 사원의 이름과 급여를 조회한다면?
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000;

-- 부서코드가 90이고 급여가 2000000 보다 많은 사원의 부서코드, 급여 조회한다면?
SELECT  DEPT_ID 부서코드,
        SALARY 급여
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' AND SALARY > 2000000;

-- 부서코드가 90이거나 20인 부서원의 이름, 부서코드, 급여 조회한다면?
SELECT  DEPT_ID 부서코드,
        EMP_NAME 이름,
        SALARY 급여
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' OR DEPT_ID = '20';

-- 부서코드가 90이거나 20인 부서원의 이름, 부서코드, 급여 조회한다면? IN 연산자 사용
SELECT  DEPT_ID 부서코드,
        EMP_NAME 이름,
        SALARY 급여
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('90', '20'); -- OR = IN 같은 의미

-- WHERE 연산자
-- 연결연산자 ||
SELECT  EMP_NAME||'의 월급은 '||SALARY||' 입니다.' 설명
FROM    EMPLOYEE;

-- 논리연산자 AND, OR, NOT
-- 비교연산자 =, >, <, >=, <=, !=
-- 비교연산자 BETWEEN AND, LIKE, NOT LIKE, IS NULL, IS NOT NULL, IN
-- 급여가 3500000 보다 많이 받고, 5500000 보다 적게 받는 직원의 이름, 급여 조회한다면?
SELECT  EMP_NAME 이름,
        SALARY 급여
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

-- 김씨 성을 가진 직원의 이름, 급여를 조회한다면?
SELECT  EMP_NAME 이름,
        SALARY 급여
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '김%'; -- %: 임의의 문자열 맵핑

-- 김씨 성을 가지지 않은 직원의 이름, 급여를 조회한다면?
SELECT  EMP_NAME 이름,
        SALARY 급여
FROM    EMPLOYEE
WHERE   EMP_NAME NOT LIKE '김%';

-- 이메일 아이디의 언더바 앞 자리수가 세자리수인 직원의 이름, 급여를 조회한다면?
SELECT  EMP_NAME 이름,
        EMAIL 이메일
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___#_%' ESCAPE '#'; -- #, \ 등: 와일드카드 구분

-- 사수번호가 없고 부서 배치도 받지 않은 사원의 이름을 조회한다면?
SELECT  EMP_NAME 이름,
        MGR_ID 사수번호,
        DEPT_ID 부서번호
FROM    EMPLOYEE
WHERE   MGR_ID IS NULL AND DEPT_ID IS NULL;

-- 사수번호가 있고 부서 배치를 받은 사원의 이름을 조회한다면?
SELECT  EMP_NAME 이름,
        MGR_ID 사수번호,
        DEPT_ID 부서번호
FROM    EMPLOYEE
WHERE   MGR_ID IS NOT NULL AND DEPT_ID IS NOT NULL;

-- 부서 배치를 받지 않았음에도 보너스를 지급받는 직원의 이름을 조회한다면?
SELECT  EMP_NAME 이름,
        DEPT_ID 부서번호,
        BONUS_PCT 보너스
FROM    EMPLOYEE
WHERE   DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

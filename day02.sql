-- 함수
/*
유형
단일 행 함수(Single row function)
- n개를 입력하면 n개의 값 반환
그룹 함수(Group function)
- 데이터 그룹을 입력하면 데이터 그룹을 반환

컬럼타입(숫자 - number, 문자 - char, varchar2, 날짜 - date)
- 숫자함수
- 문자함수
- 날짜함수
- 기타함수
*/

-- 문자함수
-- CHAR 한글일 경우 LENGTH
-- 한글 3: 6*3 = 18, 20-18 = 2, 6+2 = 8바이트
SELECT LENGTH(CHARTYPE),
       LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;

-- INSTR(): 찾는 문자의 인덱스를 리턴하는 함수
-- INSTR(STRING, SUBSTRING, POSITION, OCCURRENCE) : NUMBER
SELECT EMAIL,
       INSTR(EMAIL, 'c') -- 인덱스값이 왼쪽에서 1부터 시작
FROM EMPLOYEE;

SELECT EMAIL,
       INSTR(EMAIL, 'c', -1, 2) -- 뒤에서부터 시작, 2번째 문자열의 인덱스값 출력
FROM EMPLOYEE;

-- LPAD | RPAD
SELECT EMAIL,
       LENGTH(EMAIL),
       LPAD(EMAIL, 20, '*'),
       RPAD(EMAIL, 20, '*')
FROM EMPLOYEE;

-- TRIM, LTRIM, RTRIM
-- 문자를 제거할 때
-- LTRIM(STRING, STR)
-- TRTIM(STRING, STR)
-- TRIM(LEADING | TRAILING | BOTH FROM TRIM_SOURCE)

SELECT LENGTH('    TECH    '),
       LTRIM('    TECH    '),
       LENGTH(LTRIM('    TECH    ')),
       RTRIM('    TECH    '),
       LENGTH(RTRIM('    TECH    '))
FROM DUAL;

SELECT TRIM(LEADING 'A' FROM 'AATECHAAA'),
       TRIM(TRAILING 'A' FROM 'AATECHAAA'),
       TRIM(BOTH 'A' FROM 'AATECHAAA')
FROM DUAL;

-- 중요
-- SUBSTR(STRING, POSITION, (LENGTH))
SELECT EMP_NO,
       SUBSTR(EMP_NO, 1, 6), -- 1번째 인덱스부터 문자열 6개 출력
       SUBSTR(EMP_NO, 8, 1) -- 8번째 인덱스부터 문자열 1개 출력
FROM EMPLOYEE;

-- 사원테이블에서 성별이 남자인 사원의 모든 정보를 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, -7, 1) = '1';

-- 숫자함수
-- ROUND(NUMBER, [DECIMAL_PLACES]), TRUNC(NUMBER, [DEMICAL_PLACES])

SELECT ROUND(123.315, 0), -- 소숫점 1번째 자리에서 반올림, 0번째까지 표시
       ROUND(123.315, 2) -- 소숫점 3번째 자리에서 반올림, 2번째까지 표시
FROM DUAL;

-- 날짜함수
-- SYSDATE, ADD_MONTHS(), MONTHS_BETWEEN()

SELECT SYSDATE + 1 -- 시스템 날짜 + 1일
FROM DUAL;

-- 근속년수가 20년 이상인 사원의 모든 정보를 조회한다면?
SELECT HIRE_DATE,
       ADD_MONTHS(HIRE_DATE, 240) -- 날짜를 더한 값을 표시
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240; -- 두 날짜 사이의 기간, 왼쪽 날짜가 더 최근이어야함

-- 근속년수도 출력
SELECT EMP_NAME,
       HIRE_DATE,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) 근속년수
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- 타입 변환 함수
/*
<-  TO_NUMBER()      TO_CHAR(DATE, 표현형식)
NUMBER   -   CHARACTER   -   DATE
->    TO_CHAR()       TO_DATE()
*/

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = TO_CHAR(90);

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD-DY'),
       TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY'),
       TO_CHAR(SYSDATE, 'HH:MI:SS'),
       TO_CHAR(SYSDATE, 'AM HH24:MI:SS'),
       TO_CHAR(SYSDATE, 'YEAR, Q') -- Q: 분기
FROM DUAL;

SELECT HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD-DY')
FROM EMPLOYEE;

SELECT HIRE_DATE,
       SUBSTR(HIRE_DATE, 1, 2)||'년'||
       SUBSTR(HIRE_DATE, 4, 2)||'월'||
       SUBSTR(HIRE_DATE, 7, 2)||'일' 입사일
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- CHAR -> DATE
-- '20220215' -> 22/02/15
SELECT TO_DATE('20220215', 'YYYYMMDD'),
       TO_CHAR(TO_DATE('220215', 'YYMMDD'), 'YYYY-MM-DD')
FROM DUAL;

-- 년도를 포맷팅할 때 YYYY, RRRR
SELECT HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE EMP_NAME = '한선기';

SELECT SYSDATE 현재,
       '95/02/15' 입력,
       TO_CHAR(TO_DATE('95/02/15', 'YY/MM/DD'), 'YYYY'),
       TO_CHAR(TO_DATE('95/02/15', 'RR/MM/DD'), 'YYYY') -- TO_DATE 사용시엔 RR 사용
FROM DUAL;

-- 기타함수
-- NULL 값 처리 함수: NVL()
SELECT EMP_NAME,
       BONUS_PCT,
       NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME,
       SALARY,
       SALARY * 12 ANNUL_SALARY,
       (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "12개월 연봉"
FROM EMPLOYEE;

-- 오라클 전용함수
-- DECODE(EXPR, SEARCH, RESULT, [SEARCH, RESULT], [DEFAULT])
-- IF ~ ELSE

-- 부서번호가 50번인 사원들의 이름, 성별을 조회한다면?
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_N0,8,1),
            '1', '남자',
            '3', '남자',
            '여자') GENDER
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT SALARY,
       DEPT_ID,
       DECODE(DEPT_ID,
            '90', SALARY * 1.1,
            SALARY) 인상급여
FROM EMPLOYEE;

-- ANSI 표준
-- CASE EXPR WHEN SEARCH THE RESULT (WHEN SEARCH THE RESULT) ELSE DEFAULT END
SELECT SALARY,
       DEPT_ID,
       CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                    ELSE SALARY
       END AS 인상급여
FROM EMPLOYEE;

SELECT SALARY,
       DEPT_ID,
       CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
                    ELSE SALARY
       END AS 인상급여
FROM EMPLOYEE;

-- 급여에 따른 급여 등급을 확인하려고 한다.
-- 3000000 이하면 초급, 4000000 이하면 중급, 초과면 고급 구분하기

SELECT EMP_NAME,
       SALARY,
       CASE
           WHEN SALARY <= 3000000 THEN '초급'
           WHEN SALARY <= 4000000 THEN '중급'
       ELSE '고급'
       END AS 급여등급
FROM EMPLOYEE;

-- 그룹함수(SUM, AVG, MIN, MAX, COUNT)
-- INPUT N -> OUTPUT 1
SELECT SUM(SALARY), -- SUM을 쓰면 EMP_ID와 같은 일반 컬럼리스트 정의 불가능
       MIN(SALARY), -- 최소
       MAX(SALARY), -- 최대
       COUNT(SALARY), -- 레코드의 개수를 새는 함수
       ROUND(AVG(SALARY),0) -- 평균
FROM EMPLOYEE;
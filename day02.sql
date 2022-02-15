-- �Լ�
/*
����
���� �� �Լ�(Single row function)
- n���� �Է��ϸ� n���� �� ��ȯ
�׷� �Լ�(Group function)
- ������ �׷��� �Է��ϸ� ������ �׷��� ��ȯ

�÷�Ÿ��(���� - number, ���� - char, varchar2, ��¥ - date)
- �����Լ�
- �����Լ�
- ��¥�Լ�
- ��Ÿ�Լ�
*/

-- �����Լ�
-- CHAR �ѱ��� ��� LENGTH
-- �ѱ� 3: 6*3 = 18, 20-18 = 2, 6+2 = 8����Ʈ
SELECT LENGTH(CHARTYPE),
       LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH;

-- INSTR(): ã�� ������ �ε����� �����ϴ� �Լ�
-- INSTR(STRING, SUBSTRING, POSITION, OCCURRENCE) : NUMBER
SELECT EMAIL,
       INSTR(EMAIL, 'c') -- �ε������� ���ʿ��� 1���� ����
FROM EMPLOYEE;

SELECT EMAIL,
       INSTR(EMAIL, 'c', -1, 2) -- �ڿ������� ����, 2��° ���ڿ��� �ε����� ���
FROM EMPLOYEE;

-- LPAD | RPAD
SELECT EMAIL,
       LENGTH(EMAIL),
       LPAD(EMAIL, 20, '*'),
       RPAD(EMAIL, 20, '*')
FROM EMPLOYEE;

-- TRIM, LTRIM, RTRIM
-- ���ڸ� ������ ��
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

-- �߿�
-- SUBSTR(STRING, POSITION, (LENGTH))
SELECT EMP_NO,
       SUBSTR(EMP_NO, 1, 6), -- 1��° �ε������� ���ڿ� 6�� ���
       SUBSTR(EMP_NO, 8, 1) -- 8��° �ε������� ���ڿ� 1�� ���
FROM EMPLOYEE;

-- ������̺��� ������ ������ ����� ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, -7, 1) = '1';

-- �����Լ�
-- ROUND(NUMBER, [DECIMAL_PLACES]), TRUNC(NUMBER, [DEMICAL_PLACES])

SELECT ROUND(123.315, 0), -- �Ҽ��� 1��° �ڸ����� �ݿø�, 0��°���� ǥ��
       ROUND(123.315, 2) -- �Ҽ��� 3��° �ڸ����� �ݿø�, 2��°���� ǥ��
FROM DUAL;

-- ��¥�Լ�
-- SYSDATE, ADD_MONTHS(), MONTHS_BETWEEN()

SELECT SYSDATE + 1 -- �ý��� ��¥ + 1��
FROM DUAL;

-- �ټӳ���� 20�� �̻��� ����� ��� ������ ��ȸ�Ѵٸ�?
SELECT HIRE_DATE,
       ADD_MONTHS(HIRE_DATE, 240) -- ��¥�� ���� ���� ǥ��
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240; -- �� ��¥ ������ �Ⱓ, ���� ��¥�� �� �ֱ��̾����

-- �ټӳ���� ���
SELECT EMP_NAME,
       HIRE_DATE,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) �ټӳ��
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- Ÿ�� ��ȯ �Լ�
/*
<-  TO_NUMBER()      TO_CHAR(DATE, ǥ������)
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
       TO_CHAR(SYSDATE, 'YEAR, Q') -- Q: �б�
FROM DUAL;

SELECT HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD-DY')
FROM EMPLOYEE;

SELECT HIRE_DATE,
       SUBSTR(HIRE_DATE, 1, 2)||'��'||
       SUBSTR(HIRE_DATE, 4, 2)||'��'||
       SUBSTR(HIRE_DATE, 7, 2)||'��' �Ի���
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- CHAR -> DATE
-- '20220215' -> 22/02/15
SELECT TO_DATE('20220215', 'YYYYMMDD'),
       TO_CHAR(TO_DATE('220215', 'YYMMDD'), 'YYYY-MM-DD')
FROM DUAL;

-- �⵵�� �������� �� YYYY, RRRR
SELECT HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE
WHERE EMP_NAME = '�Ѽ���';

SELECT SYSDATE ����,
       '95/02/15' �Է�,
       TO_CHAR(TO_DATE('95/02/15', 'YY/MM/DD'), 'YYYY'),
       TO_CHAR(TO_DATE('95/02/15', 'RR/MM/DD'), 'YYYY') -- TO_DATE ���ÿ� RR ���
FROM DUAL;

-- ��Ÿ�Լ�
-- NULL �� ó�� �Լ�: NVL()
SELECT EMP_NAME,
       BONUS_PCT,
       NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME,
       SALARY,
       SALARY * 12 ANNUL_SALARY,
       (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "12���� ����"
FROM EMPLOYEE;

-- ����Ŭ �����Լ�
-- DECODE(EXPR, SEARCH, RESULT, [SEARCH, RESULT], [DEFAULT])
-- IF ~ ELSE

-- �μ���ȣ�� 50���� ������� �̸�, ������ ��ȸ�Ѵٸ�?
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_N0,8,1),
            '1', '����',
            '3', '����',
            '����') GENDER
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT SALARY,
       DEPT_ID,
       DECODE(DEPT_ID,
            '90', SALARY * 1.1,
            SALARY) �λ�޿�
FROM EMPLOYEE;

-- ANSI ǥ��
-- CASE EXPR WHEN SEARCH THE RESULT (WHEN SEARCH THE RESULT) ELSE DEFAULT END
SELECT SALARY,
       DEPT_ID,
       CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                    ELSE SALARY
       END AS �λ�޿�
FROM EMPLOYEE;

SELECT SALARY,
       DEPT_ID,
       CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
                    ELSE SALARY
       END AS �λ�޿�
FROM EMPLOYEE;

-- �޿��� ���� �޿� ����� Ȯ���Ϸ��� �Ѵ�.
-- 3000000 ���ϸ� �ʱ�, 4000000 ���ϸ� �߱�, �ʰ��� ��� �����ϱ�

SELECT EMP_NAME,
       SALARY,
       CASE
           WHEN SALARY <= 3000000 THEN '�ʱ�'
           WHEN SALARY <= 4000000 THEN '�߱�'
       ELSE '���'
       END AS �޿����
FROM EMPLOYEE;

-- �׷��Լ�(SUM, AVG, MIN, MAX, COUNT)
-- INPUT N -> OUTPUT 1
SELECT SUM(SALARY), -- SUM�� ���� EMP_ID�� ���� �Ϲ� �÷�����Ʈ ���� �Ұ���
       MIN(SALARY), -- �ּ�
       MAX(SALARY), -- �ִ�
       COUNT(SALARY), -- ���ڵ��� ������ ���� �Լ�
       ROUND(AVG(SALARY),0) -- ���
FROM EMPLOYEE;
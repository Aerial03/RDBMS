/*
 PARSING
 - FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
 WHERE SEARCH_CONDITION : �࿡ ���� ����
 ORDER BY �����÷� [ASC | DESC] : ��������, ��������
 GROUP BY �����÷� : �׷���
 HAVING SEARCH_CONDITION : �׷쿡 ���� ����
 �� �������� �ѹ��� ���� �� ����
*/

-- ORDER BY
SELECT  *
FROM    EMPLOYEE
ORDER BY    SALARY DESC, EMP_NAME DESC;

SELECT  EMP_NAME �̸�,
        HIRE_DATE �Ի���,
        DEPT_ID �μ��ڵ�
FROM    EMPLOYEE
ORDER BY    �μ��ڵ� DESC, �Ի���, �̸�; -- ��Ī ��밡��

SELECT  EMP_NAME �̸�,
        HIRE_DATE �Ի���,
        DEPT_ID �μ��ڵ�
FROM    EMPLOYEE
ORDER BY    3 DESC, 2, 1; -- �ε��� ��밡��

-- GROUP BY: ���� ������ �׷�
SELECT  DEPARTMENT_NO �а���ȣ, -- GROUP BY�� ���ǵ� �÷��� ��밡��
        COUNT(*) "�л���(��)"
FROM    TB_STUDENT
GROUP BY    DEPARTMENT_NO
ORDER BY    1;

-- �μ��� ��� �޿��� ��ȸ
SELECT  DEPT_ID �μ��ڵ�,
        ROUND(AVG(SALARY),0) ��ձ޿�
FROM    EMPLOYEE
GROUP BY    DEPT_ID;

-- ������ ���� ��ձ޿��� ��ȸ
SELECT  DECODE(SUBSTR(EMP_NO, 8, 1),
        '1', '����',
        '3', '����',
        '����') ����,
        ROUND(AVG(SALARY),-4) �޿�
FROM    EMPLOYEE
GROUP BY    SUBSTR(EMP_NO, 8, 1);

SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY    DEPT_ID, EMP_NAME;

SELECT  DEPT_ID �μ��ڵ�,
        SUM(SALARY) �޿�����
FROM    EMPLOYEE
GROUP BY    DEPT_ID
HAVING  SUM(SALARY) > 9000000;


-- ROLLUP()
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY    ROLLUP(DEPT_ID, JOB_ID); -- �߰��߰��� �׷캰 ��� ����� ��µ�

-- ERD
-- ����� �̸�, �μ��̸��� ��ȸ�ϰ� �ʹٸ�?
-- ��, �ΰ��� �÷��� �ѹ��� �� �� �ִ� ���
-- JOIN
SELECT  EMP_NAME,
        DEPT_NAME,
        D.DEPT_ID
FROM    EMPLOYEE E, DEPARTMENT D -- �� �÷�
WHERE   E.DEPT_ID = D.DEPT_ID; -- �� �÷��� ������

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
JOIN    DEPARTMENT D USING(DEPT_ID) -- USING�� ���� 'O.�÷�' ��Ī�� �� �� ����
JOIN    JOB J USING(JOB_ID)
JOIN    LOCATION L ON(L.LOCATION_ID = D.LOC_ID); -- �θ��� �⺻Ű�� �ڽ��� �ܷ�Ű �̸��� �޶� USING ��� �Ұ�

SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON(D.DEPT_ID = E.DEPT_ID) -- ON�� ���� 'O.�÷�' ��Ī�� �� �� ����
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
LEFT JOIN   DEPARTMENT D USING(DEPT_ID); -- ������ �÷��� NULL���� �����Ͽ� ��ȸ

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
RIGHT JOIN  DEPARTMENT D USING(DEPT_ID); -- ���� �÷��� NULL���� �����Ͽ� ��ȸ

SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
FULL JOIN   DEPARTMENT D USING(DEPT_ID); -- ��� NULL�� �����Ͽ� ��ȸ

-- ����� �̸��� ����� �̸��� ������������ ��ȸ�Ѵٸ�?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE M ON(E.MGR_ID = M.EMP_ID)
LEFT JOIN    EMPLOYEE S ON(M.MGR_ID = S.EMP_ID);

-- LOC_DESCRIBE �ƽþƷ� �����ϰ� ������ �븮�� ����� �̸�, �μ��̸��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE USING(JOB_ID)
JOIN    DEPARTMENT USING(DEPT_ID)
JOIN    LOCATION ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE LIKE '�ƽþ�%' AND JOB_TITLE = '�븮';

-- SET ������
/*
�� �� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
- UNION: �ߺ������ϰ� ǥ��
- UNION ALL: ��� ǥ��
- INTERSECT: ������
- MINUS: ������
����) �ݵ�� ����(�÷� ����, ������ Ÿ��) -- ����
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
        NULL -- �÷��� ������ ���� �����Ƿ� �����÷��� �����Ͽ� ����
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

SELECT  TO_CHAR(SALARY), -- SALARY�� ���ڿ��� ��ȯ�Ͽ� ������Ÿ�� ����
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = 20;

-- �μ���ȣ�� 50�� �μ��� �μ����� �����ڿ� �������� �����Ͽ� ǥ���ϰ� �ʹٸ�?
-- ���� EMP_ID = '141' �̸� ������
SELECT  EMP_NAME,
        DEPT_ID,
        '������' ����
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID = '141'
UNION
SELECT  EMP_NAME,
        DEPT_ID,
        '����'
FROM    EMPLOYEE
WHERE   DEPT_ID = 50 AND EMP_ID != '141';

SELECT  EMP_NAME ����̸�,
        DEPT_ID �μ���ȣ,
        DECODE(EMP_ID,
        '141', '������',
        '����') ����
FROM    EMPLOYEE
WHERE   DEPT_ID = 50;

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE IN ('�븮', '���');

SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT  EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '���'
ORDER BY    2,1;
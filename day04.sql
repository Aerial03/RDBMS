-- SUBQUERY, DDL(CONSTRAINT ����)
-- ��������(�ϳ��� ������ �ٸ� ������ �����ϴ� ����)
/*
SELECT  EXPR(SELECT) --SCALAR SUBQUERY
FROM    (SELECT) -- INLINE VIEW
WHERE   (SELECT) -- SUBQUERY

����
- ���� �� ��������(���� �÷�, ���� �÷�)
- ���� �� ��������(���� �÷�, ���� �÷�) - (IN, ANY, ALL)
*/

-- '���¿�' ������ ���� �μ����� ��ȸ�Ѵٸ�?
SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = (SELECT  DEPT_ID
                   FROM    EMPLOYEE
                   WHERE   EMP_NAME = '���¿�');
                   
-- '���¿�' ������ ���� �����̸鼭 �޿��� '���¿�' ���� ���� �޴� ������ ��ȸ�Ѵٸ�?
SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '���¿�') AND
        SALARY > (SELECT    SALARY
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '���¿�');

-- �����޿��� �޴� ����� ������ �˻��Ѵٸ�?
SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = (SELECT    MIN(SALARY)
                  FROM      EMPLOYEE);
                  
-- �μ��� �޿������� ���� ���� �μ��� �μ��̸�, �޿������� ��ȸ�Ѵٸ�?
SELECT  DEPT_NAME,
        SUM(SALARY)
FROM    EMPLOYEE
JOIN    DEPARTMENT USING(DEPT_ID)
GROUP BY    DEPT_NAME
HAVING  SUM(SALARY) = (SELECT   MAX(SUM(SALARY))
                       FROM     EMPLOYEE
                       GROUP BY DEPT_ID);

/*
���� �� ��������
> ANY, < ANY
> ALL, < ALL
*/

-- �����ڵ鸸 ��ȸ�Ѵٸ�?
-- MGR_ID�� EMP_ID�� �ִٸ� ������
SELECT  EMP_ID,
        EMP_NAME,
        '������' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID IN (SELECT   MGR_ID
                   FROM     EMPLOYEE);
                   
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS "������ ����"
FROM    EMPLOYEE
WHERE   EMP_ID NOT IN (SELECT   MGR_ID
                       FROM     EMPLOYEE
                       WHERE    MGR_ID IS NOT NULL)
ORDER BY 3;

-- �븮, ���������� ����� �̸�, �޿� ��ȸ
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '����';

-- �������޺��� ���� �޿��� �޴� �븮���� ����̸�, �޿��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
AND     SALARY < ANY (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '����');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
AND     SALARY > ANY (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '����');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
AND     SALARY < ALL (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '����');

SELECT  EMP_NAME,
        SALARY,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
AND     SALARY > ALL (SELECT  SALARY
                      FROM    EMPLOYEE
                      JOIN    JOB USING(JOB_ID)
                      WHERE   JOB_TITLE = '����');

-- ���޺� ��ձ޿��� ��ȸ�ϰ� �ʹٸ�?
SELECT  JOB_TITLE,
        TRUNC(AVG(SALARY),-5)
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
GROUP BY    JOB_TITLE;

-- �ڱ� ������ ��� �޿��� �޴� ������ �̸�, ����, �޿� ��ȸ�Ѵٸ�? / �����÷�
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   (JOB_TITLE, SALARY) IN (SELECT  JOB_TITLE, TRUNC(AVG(SALARY),-5)
                                FROM    EMPLOYEE
                                JOIN    JOB USING(JOB_ID)
                                GROUP BY    JOB_TITLE);

-- FROM SUBQUERY / �ϳ��� ���� ���̺�� ���
SELECT  E.EMP_NAME,
        JOB_TITLE,
        V.JOBAVG
FROM    (SELECT  JOB_ID, TRUNC(AVG(SALARY),-5) JOBAVG
        FROM    EMPLOYEE
        JOIN    JOB USING(JOB_ID)
        GROUP BY    JOB_ID) V
JOIN    EMPLOYEE E ON (JOBAVG = SALARY AND E.JOB_ID = V.JOB_ID)
JOIN    JOB J ON (J.JOB_ID = E.JOB_ID);

-- ������� ��������(CORRELATED SUBQUERRY)
-- ������������ ó���Ǵ� �� ���� ���� ���� ���������� ������� �޶����� ���
SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E
JOIN    JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE   SALARY = (SELECT    TRUNC(AVG(SALARY), -5)
                  FROM      EMPLOYEE
                  WHERE     JOB_ID = E.JOB_ID);
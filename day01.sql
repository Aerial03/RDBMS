-- �˻�(SELECT)
/*
Ű����� �빮��, �����ʹ� ��ҹ��ڸ� ����
�������� ���ؼ� �� ���� �����ؼ� �ۼ�
SELECT * | [DISTINCT] COLUMN_NAME | ǥ���� | [AS] ALIAS(��Ī �ֱ�, AS���� ����) - ���������� �ϴ� �÷�����Ʈ
FROM TABLE_NAME - ��� ���̺�
WHERE SEARCH_CONDITION - �࿡ ���� ����, ����
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
WHERE   JOB_ID = 'J1'; -- �����͸� ''���� ���

-- ǥ����(�÷� ���� ���� ��� ����)
-- ��Ī ����: Ư������(����, ��ȣ, ��ȣ ��)�� ���Ե� ���, ���ڷ� ������ ��� �ݵ�� ""���� ���
SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 ANNUL_SALARY, -- AS
        (SALARY + (SALARY * BONUS_PCT)) * 12 "����(+���ʽ�)" -- AS
FROM    EMPLOYEE;

-- ���� �÷� �߰�
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS �ٹ�����
FROM    EMPLOYEE;

-- DISTINCT: �ߺ��� �����͸� 1���� ǥ��
-- SELECT ���� �� �ѹ��� ����� �� �ִ�.
SELECT  DISTINCT EMP_ID
FROM    EMPLOYEE;

-- �޿��� 4000000 ���� ���� ����� �̸��� �޿��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000;

-- �μ��ڵ尡 90�̰� �޿��� 2000000 ���� ���� ����� �μ��ڵ�, �޿� ��ȸ�Ѵٸ�?
SELECT  DEPT_ID �μ��ڵ�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' AND SALARY > 2000000;

-- �μ��ڵ尡 90�̰ų� 20�� �μ����� �̸�, �μ��ڵ�, �޿� ��ȸ�Ѵٸ�?
SELECT  DEPT_ID �μ��ڵ�,
        EMP_NAME �̸�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = '90' OR DEPT_ID = '20';

-- �μ��ڵ尡 90�̰ų� 20�� �μ����� �̸�, �μ��ڵ�, �޿� ��ȸ�Ѵٸ�? IN ������ ���
SELECT  DEPT_ID �μ��ڵ�,
        EMP_NAME �̸�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('90', '20'); -- OR = IN ���� �ǹ�

-- WHERE ������
-- ���Ῥ���� ||
SELECT  EMP_NAME||'�� ������ '||SALARY||' �Դϴ�.' ����
FROM    EMPLOYEE;

-- �������� AND, OR, NOT
-- �񱳿����� =, >, <, >=, <=, !=
-- �񱳿����� BETWEEN AND, LIKE, NOT LIKE, IS NULL, IS NOT NULL, IN
-- �޿��� 3500000 ���� ���� �ް�, 5500000 ���� ���� �޴� ������ �̸�, �޿� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

-- �达 ���� ���� ������ �̸�, �޿��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '��%'; -- %: ������ ���ڿ� ����

-- �达 ���� ������ ���� ������ �̸�, �޿��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        SALARY �޿�
FROM    EMPLOYEE
WHERE   EMP_NAME NOT LIKE '��%';

-- �̸��� ���̵��� ����� �� �ڸ����� ���ڸ����� ������ �̸�, �޿��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        EMAIL �̸���
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___#_%' ESCAPE '#'; -- #, \ ��: ���ϵ�ī�� ����

-- �����ȣ�� ���� �μ� ��ġ�� ���� ���� ����� �̸��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        MGR_ID �����ȣ,
        DEPT_ID �μ���ȣ
FROM    EMPLOYEE
WHERE   MGR_ID IS NULL AND DEPT_ID IS NULL;

-- �����ȣ�� �ְ� �μ� ��ġ�� ���� ����� �̸��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        MGR_ID �����ȣ,
        DEPT_ID �μ���ȣ
FROM    EMPLOYEE
WHERE   MGR_ID IS NOT NULL AND DEPT_ID IS NOT NULL;

-- �μ� ��ġ�� ���� �ʾ������� ���ʽ��� ���޹޴� ������ �̸��� ��ȸ�Ѵٸ�?
SELECT  EMP_NAME �̸�,
        DEPT_ID �μ���ȣ,
        BONUS_PCT ���ʽ�
FROM    EMPLOYEE
WHERE   DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

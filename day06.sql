-- DML()(INSERT, UPDATE, DELETE), CRUD
-- COMMIT, ROLLBACK
/*
���Ἲ ����
            �θ�       �ڽ�
UPDATE       X          O
INSERT       O          O
DELETE       X          O

-- ������ ���� ����
/*
UPDATE  TABLE_NAME
SET     COLUMN_NAME - VALUE | SUBQUERY, [COLUMN_NAME - VALUE]
[WHERE  CONDITION]
*/

SELECT  *
FROM    EMPLOYEE;

-- UPDATE  EMPLOYEE
-- SET     JOB_ID = 'J8', DEPT_ID = '90' -> J8�� ���� �������̹Ƿ� �ܷ�Ű�� ������ �ɷ��� ������
-- WHERE   EMP_NAME = '���ϱ�';

UPDATE  EMPLOYEE
SET     JOB_ID = (SELECT    JOB_ID
                  FROM      EMPLOYEE
                  WHERE     EMP_NAME = '���ر�'),
        DEPT_ID = '90'
WHERE   EMP_NAME = '���ϱ�';

UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_ID = '100';

-- INSERT
/*
INSERT INTO TABLE_NAME(COLUMN_NAME)
VALUES (VALUE1, VALUE2, DEFAULT)

INSERT INTO TABLE_NAME(COLUMN_NAME)
SUBQUERY
- ������ Ÿ�� ��ġ
- ���� ��ġ
- ���� ��ġ
*/
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO)
VALUES('900', '������', '123456-1234567');

-- DELETE: ���̺� ���Ե� ���� �����͸� ����
/*
DELETE FROM TABLE_NAME
[WHERE CONDITION];

TRUNCATE TABLE TABLE_NAME - ROLLBACK ��� �Ұ�
*/

/*
������ ���Ἲ ����
SELECT  *
FROM    DEPARTMENT
WHERE   LOC_ID LIKE 'A%';
*/

/*
�ڽ��� ���� �ִ� �θ����̺��̱� ������ ���� �Ұ�
DELETE
FROM    JOB
WHERE   JOB_ID = 'J2';

DELETE
FROM    EMPLOYEE
WHERE   EMP_ID = '141';
*/

-- TRANSACTION
-- �������� �ϰ����� �����ϱ� ���ؼ� ����ϴ� �������� ������ �۾����� ����
-- �ϳ��̻��� ������ DML ����
/*
INSERT~~
UPDATE~~
COMMIT/ROLLBACK

UPDATE
DELETE
CREATE - AUTO COMMIT
*/

-- ���ü� ����: ���������� ������, �� ���� ������ ���� ���̸� COMMIT ������ �ٸ� ������ ������ ������ LOCK �ɸ�
-- DDL(DATA DEFINITION LANGUAGE)
/*
TABLE
VIEW
SEQUENCE
INDEX

-- CONSTRAINT[PRIMARY KEY, FOREGN KEY, NOT NULL, UNIQUE, CHECK]
(�⺻����)
CREATE TABLE TABLE_NAME(
    COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN_CONSTRAINT],
    [TABLE_CONSTRAINT]
)

-- INSERT
INSERT INTO TABLE_NAME(COLUMN) VALUES(?,?,?,?)
*/
-- DROP TABLE TEST01;
CREATE TABLE TEST01(
    ID      NUMBER(5),
    NAME    VARCHAR2(50),
    ADDRESS VARCHAR2(50),
    REGDATE DATE DEFAULT SYSDATE
);

INSERT INTO TEST01(ID, NAME, ADDRESS)
VALUES(100, '�Ӽ���', '����');

INSERT INTO TEST01
VALUES(100, '�Ӽ���', '����', NULL);

INSERT INTO TEST01
VALUES(100, '�Ӽ���', '����', DEFAULT);

SELECT  *
FROM    TEST01;

DROP TABLE TEST01;

-- NOT NULL
-- ���̺� ������ ������ �� �� ����.

-- UNIQUE
CREATE TABLE TEST_NN(
    ID      VARCHAR(50) UNIQUE,
    PWD     VARCHAR(50)
    --  NOT NULL(ID) �Ұ���
);
INSERT INTO TEST_NN VALUES('JSLIM', 'JSLIM');
INSERT INTO TEST_NN VALUES(NULL, 'JSLIM');

SELECT  *
FROM    TEST_NN;

DROP TABLE TEST_NN;
-- NOT NULL�� UNIQUE�� �����ϸ� PRIMARY KEY�� ��

-- PRIMARY KEY: ���̺�� 1���� ����
-- NOT NULL + UNIQUE
CREATE TABLE TEST_PK(
    ID      VARCHAR2(50),
    NAME    VARCHAR2(50),
    PRIMARY KEY(ID, NAME)
);

INSERT INTO TEST_PK
VALUES('JSLIM', 'JSLIM');

INSERT INTO TEST_PK
VALUES('JSLIM', '�Ӽ���');

SELECT *
FROM    TEST_PK;

DROP TABLE TEST_PK;

-- FOREIGN KEY, REFERENCES
-- �θ� �����ϴ� �������̰ų� NULL�� ����Ѵ�.
-- DROP: �ڽĺ��� �����ؾ� �θ�Ű�� ���ŵ�
/*
DML(DELETE ~~~~)
REFERENCES [ON DELETE SET NULL] - �θ����̺� ���� ����, �÷��� NULL�� �ٲ�
REFERENCES [ON DELETE CASCADE] - �θ����̺� ���� ����, �����ϴ� ���ڵ� �����ͱ��� ����
*/

CREATE TABLE LOC(
    LOCATION_ID     VARCHAR2(50) PRIMARY KEY,
    LOC_DESC        VARCHAR2(50)
);
INSERT  INTO LOC VALUES(10, '�ƽþ�');
INSERT  INTO LOC VALUES(20, '����');
SELECT  *
FROM    LOC;

CREATE TABLE DEPT(
    DEPT_ID     NUMBER(5) PRIMARY KEY,
    DEPT_NAME   VARCHAR2(50),
    LOC_ID      VARCHAR2(50) NOT NULL,
    FOREIGN KEY(LOC_ID) REFERENCES LOC(LOCATION_ID)
);
INSERT INTO DEPT VALUES(10, '�λ���', 10);
INSERT INTO DEPT VALUES(20, '������', 20);
INSERT INTO DEPT VALUES(30, 'ȸ����', 20); -- NULL ������ ����
SELECT  *
FROM    DEPT;

SELECT  DEPT_NAME,
        LOC_DESC
FROM    DEPT
JOIN    LOC ON(LOCATION_ID = LOC_ID);

DROP TABLE DEPT;

CREATE TABLE EMP(
    EMP_ID      VARCHAR2(50) PRIMARY KEY,
    EMP_NAME    VARCHAR2(50),
    DEPT_ID     NUMBER(5)   REFERENCES DEPT(DEPT_ID)      
);
INSERT INTO EMP VALUES('100', 'JSLIM', 10);
INSERT INTO EMP VALUES('200', 'JSLIM', NULL);
SELECT  *
FROM    EMP;
DROP TABLE EMP;

CREATE TABLE SUPER_PK(
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    O_DATE  DATE,
    AMOUNT  NUMBER,
    PRIMARY KEY(U_ID, P_ID)
);
INSERT INTO SUPER_PK VALUES('JSLIM','P100',SYSDATE, 10000);
DROP TABLE SUPER_PK CASCADE CONSTRAINTS;

CREATE TABLE SUB_PK(
    SUB_ID  VARCHAR2(20) PRIMARY KEY,
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID, P_ID) REFERENCES SUPER_PK(U_ID, P_ID) ON DELETE CASCADE
);

CREATE TABLE SUB_PK(
    SUB_ID  VARCHAR2(20),
    U_ID    VARCHAR2(20),
    P_ID    VARCHAR2(20),
    FOREIGN KEY(U_ID, P_ID) REFERENCES SUPER_PK(U_ID, P_ID) ON DELETE CASCADE,
    PRIMARY KEY(SUB_ID, U_ID, P_ID)
);

INSERT INTO SUB_PK VALUES('SUB100','JSLIM','P100');
SELECT  *
FROM    SUB_PK;
DROP TABLE SUB_PK;

-- CHECK
-- ������ ������ �� ���ϴ� ���� �������� ����� �� ����.
CREATE TABLE TEST_CK(
    ID      VARCHAR2(50) PRIMARY KEY,
    SALARY  NUMBER,
    -- HIRE_DATE DATE CHECK(HIRE_DATE < SYSDATE),
    MARRIAGE CHAR(1),
    CHECK(SALARY BETWEEN 0 AND 100),
    CHECK(MARRIAGE IN ('Y', 'N'))
);
INSERT INTO TEST_CK VALUES('100', 100, 'Y');
SELECT  *
FROM    TEST_CK;
DROP TABLE TEST_CK;

-- DROP
-- DROP TABLE TABLE_NAME [CASCADE CONSTRAINTS] : ���谡 �ִ� �θ����̺���� ����

-- VIEW
-- ���̺��� �κ��������� ���������̳� ������ ������ �ܼ�ȭ�ϱ� ���ؼ� ����Ѵ�.
-- ���� ��(�Է�, ����, ���� ����, ���� ���̺� �ݿ�), ���� ��(�Է�, ����, ���� �Ұ���)
-- DROP VIEW VIEW_NAME
/*
[�⺻����]
CREATE [OR REPLACE] VIEW VIEW_NAME(ALIAS)
AS SUBQUERY;
*/
-- �μ���ȣ�� 90���� ����� �̸�, �μ���ȣ�� ������ �� �ִ� �並 �����Ѵٸ�?
CREATE OR REPLACE VIEW V_EMP_90 -- (A,B)�� ��� ��Ī��� ����
AS SELECT  EMP_NAME A,
           DEPT_ID B
   FROM    EMPLOYEE
   WHERE   DEPT_ID = '90';

SELECT  *
FROM    V_EMP_90;

-- �ζ��� �並 Ȱ���� TOP N �м��� �����ϴ�.
-- ���ǿ� �´� �ֻ��� �Ǵ� ������ ���ڵ� N���� �ĺ��� �� ���
/*
�м� ����
- ����
- RONNUM �̶�� ������ �÷��� �̿��ؼ� ���� ������� ���� �ο�
- �ο��� ������ �̿��ؼ� �ʿ��� �� ��ŭ �ĺ�
*/
SELECT  ROWNUM,
        EMP_NAME
FROM    EMPLOYEE;

SELECT  ROWNUM,
        EMP_NAME,
        SALARY
FROM    (SELECT  DEPT_ID,
                 ROUND(AVG(SALARY),-3) DAVG
         FROM    EMPLOYEE
         GROUP BY    DEPT_ID) V
JOIN    EMPLOYEE E ON(E.DEPT_ID = V.DEPT_ID)
WHERE   SALARY > V.DAVG
AND ROWNUM <= 5;

SELECT  ROWNUM, EMP_NAME, SALARY
FROM    (SELECT  ROWNUM,
                 EMP_NAME,
                 SALARY
         FROM    (SELECT  DEPT_ID,
                          ROUND(AVG(SALARY),-3) DAVG
                  FROM    EMPLOYEE
                  GROUP BY    DEPT_ID) V
         JOIN    EMPLOYEE E ON(E.DEPT_ID = V.DEPT_ID)
         WHERE   SALARY > V.DAVG
         ORDER BY 2 DESC)
WHERE ROWNUM = 1;

-- RANK()�� �̿��� TOP-N �м�
SELECT  *
FROM    (SELECT  EMP_NAME,
         SALARY,
         RANK() OVER(ORDER BY SALARY DESC) RANK
         FROM    EMPLOYEE)
WHERE   RANK <= 5;

-- SEQUENCE
-- ���������� ���� ������ �ڵ����� �����ϴ� ��ü
-- CREATE SEQUENCE SEQUENCE_NAME; : 1�������� 1�� ����, ���Ѵ�
-- NEXTVAL, CURRVAL
/*
CREAT SEQUENCE SEQUENCE_NAME
START WITH N : N���� ����
INCREMENT BY N : N�� ����
MAXVALUE N : �ִ� N
�⺻������ CYCLE ����
*/

CREATE SEQUENCE TEST_SEQ;
SELECT TEST_SEQ.NEXTVAL FROM DUAL;
SELECT TEST_SEQ.CURRVAL FROM DUAL;

DROP SEQUENCE TEST_SEQ;
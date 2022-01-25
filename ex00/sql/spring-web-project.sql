--=============================
-- system 계정 -- book_ex계정 생성
--=============================
alter session set "_oracle_script" = true; -- 일반사용자 c## 접두어 없이 계정생성

CREATE USER book_ex IDENTIFIED BY book_ex
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, DBA TO BOOK_EX;





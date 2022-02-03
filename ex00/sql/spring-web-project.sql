--=============================
-- system 계정 -- book_ex계정 생성
--=============================
alter session set "_oracle_script" = true; -- 일반사용자 c## 접두어 없이 계정생성

CREATE USER book_ex IDENTIFIED BY book_ex
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, DBA TO BOOK_EX;



--=============================
-- 오라클 데이터베이스 페이징 처리
--=============================
select * from tbl_board order by bno desc;

-- 재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행
/*
insert into tbl_board(bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);
*/
select count(*) from tbl_board;

























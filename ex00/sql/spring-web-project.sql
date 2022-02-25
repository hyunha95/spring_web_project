--=============================
-- system 계정 -- book_ex계정 생성
--=============================
alter session set "_oracle_script" = true; -- 일반사용자 c## 접두어 없이 계정생성

CREATE USER book_ex IDENTIFIED BY book_ex
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, DBA TO BOOK_EX;

--=============================
-- 테이블 생성
--=============================
create sequence seq_board;

create table tbl_board (
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(200) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_borad
primary key (bno);



--=============================
-- 오라클 데이터베이스 페이징 처리
--=============================
select * from tbl_board order by bno;

-- 재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행
/*
insert into tbl_board(bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);
*/
select count(*) from tbl_board;

select
    /*+ INDEX_DESC(tbl_board pk_board) */
    *
from
    tbl_board
where bno > 0;

select rownum rn, bno, title from tbl_board;

select 
    /*+ FULL(tbl_board) */
    rownum rn, bno, title
from
    tbl_board
where
    bno > 0
order by bno;

select
    /*+ INDEX_ASC (tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board;
    
select
    /*+ INDEX_DESC (tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board
where rownum > 10 and rownum <= 20;

-- ROWNUM은 반드시 1이 포함되도록 해야 한다.
select
    rn, bno, title, content
from(
select 
    /*+INDEX_DESC(tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board
where
    rownum <= 20
)
where
    rn > 10;

-- 검색처리
select
    *
from(
    select
        /*+INDEX_DESC(tbl_board pk_board) */
        rownum rn, bno, title, content, writer, regdate, updatedate
    from
        tbl_board
    where
        (title like '%테스트%' or content like '%테스트%')
        and
        rownum <= 20
)
where
    rn > 10;



select * from tbl_board order by bno desc;

create table tbl_reply (
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);







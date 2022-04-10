--=============================
-- system 계정 -- book_ex계정 생성
--=============================
alter session set "_oracle_script" = true; -- 일반사용자 c## 접두어 없이 계정생성

CREATE USER book_ex IDENTIFIED BY book_ex
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, DBA TO BOOK_EX;


--=============================
-- 포트번호 변경
--=============================
select dbms_xdb.gethttpport() from dual;
exec dbms_xdb.sethttpport(9090);


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

insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');
commit;
select * from tbl_board;






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

-- 댓글 처리를 위한 테이블
create table tbl_reply (
    rno number(10,0),
    bno number(10,0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key(rno);
alter table tbl_reply add constraint fk_reply_board foreign key(bno) references tbl_board(bno);

select * from tbl_board where rownum < 10 order by bno desc;
select * from tbl_reply order by rno desc;

insert into tbl_reply
values(13, 3, '오늘 날짜 테스트', '현하', sysdate, sysdate);


-- 인덱스를 이용한 페이징 쿼리
create index idx_reply on tbl_reply (bno desc, rno asc);

select rno, bno, reply, replyer, replyer, replydate, updatedate
from(
    select /*+INDEX(tbl_reply idx_reply) */
        rownum rn, bno, rno, reply, replyer, replydate, updatedate
    from tbl_reply
    where bno = 3
            and rno > 0
            and rownum <= 20
) where rn > 10;


select rno, bno, reply, replyer, replydate, updatedate
		from
			(
			select /*+INDEX(tbl_reply idx_reply) */
				rownum, rn, rno, bno, reply, replyer, replyDate, updatedate
			from tbl_reply
			where bno = 3
			and rno > 0
			and rownum <= 20
			) where rn > 10;
select * from tbl_reply where bno = 3;

create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col2 varchar2(50));



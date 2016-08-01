
--[1] member

DROP TABLE MEMBER
CASCADE CONSTRAINT;

SELECT * FROM MEMBER

CREATE TABLE MEMBER(
	M_ID VARCHAR2(50) PRIMARY KEY,
	M_PW VARCHAR2(50) NOT NULL,
	M_NAME VARCHAR2(100) NOT NULL,
	M_EMAIL VARCHAR2(200) NOT NULL,
	M_AUTH NUMBER NOT NULL,
	M_PHOTO VARCHAR2(100) NOT NULL
)

INSERT INTO MEMBER
VALUES('qwer', 'qwer', 'kwon', 'qwer@qwer', 3, 'd')
INSERT INTO MEMBER
VALUES('hong', 'hong', 'hong', 'hong@hong', 3, 'a')

--[2] movie : MV_LIKE : 좋아요, MV_ON : 상영중인영화

DROP TABLE MOVIE
CASCADE CONSTRAINT;

DROP SEQUENCE MV_SEQ; 

SELECT * FROM MOVIE

CREATE TABLE MOVIE(
	MV_SEQ NUMBER PRIMARY KEY,
	MV_TITLE VARCHAR2(200) NOT NULL,
	MV_OPENDAY DATE NOT NULL,
	MV_GENRE VARCHAR2(50) NOT NULL,
	MV_STORY VARCHAR2(2000) NOT NULL,
	MV_IMG VARCHAR2(500) NOT NULL,
	MV_COUNT NUMBER NOT NULL,	
	MV_LIKE NUMBER NOT NULL,
	MV_HATE NUMBER NOT NULL,
	MV_ON NUMBER NOT NULL
)

CREATE SEQUENCE MV_SEQ
START WITH 1 INCREMENT BY 1

INSERT INTO MOVIE
VALUES(MV_SEQ.NEXTVAL, '부산행', '20160720', '액션', '정체불명의 바이러스가 전국으로 확산되고 대한민국 긴급재난경보령이 선포된 가운데,열차에 몸을 실은 사람들은 단 하나의 안전한 도시 부산까지 살아가기 위한 치열한 사투를 벌이게 된다.'
, 'http://img.cgv.co.kr/Movie/Thumbnail/Poster/000078/78982/78982_185.jpg', '0', '0', '0', '1')


INSERT INTO MOVIE
VALUES(MV_SEQ.NEXTVAL, '제이슨본', '20160727', '액션,스릴러', '모든 자취를 숨기고 사라졌던 제이슨 본, 그는 되찾은 기억 외에 과거를 둘러싼 또 다른 음모가 있다는 것을 알게 되고 마침내 CIA 앞에 자신의 존재를 드러내게 되는데… 가장 완벽하고 가장 치명적인 무기 ‘제이슨 본’ 이제 모든 것이 그에게 달렸다'
,'http://img.cgv.co.kr/Movie/Thumbnail/Poster/000078/78981/78981_185.jpg', '0', '0', '0', '1')


INSERT INTO MOVIE
VALUES(MV_SEQ.NEXTVAL, '인천상륙작전', '20160727', '드라마, 전쟁', '1950년 6월 25일 북한의 기습 남침으로 불과 사흘 만에 서울 함락, 한 달 만에 낙동강 지역을 제외한 한반도 전 지역을 빼앗기게 된 대한민국. 국제연합군 최고사령관 더글라스 맥아더(리암 니슨)는 모두의 반대 속 인천상륙작전을 계획한다. 성공확률 5000:1, 불가능에 가까운 작전. 이를 가능케 하는 것은 단 하나, 인천으로 가는 길이 확보되어야 하는 것뿐이다. 맥아더의 지시로 대북 첩보작전 X-RAY에 투입된 해군 첩보부대 대위 장학수(이정재)는 북한군으로 위장 잠입해 인천 내 동태를 살피며 정보를 수집하기 시작한다. 하지만 인천 방어사령관 림계진(이범수)에 의해 정체가 발각되는 위기에 놓인 가운데 장학수와 그의 부대원들은 전세를 바꿀 단 한번의 기회, 단 하루의 작전을 위해 인천상륙 함대를 유도하는 위험천만한 임무에 나서는데... 역사를 바꾼 비밀 연합작전 그 시작은 바로 그들이었다! '
, 'http://img.cgv.co.kr/Movie/Thumbnail/Poster/000078/78994/78994_185.jpg', '0', '0', '0', '1')

INSERT INTO MOVIE
VALUES(MV_SEQ.NEXTVAL, '도리를찾아서', '20160706', '애니메이션, 어드벤처, 코미디, 가족', '무엇을 상상하든 그 이상을 까먹는 ‘도리’의 어드벤쳐가 시작된다! 니모를 함께 찾으면서 베스트 프렌드가 된 도리와 말린은 우여곡절 끝에 다시 고향으로 돌아가 평화로운 일상을 보내고 있다. 모태 건망증 도리가 ‘기억’이라는 것을 하기 전까지! 도리는 깊은 기억 속에 숨어 있던 가족의 존재를 떠올리고 니모와 말린과 함께 가족을 찾아 대책 없는 어드벤쳐를 떠나게 되는데…깊은 바다도 막을 수 없는 스펙터클한 어드벤쳐가 펼쳐진다! 
', 'http://img.cgv.co.kr/Movie/Thumbnail/Poster/000078/78907/78907_185.jpg', '0', '0', '0', '1')



--[3] theater

DROP TABLE THEATER
CASCADE CONSTRAINT;

DROP SEQUENCE TH_SEQ; 

SELECT * FROM THEATER

CREATE TABLE THEATER(
	TH_SEQ NUMBER PRIMARY KEY,
	TH_NAME VARCHAR2(100) NOT NULL,
	MV_SEQ NUMBER NOT NULL, 
	TH_CINEMA VARCHAR2(500) NOT NULL,
	TH_NUM NUMBER NOT NULL,
	TH_TOTALSEAT NUMBER NOT NULL,
	TH_LEFTSEAT NUMBER NOT NULL,
	TH_TIME DATE NOT NULL
)

CREATE SEQUENCE TH_SEQ
START WITH 1 INCREMENT BY 1

ALTER TABLE THEATER 
ADD CONSTRAINT FK_THEATER_MV_SEQ FOREIGN KEY(MV_SEQ)
REFERENCES MOVIE(MV_SEQ);

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '명동', 1, '1관', 1, 90, 90, to_date('16-07-29 12:30:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '명동', 1, '1관', 2, 90, 90, to_date('16-07-29 3:00:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '명동', 1, '3관', 1, 90, 90, to_date('16-07-29 17:30:00','YY-MM-DD HH24:MI:SS'))


INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '명동', 2, '2관', 1, 90, 90, to_date('16-07-29 13:00:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '대학로', 4, '1관', 1, 90, 90, to_date('16-07-29 15:00:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '신촌', 3, '1관', 1, 90, 90, to_date('16-07-29 10:00:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '강남', 1, '1관', 1, 90, 90, to_date('16-07-29 20:00:00','YY-MM-DD HH24:MI:SS'))

INSERT INTO THEATER
VALUES(TH_SEQ.NEXTVAL, '강남', 4, '1관', 1, 90, 90, to_date('20160729123000','YYYYMMDDHH24MISS'))



--[4] SEAT : 

DROP TABLE SEAT
CASCADE CONSTRAINT;

DROP SEQUENCE S_SEQ; 

SELECT * FROM SEAT ORDER BY S_SEQ
 
CREATE TABLE SEAT(
	S_SEQ NUMBER PRIMARY KEY,
	TH_SEQ NUMBER NOT NULL,
	S_NAME VARCHAR2(50) NOT NULL,
	S_CHECK NUMBER(1)
)

CREATE SEQUENCE S_SEQ
START WITH 1 INCREMENT BY 1


ALTER TABLE SEAT 
ADD CONSTRAINT FK_SEAT_TH_SEQ FOREIGN KEY(TH_SEQ)
REFERENCES THEATER(TH_SEQ);

--[5] reservation : 예매
DROP TABLE RESERVATION
CASCADE CONSTRAINT;

DROP SEQUENCE R_SEQ

SELECT * FROM RESERVATION

CREATE TABLE RESERVATION(
	R_SEQ NUMBER PRIMARY KEY,
	M_ID VARCHAR2(50) NOT NULL,
	TH_SEQ NUMBER NOT NULL,
	MV_SEQ NUMBER NOT NULL, 
	R_POLL NUMBER NOT NULL,
	R_TOTALPRICE NUMBER NOT NULL,
	R_ADULT NUMBER NOT NULL,
	R_STUDENT NUMBER NOT NULL,
	R_ELDER NUMBER NOT NULL,
	R_SEAT VARCHAR2(50) NOT NULL,
	R_TIME DATE NOT NULL,
	R_VIEWTIME DATE NOT NULL,
	R_THNAME VARCHAR2(100) NOT NULL,
	R_CINEMA VARCHAR2(500) NOT NULL
)

CREATE SEQUENCE R_SEQ
START WITH 1 INCREMENT BY 1

ALTER TABLE RESERVATION 
ADD CONSTRAINT FK_RESERVATION_M_ID FOREIGN KEY(M_ID)
REFERENCES MEMBER(M_ID);

ALTER TABLE RESERVATION 
ADD CONSTRAINT FK_RESERVATION_TH_SEQ FOREIGN KEY(TH_SEQ)
REFERENCES THEATER(TH_SEQ);

ALTER TABLE RESERVATION 
ADD CONSTRAINT FK_RESERVATION_MV_SEQ FOREIGN KEY(MV_SEQ)
REFERENCES MOVIE(MV_SEQ);


--[6] PRICE : 영화가격표 // P_GRADE : ADULT, STUDENT, ELDER

DROP TABLE PRICE
CASCADE CONSTRAINT;

DROP SEQUENCE P_SEQ

SELECT * FROM PRICE

CREATE TABLE PRICE(
	P_SEQ NUMBER PRIMARY KEY,
	P_GRADE VARCHAR2(10) NOT NULL,
	P_PRICE NUMBER NOT NULL
)

CREATE SEQUENCE P_SEQ
START WITH 1 INCREMENT BY 1


INSERT INTO PRICE VALUES(P_SEQ.NEXTVAL, 'adult', '10000')
INSERT INTO PRICE VALUES(P_SEQ.NEXTVAL, 'student', '8000')
INSERT INTO PRICE VALUES(P_SEQ.NEXTVAL, 'elder', '5000')

-- [7] FRIEND : (SNS)

DROP TABLE FRIEND
CASCADE CONSTRAINT;

SELECT * FROM FRIEND

CREATE TABLE FRIEND()


-- [8] REVIEW : (SNS)

DROP TABLE REVIEW
CASCADE CONSTRAINT;

SELECT * FROM REVIEW

CREATE TABLE REVIEW(
	r_seq number(5) primary key,
	m_id varchar2(50) not null,
	mv_seq number not null,
	r_title varchar2(500) not null,
	r_content varchar2(3000) not null,
	r_writedate date default sysdate,
	r_like number default 0,
	r_readcount number default 0
)

alter table REVIEW
add constraint fk_review_id foreign key(m_id)
references member(m_id)

alter table REVIEW
add constraint fk_review_mv_seq foreign key(mv_seq)
references movie(mv_seq)

drop sequence review_seq;
create sequence review_seq
start with 1 increment by 1;



insert into review (r_seq,m_id,r_title,r_content) values (review_seq.nextval,'hong','안녕하세요1','안녕하세요1');
insert into review (r_seq,m_id,r_title,r_content) values (review_seq.nextval,'hong','안녕하세요2','안녕하세요2');
insert into review (r_seq,m_id,r_title,r_content) values (review_seq.nextval,'hong','안녕하세요3','안녕하세요3');


-- [9] r_comment : (SNS - 댓글)

DROP TABLE r_comment
CASCADE CONSTRAINT;

SELECT * FROM r_comment

CREATE TABLE r_comment(
	com_seq number(5) primary key,
	r_seq number(5) not null,
	m_id varchar2(50) not null,
	com_content varchar2(500) not null,
	com_writedate date default sysdate
)

alter table r_comment
add constraint fk_comment_r_seq foreign key(r_seq)
references review(r_seq)

drop sequence comment_seq;
create sequence comment_seq
start with 1 increment by 1;

insert into r_comment values (comment_seq.nextval,1,'hong','ㅋㅋㅋㅋ아닌듯',sysdate);
insert into r_comment values (comment_seq.nextval,1,'ma','간지나요',sysdate);


--by ay
SELECT R_POLL FROM RESERVATION WHERE M_ID='qwer' AND MV_SEQ=1
insert into review (r_seq,m_id,mv_seq,r_title,r_content) values (review_seq.nextval,'qwer', 1,'안녕하세요1','안녕하세요1');
insert into review (r_seq,m_id,mv_seq,r_title,r_content) values (review_seq.nextval,'hong', 1,'실사 블록버스터에 새긴 연상호적인 순간들','지금껏 연상호 감독이 스크린 밖 현실을 벨 듯이 휘둘러온 날카로운 칼날을 기대한 관객이라면 그것이 다소 무뎌진 것에 아쉬움을 느낄 수 있다. 하지만 [부산행]이 여름 시장을 겨냥한 재난 블록버스터, 게다가 실사라는 점을 고려한다면 이 정도의 타협은 납득할 만하다. (한때 인간이었던) 좀비를 때려잡는 자극적인 화면이 아닌, 인물들의 감정으로 기승전결의 곡선을 그리며 달려가는 [부산행]은 인간에 대한 관심과 예의를 담은 연상호적인 순간들을 탄생시켰다. 더 좋은 어른, 더 좋은 사회의 일원이 되고 싶다는 감독의 고민이 명징하게 담긴 블록버스터는 드물다.');
--시간만 불러오기
SELECT TO_CHAR(TH_TIME, 'HH24:MI') 
FROM THEATER
WHERE TH_NAME='명동'

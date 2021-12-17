--create users table, user_id for seller and buyer
CREATE TABLE ecm_users (
    user_id     NUMBER NOT NULL ,
    nama_user   VARCHAR2(50) NOT NULL ,
    kode_pos    NUMBER ,
    email       varchar2(50),
    --add primary key
    CONSTRAINT pk_user_id PRIMARY KEY (user_id)
);
/

desc ecm_users;
/

--insert record batch
INSERT ALL
    into ecm_users values(10,'Jenie Puspasari',25073,'prasastavirman@hotmail.com')
    into ecm_users  values(11,'Dina Pratama',26414,'hilda87@cv.or.id')
    into ecm_users  values(12,'Oliva Tamba',04251,'adriansyahcager@hotmail.com')
    into ecm_users  values(100,'Mursinin Maryati',81617,'dabukkehari@hotmail.com')
    into ecm_users  values(111,'Ratna Kuswandari',24316,'umegantara@hotmail.com')
    into ecm_users  values(122,'Jamalia Prasetya',91409,'waluyokarman@hotmail.com')
    into ecm_users  values(133,'Bambang Gunarto',85267,'praba03@gmail.com')
SELECT * FROM dual;
/

select * from ecm_users;
/

INSERT INTO ecm_users VALUES (13,'Bima Yoga',01452,'jensenta@hotmail.com');
/

--modify table not null
ALTER TABLE ecm_users MODIFY email VARCHAR2(150) NOT NULL ;
/

--check if field is null
INSERT INTO ecm_users VALUES (14,'Yogantara',02222,'');
/

select * from ecm_users;
/

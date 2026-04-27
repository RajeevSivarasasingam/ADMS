create database trans;
use trans;
create table t(
	name char(20),
    unique(name))
    engine=InnoDB;

 -- 
start transaction;
insert into t (name) values('william');
insert into t (name) values('wallace');
rollback;

select * from t;

START TRANSACTION;
INSERT INTO t(name) VALUES ('Gormit');
INSERT INTO t(name) VALUES ('Wallace');

DROP TABLE t;
CREATE TABLE t (name CHAR(20), UNIQUE (name)) ENGINE=InnoDB;
SET autocommit = 0;
INSERT INTO t(name) VALUES ('William');
INSERT INTO t(name) VALUES ('Wallace');
COMMIT;
select * from t;

CREATE TABLE t2 (i INT) ENGINE=InnoDB;
START TRANSACTION;
INSERT INTO t2 VALUES (1);
SAVEPOINT my_savepoint;
INSERT INTO t2 VALUES (2);
ROLLBACK TO SAVEPOINT my_savepoint;
INSERT INTO t2 VALUES (3);
COMMIT;
SELECT * FROM t2;



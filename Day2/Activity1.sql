 
 --1.Create two users student_1 and student_2 with the password '123456' at the localhost
CREATE USER 'student_1'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'student_2'@'localhost' IDENTIFIED BY '123456';


--2.listdown the created users
SELECT user, host FROM user;
	+-----------+-----------+
	| User      | Host      |
	+-----------+-----------+
	| root      | 127.0.0.1 |
	| root      | ::1       |
	| Rajeev    | localhost |
	| pma       | localhost |
	| root      | localhost |
	| student_1 | localhost |
	| student_2 | localhost |
	+-----------+-----------+
	7 rows in set (0.001 sec)

--3.change the user name of student_1 with your registration number.
UPDATE user set user='2021ICT102' where user='student_1';

--4.listdown the username and password
select user,host,password from user;
	+------------+-----------+-------------------------------------------+
	| User       | Host      | Password                                  |
	+------------+-----------+-------------------------------------------+
	| root       | localhost |                                           |
	| Rajeev     | localhost |                                           |
	| root       | 127.0.0.1 |                                           |
	| root       | ::1       |                                           |
	| pma        | localhost |                                           |
	| 2021ICT102 | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
	| student_2  | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
	+------------+-----------+-------------------------------------------+

--5.change the password of student_2 with a new password
SET PASSWORD FOR 'student_2'@'localhost' = PASSWORD('654321');

--6.listdown the username and password again
select user,host,password from user;
	+------------+-----------+-------------------------------------------+
	| User       | Host      | Password                                  |
	+------------+-----------+-------------------------------------------+
	| root       | localhost |                                           |
	| Rajeev     | localhost |                                           |
	| root       | 127.0.0.1 |                                           |
	| root       | ::1       |                                           |
	| pma        | localhost |                                           |
	| 2021ICT102 | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
	| student_2  | localhost | *2A032F7C5BA932872F0F045E0CF6B53CF702F2C5 |
	+------------+-----------+-------------------------------------------+
	
--7.chage the host f student_2 to 'vau.ac.lk'.
UPDATE user set host='vau.ac.lk' where user='student_2';


--8.list down the username and host name
select user,host,password from user;

	+------------+-----------+-------------------------------------------+
	| User       | Host      | Password                                  |
	+------------+-----------+-------------------------------------------+
	| root       | localhost |                                           |
	| Rajeev     | localhost |                                           |
	| root       | 127.0.0.1 |                                           |
	| root       | ::1       |                                           |
	| pma        | localhost |                                           |
	| 2021ICT102 | localhost | *6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9 |
	| student_2  | vau.ac.lk | *2A032F7C5BA932872F0F045E0CF6B53CF702F2C5 |
	+------------+-----------+-------------------------------------------+



 
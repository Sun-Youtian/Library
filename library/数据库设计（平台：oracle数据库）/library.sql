--查询默认表空间和临时表空间
select default_tablespace,temporary_tablespace from dba_users where username ='SYSTEM';

--删除表
drop table student cascade CONSTRAINTS;

--查看已建表结构
select * from User_info;
select * from Student;
select * from Readroom;
select * from Seat;
select * from Blacklist;
select * from Book;

--查看主键约束
select constraint_type,constraint_name
from dba_constraints
where table_name = 'USER_INFO';--必须全部大写，否则查不出来

select constraint_type,constraint_name
from dba_constraints
where table_name = 'STUDENT';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'READROOM';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'SEAT';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'BLACKLIST';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'BOOK';

--查看外键约束
select constraint_type,constraint_name
from dba_constraints
where table_name = 'BLACKLIST';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'BOOK';

--删除存储过程
drop procedure pro_2;

--按条件删除数据
delete from Seat 
where seat_id = '001';

--创建表
CREATE table User_info--用户信息表
(
    user_id varchar2(20),--账号
    user_passwd varchar2(20),--密码
    user_identity varchar2(20)--身份（学生，管理员）
);

CREATE table Student--学生信息表
(
    student_id varchar2(20),
    student_name varchar2(20),
    student_sex varchar2(20),
    student_institute varchar2(20),--学院
    student_class varchar2(20),
    student_phone varchar2(20),
    student_state varchar2(20)--状态（学习中，中途离开，离馆）
);

CREATE table Readroom--学习区域信息表
(
    readroom_id varchar2(20),
    readroom_name varchar2(20),--名称
    readroom_seat_sum varchar2(20),--座位总数量
    readroom_seat_num_now varchar2(20),--已使用座位数量
    readroom_state varchar2(20)--状态（开放，关闭）
);

CREATE table Seat--座位信息表
(
    seat_id varchar2(20),
    readroom_name varchar2(20),--所属学习区域名称
    seat_state varchar2(20)--状态（使用中，未使用）
);

CREATE table Blacklist--黑名单信息表
(
    blacklist_id varchar2(20),
    add_time varchar2(20),--加入时间
    end_time varchar2(20),--移出时间
    student_id varchar2(20),
    student_name varchar2(20),
    blacklist_state varchar2(20),--状态（已移出，未移出）
    reason varchar2(20)--原因
);

CREATE table Book--预约历史信息表（映射关系产生的表，不是实体）
(
    book_id varchar2(20),
    book_start_time varchar2(20),--开始预约时间
    book_finish_time varchar2(20),--结束预约时间
    student_id varchar2(20),
    student_name varchar2(20),
    readroom_name varchar2(20),
    seat_id varchar2(20)
);

--添加主键约束
alter table User_info
add CONSTRAINT pk_user_id PRIMARY KEY(user_id); 

alter table Student
add CONSTRAINT pk_student_id PRIMARY KEY(student_id); 

alter table Readroom
add CONSTRAINT pk_readroom_id PRIMARY KEY(readroom_id); 

alter table Seat
add CONSTRAINT pk_seat_id PRIMARY KEY(seat_id); 

alter table Blacklist
add CONSTRAINT pk_blacklist_id PRIMARY KEY(blacklist_id); 

alter table Book
add CONSTRAINT pk_book_id PRIMARY KEY(book_id); 

--添加外键约束
alter table Blacklist
add constraint fk_student_id foreign key(student_id )
references Student(student_id);

alter table Book
add constraint fk_student_id2 foreign key(student_id )
references Student(student_id);

alter table Book
add constraint fk_seat_id foreign key(seat_id)
references Seat(seat_id);

--触发器
--当一个座位被预约成功时，座位表中的座位状态也随之更改
create or replace trigger tri_1
after insert on Book
for each row
begin
    update Seat set seat_state='使用中' where seat_id=:new.seat_id;
end;
/
--当一个座位被清理时，座位表中的座位状态也随之更改
create or replace trigger tri_2
after delete on Book
for each row
begin
    update Seat set seat_state='未使用' where seat_id=:old.seat_id;
end;
/

--显示设置
set serverout on;
--存储过程
--建立存储过程pro_1, 输入学生的学号，查询学生的预约历史信息
create procedure pro_1(p_student_id in varchar2)
as 
cursor cursor_book--定义游标
is select * from Book where student_id = p_student_id;
cur_record Book%rowtype;--格式设置
begin
    open cursor_book;
    loop
        fetch cursor_book into cur_record;
        exit when cursor_book%notfound;--判断游标中是否存在数据
        dbms_output.put_line('预约编号：'||cur_record.book_id);
        dbms_output.put_line('开始预约时间：'||cur_record.book_start_time);
        dbms_output.put_line('结束预约时间：'||cur_record.book_finish_time);
        dbms_output.put_line('学生编号：'||cur_record.student_id);  
        dbms_output.put_line('学生姓名：'||cur_record.student_name);
        dbms_output.put_line('阅览室名称：'||cur_record.readroom_name);                     
        dbms_output.put_line('座位编号：'||cur_record.seat_id);                              
    end loop;
    close cursor_book;
end;
/
--调用存储过程
exec pro_1('201903');

--建立存储过程pro_2, 输入学生的学号，查询学生的黑名单信息
create procedure pro_2(p_student_id in varchar2)
as 
cursor cursor_blacklist--定义游标
is select * from Blacklist where student_id = p_student_id;
cur_record Blacklist%rowtype;--格式设置
begin
    open cursor_blacklist;
    loop
        fetch cursor_blacklist into cur_record;
        exit when cursor_blacklist%notfound;--判断游标中是否存在数据
        dbms_output.put_line('黑名单编号：'||cur_record.blacklist_id);
        dbms_output.put_line('加入时间：'||cur_record.add_time);
        dbms_output.put_line('结束时间：'||cur_record.end_time);
        dbms_output.put_line('学生编号：'||cur_record.student_id);  
        dbms_output.put_line('学生姓名：'||cur_record.student_name);
        dbms_output.put_line('黑名单状态：'||cur_record.blacklist_state);                     
        dbms_output.put_line('原因：'||cur_record.reason);                              
    end loop;
    close cursor_blacklist;
end;
/
--调用存储过程
exec pro_2('201902');

--输入数据
--向用户信息表添加的数据
insert into User_info values('0001','0001','管理员');
insert into User_info values('201901','201901','学生');
insert into User_info values('201902','201902','学生');
insert into User_info values('201903','201903','学生');
--向学生信息表添加的数据
insert into Student values('201901','孙友田','女','信息工程学院','17信管1班','12345678910','离馆');
insert into Student values('201902','张晓明','男','外国语学院','18翻译2班','12345678911','离馆');
insert into Student values('201903','魏小白','女','陶瓷艺术学院','18雕塑1班','12345678912','学习中');

--向学习区域信息表添加的数据
insert into Readroom values('01','负一楼自习室','150','1','开放');

--向座位信息表添加的数据
insert into Seat values('001','负一楼自习室','使用中');
insert into Seat values('002','负一楼自习室','未使用');
--向黑名单信息表添加的数据
insert into Blacklist values('1','2019-10-11 12:00','2019-10-11 18：00','201902','张晓明','未移出','未及时归还');

--向预约历史信息表中添加信息
insert into Book values('1','2019-10-11 8:00','2019-10-11 8：05','201903','魏小白','负一楼自习室','001');
insert into Book values('2','2019-10-11 8:00','2019-10-11 8：05','201901','孙友田','负一楼自习室','002');
delete from Book 
where Book_id = '2';







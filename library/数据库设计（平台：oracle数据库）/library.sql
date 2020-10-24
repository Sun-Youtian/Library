--��ѯĬ�ϱ�ռ����ʱ��ռ�
select default_tablespace,temporary_tablespace from dba_users where username ='SYSTEM';

--ɾ����
drop table student cascade CONSTRAINTS;

--�鿴�ѽ���ṹ
select * from User_info;
select * from Student;
select * from Readroom;
select * from Seat;
select * from Blacklist;
select * from Book;

--�鿴����Լ��
select constraint_type,constraint_name
from dba_constraints
where table_name = 'USER_INFO';--����ȫ����д������鲻����

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

--�鿴���Լ��
select constraint_type,constraint_name
from dba_constraints
where table_name = 'BLACKLIST';

select constraint_type,constraint_name
from dba_constraints
where table_name = 'BOOK';

--ɾ���洢����
drop procedure pro_2;

--������ɾ������
delete from Seat 
where seat_id = '001';

--������
CREATE table User_info--�û���Ϣ��
(
    user_id varchar2(20),--�˺�
    user_passwd varchar2(20),--����
    user_identity varchar2(20)--��ݣ�ѧ��������Ա��
);

CREATE table Student--ѧ����Ϣ��
(
    student_id varchar2(20),
    student_name varchar2(20),
    student_sex varchar2(20),
    student_institute varchar2(20),--ѧԺ
    student_class varchar2(20),
    student_phone varchar2(20),
    student_state varchar2(20)--״̬��ѧϰ�У���;�뿪����ݣ�
);

CREATE table Readroom--ѧϰ������Ϣ��
(
    readroom_id varchar2(20),
    readroom_name varchar2(20),--����
    readroom_seat_sum varchar2(20),--��λ������
    readroom_seat_num_now varchar2(20),--��ʹ����λ����
    readroom_state varchar2(20)--״̬�����ţ��رգ�
);

CREATE table Seat--��λ��Ϣ��
(
    seat_id varchar2(20),
    readroom_name varchar2(20),--����ѧϰ��������
    seat_state varchar2(20)--״̬��ʹ���У�δʹ�ã�
);

CREATE table Blacklist--��������Ϣ��
(
    blacklist_id varchar2(20),
    add_time varchar2(20),--����ʱ��
    end_time varchar2(20),--�Ƴ�ʱ��
    student_id varchar2(20),
    student_name varchar2(20),
    blacklist_state varchar2(20),--״̬�����Ƴ���δ�Ƴ���
    reason varchar2(20)--ԭ��
);

CREATE table Book--ԤԼ��ʷ��Ϣ��ӳ���ϵ�����ı�����ʵ�壩
(
    book_id varchar2(20),
    book_start_time varchar2(20),--��ʼԤԼʱ��
    book_finish_time varchar2(20),--����ԤԼʱ��
    student_id varchar2(20),
    student_name varchar2(20),
    readroom_name varchar2(20),
    seat_id varchar2(20)
);

--�������Լ��
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

--������Լ��
alter table Blacklist
add constraint fk_student_id foreign key(student_id )
references Student(student_id);

alter table Book
add constraint fk_student_id2 foreign key(student_id )
references Student(student_id);

alter table Book
add constraint fk_seat_id foreign key(seat_id)
references Seat(seat_id);

--������
--��һ����λ��ԤԼ�ɹ�ʱ����λ���е���λ״̬Ҳ��֮����
create or replace trigger tri_1
after insert on Book
for each row
begin
    update Seat set seat_state='ʹ����' where seat_id=:new.seat_id;
end;
/
--��һ����λ������ʱ����λ���е���λ״̬Ҳ��֮����
create or replace trigger tri_2
after delete on Book
for each row
begin
    update Seat set seat_state='δʹ��' where seat_id=:old.seat_id;
end;
/

--��ʾ����
set serverout on;
--�洢����
--�����洢����pro_1, ����ѧ����ѧ�ţ���ѯѧ����ԤԼ��ʷ��Ϣ
create procedure pro_1(p_student_id in varchar2)
as 
cursor cursor_book--�����α�
is select * from Book where student_id = p_student_id;
cur_record Book%rowtype;--��ʽ����
begin
    open cursor_book;
    loop
        fetch cursor_book into cur_record;
        exit when cursor_book%notfound;--�ж��α����Ƿ��������
        dbms_output.put_line('ԤԼ��ţ�'||cur_record.book_id);
        dbms_output.put_line('��ʼԤԼʱ�䣺'||cur_record.book_start_time);
        dbms_output.put_line('����ԤԼʱ�䣺'||cur_record.book_finish_time);
        dbms_output.put_line('ѧ����ţ�'||cur_record.student_id);  
        dbms_output.put_line('ѧ��������'||cur_record.student_name);
        dbms_output.put_line('���������ƣ�'||cur_record.readroom_name);                     
        dbms_output.put_line('��λ��ţ�'||cur_record.seat_id);                              
    end loop;
    close cursor_book;
end;
/
--���ô洢����
exec pro_1('201903');

--�����洢����pro_2, ����ѧ����ѧ�ţ���ѯѧ���ĺ�������Ϣ
create procedure pro_2(p_student_id in varchar2)
as 
cursor cursor_blacklist--�����α�
is select * from Blacklist where student_id = p_student_id;
cur_record Blacklist%rowtype;--��ʽ����
begin
    open cursor_blacklist;
    loop
        fetch cursor_blacklist into cur_record;
        exit when cursor_blacklist%notfound;--�ж��α����Ƿ��������
        dbms_output.put_line('��������ţ�'||cur_record.blacklist_id);
        dbms_output.put_line('����ʱ�䣺'||cur_record.add_time);
        dbms_output.put_line('����ʱ�䣺'||cur_record.end_time);
        dbms_output.put_line('ѧ����ţ�'||cur_record.student_id);  
        dbms_output.put_line('ѧ��������'||cur_record.student_name);
        dbms_output.put_line('������״̬��'||cur_record.blacklist_state);                     
        dbms_output.put_line('ԭ��'||cur_record.reason);                              
    end loop;
    close cursor_blacklist;
end;
/
--���ô洢����
exec pro_2('201902');

--��������
--���û���Ϣ����ӵ�����
insert into User_info values('0001','0001','����Ա');
insert into User_info values('201901','201901','ѧ��');
insert into User_info values('201902','201902','ѧ��');
insert into User_info values('201903','201903','ѧ��');
--��ѧ����Ϣ����ӵ�����
insert into Student values('201901','������','Ů','��Ϣ����ѧԺ','17�Ź�1��','12345678910','���');
insert into Student values('201902','������','��','�����ѧԺ','18����2��','12345678911','���');
insert into Student values('201903','κС��','Ů','�մ�����ѧԺ','18����1��','12345678912','ѧϰ��');

--��ѧϰ������Ϣ����ӵ�����
insert into Readroom values('01','��һ¥��ϰ��','150','1','����');

--����λ��Ϣ����ӵ�����
insert into Seat values('001','��һ¥��ϰ��','ʹ����');
insert into Seat values('002','��һ¥��ϰ��','δʹ��');
--���������Ϣ����ӵ�����
insert into Blacklist values('1','2019-10-11 12:00','2019-10-11 18��00','201902','������','δ�Ƴ�','δ��ʱ�黹');

--��ԤԼ��ʷ��Ϣ���������Ϣ
insert into Book values('1','2019-10-11 8:00','2019-10-11 8��05','201903','κС��','��һ¥��ϰ��','001');
insert into Book values('2','2019-10-11 8:00','2019-10-11 8��05','201901','������','��һ¥��ϰ��','002');
delete from Book 
where Book_id = '2';







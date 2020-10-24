from django.db import models

class User(models.Model):#用户
    user_id = models.CharField(max_length=20)#学/工号
    user_passwd = models.CharField(max_length=20)#密码
    user_identity = models.CharField(max_length=20)#身份（学生，管理员）

class Student(models.Model):  # 学生
    student_id = models.CharField(max_length=20)
    student_passwd = models.CharField(max_length=20)#密码
    student_name = models.CharField(max_length=20)
    student_sex = models.CharField(max_length=20)
    student_institute = models.CharField(max_length=20)#学院
    student_class = models.CharField(max_length=20)
    student_phone = models.CharField(max_length=20)
    student_state = models.CharField(max_length=20)#状态（学习中，中途离开，离馆）

class Seat(models.Model):#座位
    seat_id = models.CharField(max_length=20)
    seat_state = models.CharField(max_length=20)#状态（使用中，暂留，未使用）
    readroom_id = models.CharField(max_length=20)#所属阅览室编号

class Readroom(models.Model):#阅览室
    readroom_id = models.CharField(max_length=20)
    readroom_name = models.CharField(max_length=20)#名称
    readroom_seat_sum = models.CharField(max_length=20)#座位总数量
    readroom_seat_num_now = models.CharField(max_length=20)#已使用的座位数量
    readroom_state = models.CharField(max_length=20)#状态（开放，关闭）

class Book(models.Model):#预约历史
    book_id = models.CharField(max_length=20)
    book_start_time = models.CharField(max_length=20)#开始预约时间
    book_finish_time = models.CharField(max_length=20)#结束预约时间
    student_id = models.CharField(max_length=20)
    student_name = models.CharField(max_length=20)
    readroom_id = models.CharField(max_length=20)
    seat_id = models.CharField(max_length=20)

class Blacklist(models.Model):#黑名单
    blacklist_id = models.CharField(max_length=20)
    add_time = models.CharField(max_length=20)#加入时间
    end_time = models.CharField(max_length=20)#移出时间
    student_id = models.CharField(max_length=20)
    student_name = models.CharField(max_length=20)
    blacklist_state = models.CharField(max_length=20)#状态（已移出，未移出）
    reason = models.CharField(max_length=20)#原因

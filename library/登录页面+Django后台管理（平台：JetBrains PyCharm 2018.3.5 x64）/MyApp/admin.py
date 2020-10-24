from django.contrib import admin

from MyApp.models import*

# class DeptAdmin(admin.ModelAdmin):
#     list_display=['dept_name','dept_manager','dept_manager']
#     fields = ('dept_name',)
#     search_fields = ['dept_name']
# admin.site.register(Dept,DeptAdmin)
class UserAdmin(admin.ModelAdmin):
    list_display=['user_id','user_passwd','user_identity',]
admin.site.register(User,UserAdmin)
class StudentAdmin(admin.ModelAdmin):
    list_display=['student_id','student_passwd','student_name','student_sex','student_institute','student_class','student_phone','student_state',]
admin.site.register(Student,StudentAdmin)
class ReadroomAdmin(admin.ModelAdmin):
    list_display=['readroom_id','readroom_name','readroom_seat_sum','readroom_seat_num_now','readroom_state',]
admin.site.register(Readroom,ReadroomAdmin)
class BookAdmin(admin.ModelAdmin):
    list_display=['book_id','book_start_time','book_finish_time','student_id','student_name','readroom_id','seat_id',]
admin.site.register(Book,BookAdmin)
class BlacklistAdmin(admin.ModelAdmin):
    list_display=['blacklist_id','add_time','end_time','student_id','student_name','blacklist_state','reason',]
admin.site.register(Blacklist,BlacklistAdmin)
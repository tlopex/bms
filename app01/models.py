from django.db import models
from datetime import date
# Create your models here.
from django.utils import timezone

# 出版社类
class Publisher(models.Model):
    id = models.AutoField('序号', primary_key=True)
    name = models.CharField('名称', max_length=64)
    addr = models.CharField('地址', max_length=64)


# 书籍的类
class Book(models.Model):
    id = models.AutoField('序号', primary_key=True)
    name = models.CharField('书名', max_length=64, null=True)
    author = models.ForeignKey('Author', on_delete=models.SET_NULL, null=True, verbose_name='作者',
                               related_name='books')
    price = models.DecimalField('价格', max_digits=10, decimal_places=2)
    ISBN = models.CharField('书号', max_length=64)
    publisher = models.ForeignKey(Publisher, on_delete=models.CASCADE, verbose_name='出版社')
    summary = models.TextField('摘要', blank=True, null=True)


# 作者的类
class Author(models.Model):
    id = models.AutoField('序号', primary_key=True)
    name = models.CharField('姓名', max_length=64)
    sex = models.CharField('性别', max_length=4)
    age = models.IntegerField('年龄', default=0)
    tel = models.CharField('联系方式', max_length=64)
    book = models.ManyToManyField(to=Book, related_name='authors')


# 用户的类
class LmsUser(models.Model):
    id = models.AutoField('序号', primary_key=True)
    username = models.CharField('用户名', max_length=32)
    password = models.CharField('密码', max_length=32)
    email = models.CharField('邮箱', max_length=254)
    mobile = models.BigIntegerField('手机',blank='True')
    is_admin = models.BooleanField('管理员', default=False)


# 读者的类
class Reader(models.Model):
    card_number = models.CharField('卡号', max_length=32, primary_key=True)
    name = models.CharField('姓名', max_length=64)
    gender = models.CharField('性别', max_length=10)
    department = models.CharField('单位', max_length=100)
    reader_type = models.CharField('类型', max_length=50)
    level = models.CharField('级别', max_length=50)

# 借阅的类
class Borrow(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE, verbose_name='图书')
    reader = models.ForeignKey(Reader, on_delete=models.CASCADE, verbose_name='读者')
    borrow_date = models.DateField('借书时间')
    return_date = models.DateField('还书时间', null=True, blank=True)
    fine = models.DecimalField('罚款金额', max_digits=6, decimal_places=2, default=0.00)


    def calculate_fine(self):
        if self.return_date and timezone.now().date() > self.return_date:
            overdue_days = (timezone.now().date() - self.return_date).days
            self.fine = 5.00 + overdue_days - 1
            self.save()

    class Meta:
        unique_together = ('book', 'reader')
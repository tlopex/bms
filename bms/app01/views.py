import hashlib
from datetime import datetime, timedelta
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.db import IntegrityError
from django.contrib import messages
from django.utils import timezone

from app01 import models
from app01.models import Reader, LmsUser
from .models import Borrow, Book


import re
from .commom import SendMailHelper

def setPassword(password):

    md5 = hashlib.md5()
    md5.update(password.encode())
    password = md5.hexdigest()
    return str(password)


def reset_password(request):
    message = ""
    if request.method == "POST":
        username = request.POST.get('username')
        email = request.POST.get('email')
        user = LmsUser.objects.filter(username=username, email=email).first()

        if user is not None:
            receivers = [email]
            smtp_host = 'smtp.qq.com'
            smtp_port = 465
            sender = '1828189361@qq.com'
            password = 'fkgjcsznbtfgcgai'
            subject = '重置您的帐户密码'

            smtper = SendMailHelper(smtp_host, smtp_port, sender, receivers, subject, password)
            mail_msg = """
            <p>点击下面重置密码的链接</p>
            <p><a href="http://127.0.0.1:8000/update_password/">重置密码</a></p>
            """
            smtper.add_html(mail_msg)
            smtper.send()
            message = '已发送邮件'
        else:
            message = '用户不存在'

    return render(request, 'reset_password.html', {'message': message})


from django.shortcuts import render, redirect

from .models import LmsUser
import re

def update_password(request):
    message = ""  # 用于存储信息的变量
    if request.method == "POST":
        username = request.POST.get('username')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')

        if re.match("^(?:(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])).*$", password1) is None:
            message = '密码必须包括字母大小写和数字'
        elif len(password1) < 6 or len(password1) > 20:
            message = '密码长度应在6到20位之间'
        elif password2 != password1:
            message = '两次输入的密码不一致'
        else:
            user = LmsUser.objects.filter(username=username).first()
            if user:
                user.password = setPassword(password1)
                user.save()
                message = '密码已重置，可以登录'
            else:
                message = '用户不存在'

    return render(request, 'update_password.html', {'message': message})



def publisher_list(request):
    publisher = models.Publisher.objects.all()
    return render(request, 'pub_list.html', {'pub_list': publisher})




def add_publisher(request):
    if request.method == 'POST':
        new_publisher_name = request.POST.get('name')
        new_publisher_addr = request.POST.get('addr')
        models.Publisher.objects.create(name=new_publisher_name, addr=new_publisher_addr)
        return redirect('/pub_list/')
    return render(request, 'pub_add.html')



def edit_publisher(request):
    if request.method == 'POST':
        edit_id = request.GET.get('id')
        edit_obj = models.Publisher.objects.get(id=edit_id)
        new_name = request.POST.get('edit_name')
        new_addr = request.POST.get('edit_addr')
        edit_obj.name = new_name
        edit_obj.addr = new_addr
        edit_obj.save()
        return redirect('/pub_list/')

    edit_id = request.GET.get('id')
    edit_obj = models.Publisher.objects.get(id=edit_id)
    return render(request, 'pub_edit.html', {'publisher': edit_obj})



def drop_publisher(request):
    drop_id = request.GET.get('id')
    drop_obj = models.Publisher.objects.get(id=drop_id)
    drop_obj.delete()
    return redirect('/pub_list/')


def author_list(request):
    author = models.Author.objects.all()
    return render(request, 'auth_list.html', {'author_list': author})


def add_author(request):
    if request.method == 'POST':
        new_author_name = request.POST.get('name')
        new_author_sex = request.POST.get('sex')
        new_author_age = request.POST.get('age')
        new_author_tel = request.POST.get('tel')
        models.Author.objects.create(name=new_author_name, sex=new_author_sex, age=new_author_age, tel=new_author_tel)
        return redirect('/author_list/')
    return render(request, 'author_add.html')


def drop_author(request):
    drop_id = request.GET.get('id')
    drop_obj = models.Author.objects.get(id=drop_id)
    drop_obj.delete()
    return redirect('/author_list/')


def edit_author(request):
    if request.method == 'POST':
        edit_id = request.GET.get('id')
        edit_obj = models.Author.objects.get(id=edit_id)
        new_author_name = request.POST.get('edit_name')
        new_author_sex = request.POST.get('edit_sex')
        new_author_age = request.POST.get('edit_age')
        new_author_tel = request.POST.get('edit_tel')
        new_book_id = request.POST.getlist('book_id')
        edit_obj.name = new_author_name
        edit_obj.sex = new_author_sex
        edit_obj.age = new_author_age
        edit_obj.tel= new_author_tel
        edit_obj.book.set(new_book_id)
        edit_obj.save()
        return redirect('/author_list/')
    edit_id = request.GET.get('id')
    edit_obj = models.Author.objects.get(id=edit_id)
    all_book = models.Book.objects.all()
    return render(request, 'auth_edit.html', {
        'author': edit_obj,
        'book_list': all_book
    })


def book_list(request):
    book = models.Book.objects.all()
    return render(request, 'book_list.html', {'book_list': book})




def approve_book(request):
    pending_book = request.session.get('pending_book')

    if request.method == 'POST':
        if 'approve' in request.POST and pending_book:
            # 获取作者和出版社的实例
            author = models.Author.objects.get(id=pending_book['author'])
            publisher = models.Publisher.objects.get(id=pending_book['publisher'])

            # 创建新书
            models.Book.objects.create(
                name=pending_book['name'],
                ISBN=pending_book['ISBN'],
                price=pending_book['price'],
                summary=pending_book['summary'],
                author=author,
                publisher=publisher
            )
            messages.success(request, "新书添加已批准。")
            del request.session['pending_book']
        elif 'reject' in request.POST:
            messages.info(request, "新书添加已拒绝。")
            del request.session['pending_book']

        return redirect('/approve_book/')

    return render(request, 'approve_book.html', {'pending_book': pending_book})


def add_book(request):
    if request.method == 'POST':
        publisher_id = request.POST.get('publisher_id')
        author_id = request.POST.get('author_id')

        # 检查出版社和作者是否存在
        try:
            publisher = models.Publisher.objects.get(id=publisher_id)
            author = models.Author.objects.get(id=author_id)
        except (models.Publisher.DoesNotExist, models.Author.DoesNotExist):
            messages.error(request, "出版社或作者不存在，请检查您的输入。")
            return redirect('/add_book/')

        # 收集书籍信息并存储在会话中
        request.session['pending_book'] = {
            'name': request.POST.get('name'),
            'ISBN': request.POST.get('ISBN'),
            'price': request.POST.get('price'),
            'summary': request.POST.get('summary'),
            'publisher': publisher_id,
            'author': author_id,
        }
        messages.info(request, "新书添加请求已提交审批。")
        return redirect('/add_book/')
    else:
        publishers = models.Publisher.objects.all()
        authors = models.Author.objects.all()
        return render(request, 'book_add.html', {'publisher_list': publishers, 'author_list': authors})


# def drop_book(request):
#     drop_id = request.GET.get('id')
#     drop_obj = models.Book.objects.get(id=drop_id)
#     drop_obj.delete()
#     return redirect('/book_list/')



def drop_book(request):
    book_id = request.GET.get('id')
    if not book_id:
        messages.error(request, "没有提供图书ID。")
        return redirect('/book_list/')

    book = get_object_or_404(models.Book, id=book_id)

    # 将待删除图书的信息存储在会话中
    request.session['pending_delete_book'] = {
        'id': book.id,
        'name': book.name,
        'author': book.author.name if book.author else '',
        'ISBN': book.ISBN,
        'price': str(book.price),
        'summary': book.summary,
        'publisher': book.publisher.name if book.publisher else ''
    }
    messages.info(request, "删除图书请求已提交审批。")
    return redirect('/book_list/')


def approve_delete_book(request):
    pending_delete_book = request.session.get('pending_delete_book')

    if request.method == 'POST':
        if 'approve' in request.POST and pending_delete_book:
            # 找到对应的图书记录并删除
            book = models.Book.objects.get(id=pending_delete_book['id'])
            book.delete()
            messages.success(request, "图书删除成功。")
            del request.session['pending_delete_book']
        elif 'reject' in request.POST:
            del request.session['pending_delete_book']
            messages.info(request, "图书删除请求已拒绝。")

        return redirect('/approve_delete_book/')

    return render(request, 'approve_delete_book.html', {'pending_delete_book': pending_delete_book})

from django.shortcuts import redirect, render
from django.contrib import messages
from . import models

def approve_ebook(request):
    pending_edit = request.session.get('pending_edit')

    if request.method == 'POST':
        if 'approve' in request.POST and pending_edit:
            # 获取对应的书籍实例
            book = models.Book.objects.get(id=pending_edit['id'])

            # 获取作者和出版社的实例
            author = models.Author.objects.get(id=pending_edit['author'])
            publisher = models.Publisher.objects.get(id=pending_edit['publisher'])

            # 更新书籍信息
            book.name = pending_edit['name']
            book.ISBN = pending_edit['ISBN']
            book.price = pending_edit['price']
            book.summary = pending_edit['summary']
            book.author = author
            book.publisher = publisher
            book.save()

            messages.success(request, "书籍修改已批准。")
            del request.session['pending_edit']
        elif 'reject' in request.POST:
            messages.info(request, "书籍修改已拒绝。")
            del request.session['pending_edit']

        return redirect('/approve_ebook/')

    return render(request, 'approve_ebook.html', {'pending_edit': pending_edit})


# def edit_book(request):
#     edit_id = request.GET.get('id')
#     edit_obj = models.Book.objects.get(id=edit_id)
#
#     if request.method == 'POST':
#         new_book_name = request.POST.get('edit_name')
#         new_book_ISBN = request.POST.get('edit_ISBN')
#         new_book_price = request.POST.get('edit_price')
#         new_book_summary = request.POST.get('edit_summary')
#         new_publisher_id = request.POST.get('publisher_id')
#         new_author_id = request.POST.get('author_id')
#
#         try:
#             publisher = models.Publisher.objects.get(id=new_publisher_id)
#             author = models.Author.objects.get(id=new_author_id)
#         except (models.Publisher.DoesNotExist, models.Author.DoesNotExist):
#             messages.error(request, "出版社或作者不存在，请检查您的输入。")
#             return render(request, 'book_edit.html', {
#                 'book': edit_obj,
#                 'publisher_list': models.Publisher.objects.all(),
#                 'author_list': models.Author.objects.all()
#             })
#
#         edit_obj.name = new_book_name
#         edit_obj.ISBN = new_book_ISBN
#         edit_obj.price = new_book_price
#         edit_obj.summary = new_book_summary
#         edit_obj.publisher_id = new_publisher_id
#         edit_obj.author_id = new_author_id
#         edit_obj.save()
#
#         return redirect('/book_list/')
#
#     publishers = models.Publisher.objects.all()
#     authors = models.Author.objects.all()
#     return render(request, 'book_edit.html', {
#         'book': edit_obj,
#         'publisher_list': publishers,
#         'author_list': authors
#     })

def edit_book(request):
    edit_id = request.GET.get('id')
    edit_obj = models.Book.objects.get(id=edit_id)

    if request.method == 'POST':
        new_book_name = request.POST.get('edit_name')
        new_book_ISBN = request.POST.get('edit_ISBN')
        new_book_price = request.POST.get('edit_price')
        new_book_summary = request.POST.get('edit_summary')
        new_publisher_id = request.POST.get('publisher_id')
        new_author_id = request.POST.get('author_id')

        try:
            publisher = models.Publisher.objects.get(id=new_publisher_id)
            author = models.Author.objects.get(id=new_author_id)
        except (models.Publisher.DoesNotExist, models.Author.DoesNotExist):
            messages.error(request, "出版社或作者不存在，请检查您的输入。")
            return render(request, 'book_edit.html', {
                'book': edit_obj,
                'publisher_list': models.Publisher.objects.all(),
                'author_list': models.Author.objects.all()
            })

        # 与添加书籍类似，我们将编辑的信息存储在会话中
        request.session['pending_edit'] = {
            'id': edit_id,
            'name': new_book_name,
            'ISBN': new_book_ISBN,
            'price': new_book_price,
            'summary': new_book_summary,
            'publisher': new_publisher_id,
            'author': new_author_id,
        }



        messages.info(request, "编辑书籍请求已提交审批。")

    publishers = models.Publisher.objects.all()
    authors = models.Author.objects.all()
    return render(request, 'book_edit.html', {
        'book': edit_obj,
        'publisher_list': publishers,
        'author_list': authors
    })




def edit_user(request):
    user_id = request.GET.get('id')  # 使用 GET 参数获取用户 ID
    user = LmsUser.objects.get(id=user_id)  # 直接使用 get 方法获取用户对象

    if request.method == 'POST':
        # 直接从 POST 数据中获取新的用户信息
        new_username = request.POST.get('username')
        new_password = request.POST.get('password')
        new_email = request.POST.get('email')
        new_mobile = request.POST.get('mobile')
        new_is_admin = request.POST.get('is_admin') == 'on'  # 检查是否勾选了管理员选项

        if LmsUser.objects.exclude(id=user.id).filter(username=new_username).exists():
            messages.error(request, "用户名已存在，请选择其他用户名。")
            return redirect('/edit_user/?id=' + str(user.id))  # 重定向回编辑页面
        # 更新用户信息
        if new_username:
            user.username = new_username
        if new_password:
            user.password = setPassword(new_password)  # 假设 setPassword 是您用于加密密码的函数
        if new_email:
            user.email = new_email
        if new_mobile:
            user.mobile = new_mobile
        user.is_admin = new_is_admin

        user.save()
        return redirect('/admin_user_management/')  # 更新成功后重定向

    # 对于 GET 请求，显示编辑表单
    return render(request, 'edit_user.html', {'user': user})


def delete_user(request):
    user_id = request.GET.get('id')  # 从 URL 的 GET 参数中获取用户 ID
    user = LmsUser.objects.get(id=user_id)  # 根据 ID 获取用户对象

    user.delete()  # 删除用户对象
    return redirect('/admin_user_management/')  # 删除后重定向到用户管理页面




def admin_user_management(request):
    users = LmsUser.objects.all()
    return render(request, 'admin_user_management.html', {'users': users})





def login(request):
    error_message = None
    if request.method == 'POST' and request.POST:
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = LmsUser.objects.filter(username=username).first()
        if user:
            now_password = setPassword(password)
            db_password = user.password
            if now_password == db_password:
                if user.is_admin:
                    # 如果用户是管理员，重定向到管理员主页
                    return HttpResponseRedirect('/admin_home/')
                else:
                    # 如果用户不是管理员，重定向到普通用户主页
                    return HttpResponseRedirect('/index/')
            else:
                error_message = "用户名或密码错误，请重新输入。"
        else:
            error_message = "用户名或密码错误，请重新输入。"

    return render(request, "login.html", {"error_message": error_message})

def admin_home(request):
    return render(request, 'admin_home.html')



def register(request):
    error_message = None  # 初始化错误消息
    if request.method == "POST" and request.POST:
        username = request.POST.get("username")
        # 检查用户名是否已存在
        if LmsUser.objects.filter(username=username).exists():
            error_message = "用户名已存在，请选择其他用户名。"
        else:
            email = request.POST.get("email")
            password = request.POST.get("password")
            mobile = request.POST.get("mobile")

            try:
                LmsUser.objects.create(
                    username=username,
                    email=email,
                    password=setPassword(password),
                    mobile=mobile,
                )
                return HttpResponseRedirect('/login/')  # 注册成功后重定向到登录页面
            except Exception as e:
                print("注册错误:", e)  # 打印异常信息
                error_message = "注册失败，请稍后重试。"

    # 包含错误消息的渲染
    return render(request, "register.html", {"error_message": error_message})




def borrow_book(request):
    # 借书限制
    borrow_limits = {
        '本科生': 3,  # 本科生
        '研究生': 4,       # 研究生
        '教职工': 5           # 教职工
    }

    if request.method == 'POST':
        book_id = request.POST.get('book_id')
        reader_card_number = request.POST.get('reader_card_number')

        book = get_object_or_404(Book, id=book_id)
        reader = get_object_or_404(Reader, card_number=reader_card_number)

        # 检查书籍是否已被借出
        if Borrow.objects.filter(book=book).exists():
            messages.error(request, "此书已被借出，请选择其他书籍。")
            return redirect('/borrow_book/')

        # 检查读者借书限制
        current_borrow_count = Borrow.objects.filter(reader=reader).count()
        reader_limit = borrow_limits.get(reader.reader_type, 0)

        if current_borrow_count >= reader_limit:
            messages.error(request, f"超出借书限制，该类读者只能借 {reader_limit} 本书。")
            return redirect('/borrow_book/')

        # 添加借书记录
        borrow_date = datetime.now().date()
        return_date = borrow_date + timedelta(days=30)

        Borrow.objects.create(
            book=book,
            reader=reader,
            borrow_date=borrow_date,
            return_date=return_date
        )

        messages.success(request, "借书记录添加成功！")
        return redirect('/borrow_book/')

    else:
        books = Book.objects.all()
        readers = Reader.objects.all()
        borrows = Borrow.objects.select_related('book', 'reader').all()
        return render(request, 'borrow_book.html', {
            'books': books,
            'readers': readers,
            'borrows': borrows
        })



def drop_borrow(request):
    borrow_id = request.GET.get('id')
    if borrow_id:
        borrow = models.Borrow.objects.get(id=borrow_id)
        borrow.delete()
        messages.success(request, "还书成功！")
        return redirect('/borrow_book/')
    else:
        return HttpResponse("An error occurred, no borrow ID provided.")



from django.shortcuts import render, redirect
from django.contrib import messages

def approve_reader(request):
    pending_reader = request.session.get('pending_reader')


    if request.method == 'POST':
        if 'approve' in request.POST:
            # 如果管理员批准，创建新的读者对象
            Reader.objects.create(**pending_reader)
            messages.success(request, "读者添加已批准。")
            del request.session['pending_reader']
        elif 'reject' in request.POST:
            messages.info(request, "读者添加已拒绝。")
            del request.session['pending_reader']

        return redirect('/approve_reader/')

    return render(request, 'approve_reader.html', {'pending_reader': pending_reader})

def add_reader(request):
    if request.method == 'POST':
        card_number = request.POST.get('card_number')
        if Reader.objects.filter(card_number=card_number).exists():
            messages.error(request, "读者卡号已经存在。")
            return redirect('/reader_add/')
        else:
            request.session['pending_reader'] = {
                'card_number': card_number,
                'name': request.POST.get('name'),
                'gender': request.POST.get('gender'),
                'department': request.POST.get('department'),
                'reader_type': request.POST.get('reader_type'),
                'level': request.POST.get('level')
            }
            messages.info(request, "读者添加请求已提交审批。")
            return redirect('/reader_add/')
    else:
        return render(request, 'reader_add.html')


def reader_list(request):
    readers = Reader.objects.all()
    return render(request, 'reader_list.html', {'readers': readers})


# def edit_reader(request):
#     card_number = request.GET.get('card_number')
#     if not card_number:
#         return redirect('/reader_list/')
#
#     reader = get_object_or_404(Reader, card_number=card_number)
#
#     if request.method == 'POST':
#         reader.name = request.POST.get('name')
#         reader.gender = request.POST.get('gender')
#         reader.department = request.POST.get('department')
#         reader.reader_type = request.POST.get('reader_type')
#         reader.level = request.POST.get('level')
#         reader.save()
#         return redirect('/reader_list/')
#
#     return render(request, 'reader_edit.html', {'reader': reader})



def edit_reader(request):
    card_number = request.GET.get('card_number')


    reader = get_object_or_404(models.Reader, card_number=card_number)

    if request.method == 'POST':
        # 将编辑的信息存储在会话中而不是直接保存
        request.session['pending_edit_reader'] = {
            'card_number': card_number,
            'name': request.POST.get('name'),
            'gender': request.POST.get('gender'),
            'department': request.POST.get('department'),
            'reader_type': request.POST.get('reader_type'),
            'level': request.POST.get('level'),
        }
        messages.info(request, "编辑读者请求已提交审批。")


    return render(request, 'reader_edit.html', {'reader': reader})

def approve_edit_reader(request):
    pending_edit_reader = request.session.get('pending_edit_reader')

    if request.method == 'POST':
        if 'approve' in request.POST and pending_edit_reader:
            # 找到对应的读者记录
            reader = models.Reader.objects.get(card_number=pending_edit_reader['card_number'])

            # 更新读者信息
            reader.name = pending_edit_reader['name']
            reader.gender = pending_edit_reader['gender']
            reader.department = pending_edit_reader['department']
            reader.reader_type = pending_edit_reader['reader_type']
            reader.level = pending_edit_reader['level']
            reader.save()

            messages.success(request, "读者信息修改已批准。")
            del request.session['pending_edit_reader']
        elif 'reject' in request.POST:
            messages.info(request, "读者信息修改已拒绝。")
            del request.session['pending_edit_reader']

        return redirect('/approve_edit_reader/')

    return render(request, 'approve_edit_reader.html', {'pending_edit_reader': pending_edit_reader})
def delete_reader(request):
    card_number = request.GET.get('card_number')


    reader = get_object_or_404(models.Reader, card_number=card_number)

    # 将待删除读者的完整信息存储在会话中
    request.session['pending_delete_reader'] = {
        'card_number': reader.card_number,
        'name': reader.name,
        'gender': reader.gender,
        'department': reader.department,
        'reader_type': reader.reader_type,
        'level': reader.level
    }
    messages.info(request, "删除读者请求已提交审批。")
    return redirect('/reader_list/')

from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages
from . import models

def approve_delete_reader(request):
    pending_delete = request.session.get('pending_delete_reader')

    if request.method == 'POST':
        if 'approve' in request.POST and pending_delete:
            # 找到对应的读者记录并删除
            reader = models.Reader.objects.get(card_number=pending_delete['card_number'])
            reader.delete()
            messages.success(request, "读者删除成功。")
            del request.session['pending_delete_reader']
        elif 'reject' in request.POST:

            del request.session['pending_delete_reader']
            messages.info(request, "读者删除请求已拒绝。")

        return redirect('/approve_delete_reader/')

    return render(request, 'approve_delete_reader.html', {'pending_delete': pending_delete})


def index(request):
    return render(request, 'index.html')



def manage_fines(request):
    if request.method == 'POST':
        borrow_id = request.POST.get('borrow_id')
        fine_amount = request.POST.get('fine_amount')
        borrow = models.Borrow.objects.get(id=borrow_id)
        borrow.fine = fine_amount
        borrow.save()
        return redirect('/fine_processing/')
    else:

        today = timezone.now().date()
        borrows = models.Borrow.objects.filter(
            return_date__lt=today,
            return_date__isnull=False
        )
        for borrow in borrows:
            if borrow.fine == 0.00:
                borrow.calculate_fine()
        return render(request, 'fine_processing.html', {'borrows': borrows})






def extend_return_date(request):
    borrow_id = request.GET.get('id')
    if borrow_id:
        borrow = models.Borrow.objects.get(id=borrow_id)
        if borrow.return_date:
            borrow.return_date += timedelta(days=30)
        else:
            borrow.return_date = datetime.now().date() + timedelta(days=30)
        borrow.save()
        messages.success(request, "还书日期已成功延长一个月。")
    else:
        messages.error(request, "无效的借书记录ID。")
    return redirect('/borrow_book/')

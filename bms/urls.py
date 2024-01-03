from django.conf.urls import url
from django.contrib import admin
from django.urls import path

from app01 import views

urlpatterns = [
    path('admin/', admin.site.urls),
    url(r'^$', views.login),
    url(r'^index/', views.index, name='index'),
    url(r'^admin_home/', views.admin_home, name='admin_home'),
    url(r'^pub_list/', views.publisher_list),
    url(r'^add_pub/', views.add_publisher),
    url(r'^edit_pub/', views.edit_publisher),
    url(r'^drop_pub/', views.drop_publisher),
    url(r'^author_list/', views.author_list),
    url(r'^add_author/', views.add_author),
    url(r'^drop_author/', views.drop_author),
    url(r'^edit_author/', views.edit_author),
    url(r'^book_list/', views.book_list),
    url(r'^add_book/', views.add_book),
    url(r'^drop_book/', views.drop_book),
    url(r'^edit_book/', views.edit_book),
    url(r'^login/', views.login,name='login'),
    url(r'^signup/', views.register,name='signup'),
    url(r'^register/', views.register),
    url(r'^reader_list/', views.reader_list, name='reader_list'),
    url(r'^borrow_book/', views.borrow_book, name='borrow_book'),
    url(r'^drop_borrow/', views.drop_borrow, name='drop_borrow'),
    url(r'^reader_add/', views.add_reader, name='reader_add'),
    url(r'^edit_reader/', views.edit_reader, name='reader_edit'),
    url(r'^delete_reader/',views.delete_reader,name="delete_reader"),
    url(r'^fine_processing/',views.manage_fines,name="manage_fines"),
    url(r'^extend_return_date/', views.extend_return_date, name='extend_return_date'),
    url(r'^admin_user_management/', views.admin_user_management, name='admin_user_management'),
    url(r'^edit_user/', views.edit_user, name='edit_user'),
    url(r'^delete_user/', views.delete_user, name='delete_user'),
    url(r'^approve_reader/', views.approve_reader, name='approve_reader'),
    url('approve_edit_reader/', views.approve_edit_reader, name='approve_edit_reader'),
    url('approve_delete_reader/', views.approve_delete_reader, name='approve_delete_reader'),
    url('approve_delete_book/', views.approve_delete_book, name='approve_delete_book'),
    url('approve_book/', views.approve_book, name='approve_book'),
    url('approve_ebook/', views.approve_ebook, name='approve_ebook'),
    url('reset_password/',views.reset_password),
    url('update_password/',views.update_password),
]

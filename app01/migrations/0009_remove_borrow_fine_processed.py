# Generated by Django 3.2.13 on 2023-12-28 08:03

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0008_lmsuser_is_admin'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='borrow',
            name='fine_processed',
        ),
    ]
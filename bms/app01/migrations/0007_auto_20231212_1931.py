# Generated by Django 3.2.13 on 2023-12-12 11:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0006_auto_20231212_1501'),
    ]

    operations = [
        migrations.AddField(
            model_name='borrow',
            name='fine',
            field=models.DecimalField(decimal_places=2, default=0.0, max_digits=6, verbose_name='罚款金额'),
        ),
        migrations.AddField(
            model_name='borrow',
            name='fine_processed',
            field=models.BooleanField(default=False, verbose_name='罚款处理'),
        ),
    ]

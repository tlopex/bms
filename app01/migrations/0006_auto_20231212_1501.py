# Generated by Django 3.2.13 on 2023-12-12 07:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app01', '0005_auto_20231212_0052'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='book',
            name='date',
        ),
        migrations.RemoveField(
            model_name='book',
            name='translator',
        ),
        migrations.AddField(
            model_name='book',
            name='author',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='books', to='app01.author', verbose_name='作者'),
        ),
        migrations.AddField(
            model_name='book',
            name='price',
            field=models.DecimalField(decimal_places=2, default=0, max_digits=10, verbose_name='价格'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='author',
            name='book',
            field=models.ManyToManyField(related_name='authors', to='app01.Book'),
        ),
        migrations.AlterField(
            model_name='book',
            name='ISBN',
            field=models.CharField(max_length=64, verbose_name='书号'),
        ),
        migrations.AlterField(
            model_name='book',
            name='name',
            field=models.CharField(max_length=64, null=True, verbose_name='书名'),
        ),
        migrations.AlterField(
            model_name='book',
            name='publisher',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app01.publisher', verbose_name='出版社'),
        ),
        migrations.AlterField(
            model_name='borrow',
            name='book',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app01.book', verbose_name='图书'),
        ),
        migrations.AlterField(
            model_name='borrow',
            name='reader',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app01.reader', verbose_name='读者'),
        ),
    ]

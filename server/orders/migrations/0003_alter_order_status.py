# Generated by Django 3.2.7 on 2022-02-04 17:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0002_order_phone'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[('created', 'Created'), ('received', 'Received'), ('shipped', 'Shipped'), ('paid', 'Paid'), ('refunded', 'Refunded'), ('canceled', 'Canceled')], default='created', max_length=120),
        ),
    ]

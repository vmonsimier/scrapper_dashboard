# Generated by Django 4.0.5 on 2022-10-29 15:31

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0018_rename_last_excution_tests_last_execution'),
    ]

    operations = [
        migrations.AddField(
            model_name='tests',
            name='file',
            field=models.CharField(default='', max_length=100),
        ),
    ]

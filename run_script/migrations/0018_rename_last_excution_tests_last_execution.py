# Generated by Django 4.0.5 on 2022-10-29 15:11

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0017_tests'),
    ]

    operations = [
        migrations.RenameField(
            model_name='tests',
            old_name='last_excution',
            new_name='last_execution',
        ),
    ]

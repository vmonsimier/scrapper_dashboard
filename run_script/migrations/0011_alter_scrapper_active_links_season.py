# Generated by Django 4.0 on 2022-01-05 18:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0010_alter_scrapper_active_links_season'),
    ]

    operations = [
        migrations.AlterField(
            model_name='scrapper_active_links',
            name='season',
            field=models.PositiveIntegerField(default=0),
        ),
    ]

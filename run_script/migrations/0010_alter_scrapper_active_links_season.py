# Generated by Django 4.0 on 2022-01-05 18:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0009_scrapper_active_links_league_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='scrapper_active_links',
            name='season',
            field=models.CharField(default='', max_length=200),
        ),
    ]

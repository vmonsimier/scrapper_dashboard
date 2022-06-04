# Generated by Django 4.0 on 2022-01-05 18:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0008_exclude_player_links_exclude_team_links'),
    ]

    operations = [
        migrations.AddField(
            model_name='scrapper_active_links',
            name='league',
            field=models.CharField(default='', max_length=45),
        ),
        migrations.AddField(
            model_name='scrapper_active_links',
            name='season',
            field=models.PositiveIntegerField(default=2021),
        ),
    ]

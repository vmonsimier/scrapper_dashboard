# Generated by Django 4.0.5 on 2022-10-18 18:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0014_alter_scrappers_errors'),
    ]

    operations = [
        migrations.AddField(
            model_name='scrapper_active_links',
            name='node_id',
            field=models.PositiveIntegerField(null=True),
        ),
    ]

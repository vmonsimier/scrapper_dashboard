# Generated by Django 4.0.5 on 2022-10-29 14:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('run_script', '0015_scrapper_active_links_node_id'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Files',
        ),
        migrations.DeleteModel(
            name='ScrapperLogs',
        ),
    ]

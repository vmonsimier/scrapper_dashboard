from django.db import models

# Create your models here.
class Scrappers(models.Model):
    """Table schema to store scrappers information."""
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    site = models.CharField(max_length=40, default='')
    path = models.CharField(max_length=64)
    in_execution = models.BooleanField(default=False)
    enable = models.BooleanField(default=False)
    current_pid = models.PositiveIntegerField(default=None)
    errors = models.TextField(default=None)
    last_execution = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return '%s' % self.name

class Files(models.Model):
    """Table schema to store files."""
    id = models.AutoField(primary_key=True)
    path = models.CharField(max_length=120)
    player = models.CharField(max_length=100, default=None)
    team = models.CharField(max_length= 45)
    league = models.CharField(max_length=50)
    season = models.PositiveIntegerField()
    dateIns = models.DateTimeField(null=True, blank=True)

class FbrefLinks(models.Model):
    """Table schema to store fbref links."""
    id = models.AutoField(primary_key=True)
    link = models.CharField(max_length=120)
    league = models.CharField(max_length=50)
    season = models.PositiveIntegerField()

class Scrapper_Active_Links(models.Model):
    """Table schema to store scrapper active links."""
    id = models.AutoField(primary_key=True)
    scrapper_id = models.PositiveIntegerField()
    link = models.CharField(max_length=120)
    league = models.CharField(max_length=45, default="")
    season = models.PositiveIntegerField(default=0)
    node_id = models.PositiveIntegerField(null=True)

class Exclude_Team_Links(models.Model):
    """Table schema to store scrapper exclude team links."""
    id = models.AutoField(primary_key=True)
    scrapper_id = models.PositiveIntegerField()
    link = models.CharField(max_length=120)

class Exclude_Player_Links(models.Model):
    """Table schema to store scrapper exclude team links."""
    id = models.AutoField(primary_key=True)
    scrapper_id = models.PositiveIntegerField()
    link = models.CharField(max_length=120)

class ScrapperLogs(models.Model):
    """Table schema to store scrapper logs."""
    id = models.AutoField(primary_key=True)
    scrapper_id = models.PositiveIntegerField()
    type = models.CharField(max_length=5)
    text = models.CharField(max_length=200)
    date = models.DateTimeField(null=True, blank=True)

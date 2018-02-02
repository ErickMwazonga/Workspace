## __Django Applications with Apache and mod_wsgi__

### Resources
1. [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-apache-and-mod_wsgi-on-ubuntu-16-04)

### 1. Install Packages from the Ubuntu Repositories
    _Python2_
    sudo apt-get update
    sudo apt-get install python-pip apache2 libapache2-mod-wsgi

    _Python3_
    sudo apt-get update
    sudo apt-get install python3-pip apache2 libapache2-mod-wsgi-py3


### 2. Configure a Python Virtual Environment
    _Python2_
    sudo pip install virtualenv

    _Python 3_
    sudo pip3 install virtualenv


NB: Use VirtalEnvWrapper

> ~/myproject/myproject/settings.py
> ##### `ALLOWED_HOSTS = ["server_domain_or_IP"]`
> ##### `STATIC_URL = '/static/'`
> ##### `STATIC_ROOT = os.path.join(BASE_DIR, 'static/')`

### 3. Complete Initial Project Setup
    ./manage.py makemigrations
    ./manage.py migrate
    ./manage.py createsuperuser
    ./manage.py collectstatic


### 4. Configure Apache
    create file in project - deploy/project_apache

> Create Symbolic Links to point to /etc/apache2/sites-available and sites-enabled
- `sudo ln -s ~/apps/project/deploy/project_apache.conf  /etc/apache2/sites-available/`
- `sudo ln -s ~/apps/project/deploy/project_apache.conf  /etc/apache2/sites-enabled/`

> refer to services/apache_mod_wsgi/project_apache.conf


### 5. Wrapping Up Some Permissions Issues
    __SQLITE DB__
    chmod 775 ~/myproject/
    chmod 664 ~/myproject/db.sqlite3
    sudo chown :www-data ~/myproject/db.sqlite3
    sudo chown :www-data ~/myproject

### 6. RESTARTING AND DEBUGGING
    1. RESTARTING
        sudo service apache2 restart
        /etc/init.d/apache2 restart
    2. STATUS
        sudo service apache2 status
    3. ERRORLOG
        sudo tail -F /var/log/apache2/error.log

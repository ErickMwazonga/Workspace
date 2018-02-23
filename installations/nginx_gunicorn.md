## How To Set Up Django with Postgres, Nginx, and Gunicorn

### Resources
1. [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04)


### Install the Packages from the Ubuntu Repositories
If you are using Python 2, type:

    sudo apt-get update
    sudo apt-get install python-pip python-dev libpq-dev postgresql postgresql-contrib nginx

If you are using Django with Python 3, type:

    sudo apt-get update
    sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx


### Create the PostgreSQL Database and User

### Create a Python Virtual Environment for your Project

### Configure a New Django Project
` ~/myproject/myproject/settings.py`

    # The simplest case: just add the domain name(s) and IP addresses of your Django server
    # ALLOWED_HOSTS = ['.example.com', '203.0.113.5']
    ALLOWED_HOSTS = ['your_server_domain_or_IP', 'second_domain_or_IP', . . .]


    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': 'myproject',
            'USER': 'myprojectuser',
            'PASSWORD': 'password',
            'HOST': 'localhost',
            'PORT': '',
        }
    }


    STATIC_URL = '/static/'
    STATIC_ROOT = os.path.join(BASE_DIR, 'static/')

### Complete Initial Project Setup
    python manage.py collectstatic

    # Create an exception for port 8000 by typing:
    sudo ufw allow 8000


### Testing Gunicorn's Ability to Serve the Project
    cd ~/myproject
    gunicorn --bind 0.0.0.0:8000 myproject.wsgi


### Create a Gunicorn systemd Service File
    sudo nano /etc/systemd/system/gunicorn.service

> refer to services/nginx_gunicorn/gunicorn.service

    sudo systemctl start gunicorn
    sudo systemctl enable gunicorn


### Check for the Gunicorn Socket File
    # Check the status of the process to find out whether it was able to start:
    sudo systemctl status gunicorn


    # Check the Gunicorn process logs by typing:
    sudo journalctl -u gunicorn

    # reload the daemon to reread the service definition and restart the Gunicorn process by typing:
    sudo systemctl daemon-reload
    sudo systemctl restart gunicorn


### Configure Nginx to Proxy Pass to Gunicorn
> refer to services/nginx_gunicorn/project_nginx.conf

`sudo ln -s  /project/deploy/project_nginx /etc/nginx/sites-available/`

`sudo ln -s  /project/deploy/project_nginx /etc/nginx/sites-enabled/`


#### Test your Nginx configuration for syntax errors by typing:

    sudo nginx -t

#### If no errors are reported, go ahead and restart Nginx by typing:

    sudo systemctl restart nginx



### Troubleshooting Nginx and Gunicorn
#### Nginx Is Displaying a 502 Bad Gateway Error Instead of the Django Application
    sudo tail -F /var/log/nginx/error.log


The following logs may be helpful:

1. Check the Nginx process logs by typing: `sudo journalctl -u nginx`
2. Check the Nginx access logs by typing: `sudo less /var/log/nginx/access.log`
3. Check the Nginx error logs by typing: `sudo less /var/log/nginx/error.log`
4. Check the Gunicorn application logs by typing: `sudo journalctl -u gunicorn`

## Django deployment instructions. Nginx + Gunicorn + Supervisor on Linux (Ubuntu)

### Resources
1. [Code Day](https://www.codeday.top/2017/09/21/42809.html)
2. [A good resource](https://samoylov.eu/2016/08/31/deploying-django-with-gunicorn-and-supervisor/)

### NGINX
> refer to services/nginx_gunicorn_suervisor/project_nginx.conf

`sudo ln -s  /project/deploy/project_nginx /etc/nginx/sites-available/`

`sudo ln -s  /project/deploy/project_nginx /etc/nginx/sites-enabled/`


### GUNICORN
> refer to services/nginx_gunicorn_suervisor/gunicorn_start

> save in project/deploy

#### in order to be able to run gunicorn start script it has to have execution mode enabled so

`sudo chmod u+x /home/root/app/src/gunicorn_start`

now you will be able to start your gunicorn server with just using `deploy/gunicorn_start`


### SUPERVISOR
    sudo apt-get install supervisor

Then create a `.conf` file in your main directory


*configuration file content:*
> refer to services/nginx_gunicorn_suervisor/phonebook.conf

`/etc/supervisor/conf.d/phonebook.conf`


### RUN :man:
#### Ubuntu version 14.04 or lesser

`sudo supervisorctl reread` -> rereads all config files inside supervisor catalog
this should print out: yourappname: available

`sudo supervisorctl update` -> updates supervisor to newly added config files; should print out yourappname: added process group


#### Ubuntu 16.04
`sudo service supervisor restart`


### Sanity Check
check if your app is running correctly just run

`sudo supervisorctl status phonebook`

This should display :

    phonebook RUNNING pid 18020, uptime 0:00:50

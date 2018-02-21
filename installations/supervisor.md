## __Installing and Configuring Supervisor on Ubuntu 16.04__

### Resources
1. [Vultr Tutorial](hthttps://www.vultr.com/docs/installing-and-configuring-supervisor-on-ubuntu-16-04)

### Definition
Supervisor is a client/server system used to control a number of UNIX processes, more specifically processes related to a project or a customer. For example, you could use supervisor to spawn and monitor an arbitrary number of worker queues of your web application.

#### The components of this system are:
    1. supervisord: The server piece of the system.
    2. supervisorctl: The command-line interface used to interact with the server.
    3. Web server: A simple web server and a web user interface with basic functionality compared to supervisorctl.
    4. XML-RPC Interface: The same HTTP server used by the web client, serves an XML-RPC Interface that can be used to control supervisor programs.


### Installation and basic configuration
First, update your local packages list and then install python `setuptools`.

    sudo apt-get update && sudo apt-get install python-setuptools

Now we can install supervisor.

    sudo easy_install supervisor

Once the installation is complete, we have to generate our configuration file. Create a folder named supervisor inside /etc.

    sudo mkdir /etc/supervisor

And then execute the following.

    echo_supervisord_conf >  /etc/supervisor/supervisord.conf

If you aren't logged in with the root user, you may get a `Permission denied` error (even with `sudo`). This is due to the redirection. To overcome this, login as `root`.

    sudo su

Then you can run the command again.

    echo_supervisord_conf > /etc/supervisor/supervisord.conf


### Basic configuration

Open the `/etc/supervisor/supervisord.conf` file and check its contents. You will note that this configuration file follows the INI syntax, and it is divided by sections (representend by brackets as in [section-name]).

To add programs to be managed by supervisor we just need to create the appropriate [program] sections. However, to avoid messing arround with the main configuration file every time we need to add (or change) a program, we will be using the [include] section. Find this section, uncomment it and then edit it to look like the following.

    [include]
    files=conf.d/*.conf

Now for each program we want to add, we will be creating a .ini file inside the /etc/supervisor/conf.d/ directory. Lets create this folder.

    sudo mkdir /etc/supervisor/conf.d


### Starting the supervisor server

As noted before, supervisor is composed of a server and clients that connect to it. To be able to manage and control programs, we need to start the server. To do so, we will be registering the supervisor server in `systemd`, so that the server may be started at system startup.

To do so, create a file called `supervisord.service` in the `/etc/systemd/system` directory.

    sudo touch /etc/systemd/system/supervisord.service

Add the following contents to the file.

    [Unit]
    Description=Supervisor daemon
    Documentation=http://supervisord.org
    After=network.target

    [Service]
    ExecStart=/usr/local/bin/supervisord -n -c /etc/supervisor/supervisord.conf
    ExecStop=/usr/local/bin/supervisorctl $OPTIONS shutdown
    ExecReload=/usr/local/bin/supervisorctl $OPTIONS reload
    KillMode=process
    Restart=on-failure
    RestartSec=42s

    [Install]
    WantedBy=multi-user.target
    Alias=supervisord.service

Activate the supervisord service.

    sudo systemctl start supervisord.service

As long as the service file is located in the `/etc/systemd/system` directory, it will be automatically started at system startup.

You can check the status of the service.

    systemctl status supervisord.service

Also, you can check out the logs.

    sudo journalctl -u supervisord.service



### Adding programs

The programs controlled by supervisor are given by different `[program]` sections in the configuration. For each program we want to manage, we will create a standalone configuration file informing the command executable path, any environmental variables, how to perform in case of a shutdown.

First, let's create a simple script that logs a timestamp. Create a file called `hello_supervisor.sh` (anywhere you wish, we will be referencing the full path of this script).

    touch hello_supervisor.sh

Now, put the following contents into it

    #!/bin/bash
    while true
    do
        # Echo current timestamp to stdout
        echo Hello Supervisor: `date`
        # Echo 'error!' to stderr
        echo An error ocurred at `date`! >&2
        sleep 1
    done

Now make it executable

    chmod +x hello_supervisor.sh

In practical terms this script is pretty much useless. However, we can use it to demonstrate the power of supervisor. Create the corresponding configuration file by running the following.

    sudo touch /etc/supervisor/conf.d/hello_supervisor.conf

Now put the following contents into this file.

    [program:hello_supervisor]
    command=/home/edno/hello_supervisor.sh
    autostart=true
    autorestart=true
    stderr_logfile=/var/log/hello_supervisor.err.log
    stdout_logfile=/var/log/hello_supervisor.out.log

We will review this configuration step by step.

    [program:hello_supervisor]
    command=/home/erick/hello_supervisor.sh

First, the configuration begins by defining a program of name hello_supervisor. It also informs the full path of the executable to be run.

    autostart=true

This line states that this program should be automaticaly started when supervisor is started.

    autorestart=true

If the program quits, for any reason, this line informs supervisor to automatically `restart` the process.

    stderr_logfile=/var/log/hello_supervisor.err.log
    stdout_logfile=/var/log/hello_supervisor.out.log

These lines define the logfile location for `stderr` and `stdout`, respectively.



### Managing programs

Now that we have installed and configured supervisor, we are able to manage our processes.

After adding a new program, we should run the following two commands, to inform the server to `reread` the configuration files and to apply any changes.

    sudo supervisorctl reread
    sudo supervisroctl update

Now `execute` the supervisorctl client.

    sudo supervisorctl

You will be greeted with a `list` of the registered proccesses. You will see a proccess called hello_supervisor with a RUNNING status.

    hello_supervisor                 RUNNING   pid 6853, uptime 0:22:30
    supervisor>

Type `help` for a list of avaialable commands.

`supervisor> help`

    default commands (type help <topic>):
    =====================================
    add    exit      open  reload  restart   start   tail   
    avail  fg        pid   remove  shutdown  status  update
    clear  maintail  quit  reread  signal    stop    version

In a nutshell, we can `start`, `stop` and `restart` programs by passing the program name as an argument to the respective command.

    supervisor> stop hello_supervisor
    hello_supervisor: stopped
    supervisor> start hello_supervisor
    hello_supervisor: started
    supervisor> restart hello_supervisor
    hello_supervisor: stopped
    hello_supervisor: started
    supervisor>

We can also take a look at the program output with the `tail` command.

    supervisor> tail hello_supervisor
    Hello Supervisor: Mon Sep 25 19:27:29 UTC 2017
    Hello Supervisor: Mon Sep 25 19:27:30 UTC 2017
    Hello Supervisor: Mon Sep 25 19:27:31 UTC 2017

For the stderr output, you can use `tail` as well.

    supervisor> tail hello_supervisor stderr
    An error ocurred at Mon Sep 25 19:31:12 UTC 2017!
    An error ocurred at Mon Sep 25 19:31:13 UTC 2017!
    An error ocurred at Mon Sep 25 19:31:14 UTC 2017!

By invoking the `status` command, you can view the status of all registered programs.

Once you are finished, you can quit.

`supervisor> quit`


### The webserver client

To allow access to the supervisord webserver, open the supervisord configuration file and locate the `[inet_http_server]` section.

`nano /etc/supervisor/supervisord.conf`

Now update this section's configuration with the following.

    [inet_http_server]
    port=*:9001
    username=your_username
    password=your_password

Replace `your_username` and `your_password` with your desired credentials, save your modifications and the restart `supervisord service`.

    sudo systemctl restart supervisord.service

Remember to allow `TCP` access to the port `9001` on your firewall and then access `http://{server-ip}:9001` from your browser. When asked, provide your `username` and `password`. You can now control your proccesses from web.

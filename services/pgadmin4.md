## Install pgAdmin4 v2.0 with python3 on Ubuntu 16.04 DESKTOP mode

1. Get Python Wheel pgAdmin4

        wget https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v2.0/pip/pgadmin4-2.0-py2.py3-none-any.whl

2. Install pip3
    
        sudo apt install python3-pip

3. Install virtualenv
       
        sudo pip3 install virtualenv

4. Create virtualenv in dir ~/py3-venv-pgadmin
       
        virtualenv --system-site-packages --no-setuptools --python=python3.5 ~/py3-venv-pgadmin

5. Activate virtualenv
       
        cd ~/py3-venv-pgadmin/bin
        source activate

6. Check pip3
       
        which pip3
        ~/py3-venv-pgadmin/bin/pip3

4. Install pgAdmin4
       
        pip3 install pgadmin4-2.0-py2.py3-none-any.whl

5. [For desktop deployment](https://www.pgadmin.org/docs4/dev/desktop_deployment.html)
        
        cd ~/py3-venv-pgadmin/lib/python3.5/site-packages/pgadmin4
        touch config_local.py
        nano config_local.py
   write:
        
        import os
        SERVER_MODE = False
        DATA_DIR = os.path.realpath(os.path.expanduser(u'~/.pgadmin/'))
        LOG_FILE = os.path.join(DATA_DIR, 'pgadmin4.log')
        SQLITE_PATH = os.path.join(DATA_DIR, 'pgadmin4.db')
        SESSION_DB_PATH = os.path.join(DATA_DIR, 'sessions')
        STORAGE_DIR = os.path.join(DATA_DIR, 'storage')

   run:
        
        python3 ~/py3-venv-pgadmin/lib/python3.5/site-packages/pgadmin4/setup.py

6. Run pgAdmin4
        
        python3 ~/py3-venv-pgadmin/lib/python3.5/site-packages/pgadmin4/pgAdmin4.py

7. Exit virtualenv
        
        deactivate

8. For run pgadmin4 create script ~/py3-venv-pgadmin/pgadmin4.sh
             
        #!/usr/bin/env bash
        cd ~/py3-venv-pgadmin/bin
        source activate
        python3 ~/py3-venv-pgadmin/lib/python3.5/site-packages/pgadmin4/pgAdmin4.py

9. Create alias for bash
        
        nano ~/.bashrc
   
   write at the end of file: 
        
        alias pgadmin4='~/py3-venv-pgadmin/pgadmin4.sh'
   
   reload bashrc
        
        source ~/.bashrc
   
   now you can run pgadmin
        
        pgadmin4

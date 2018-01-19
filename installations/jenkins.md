# __Jenkins Configuration__

## Resources
1. [Digital Ocean on Jenkins](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)
2. [Medium](https://medium.com/@evasilchenko/continuous-deployment-of-django-applications-part-1-e3bc332bcbaf)
3. [rahmonov.me](http://rahmonov.me/posts/continuous-integration-and-continous-deployment-for-django-app-with-jenkins/)
4. [Django + Jenkins setup](http://michal.karzynski.pl/blog/2014/04/19/continuous-integration-server-for-django-using-jenkins/)

## Require Java
:+1: `sudo apt-get install openjdk-6-jdk`

## Add Jenkins key
* :+1: `wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -`
* :+1: `sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'`

# Instal Jenkins
* :metal: `sudo apt-get update`
* :metal: `sudo apt-get install jenkins`

## Start Jenkins
:rocket: `sudo service jenkins start`

## Note
If there is any program using port 8080 e.g Jira, disable it `sudo /etc/init.d/jira stop`

#### Or
:rocket: `sudo /etc/init.d/jenkins start`

## Check Jenkins status
:rocket: `sudo service jenkins status`

## Opening Firewall
:rocket: `sudo ufw allow 8080`

## Copy password
:rocket: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

## Install Suggested plugin
1. Git plugin
2. Green Balls
3. Build Pipeline Plugin

## Create User
- <del>Create the admin user</del>

## Configuration
1. click on “New Item”
2. Write the job name
3. select the “Freestyle project” option
4. select the “Discard Old Builds”
5. select the type of the repository (Git, Subversion, CVS)
6. Repositories
    - Add git repo url

        ##### Warning
            If the URL from this repository is public.
            In a private repository, you will probably need to
            configure a ssh key on the server so Jenkins can have access to the repository.

7. Build Trigger
    - Poll SCM
        - Every 15 minutes
        `H/15 * * * *`
8. Build
    * Execute Shell _Refer to sevices .jenkins_

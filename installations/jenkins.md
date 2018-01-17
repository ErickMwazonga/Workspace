# __Jenkins Configuration__

## Require Java
`sudo apt-get install openjdk-6-jdk`

## Add Jenkins key
`wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -`
`sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'`

# Instal Jenkins
1. `sudo apt-get update`
2. `sudo apt-get install jenkins`

## Start Jenkins
`sudo service jenkins start`

## Note
If there is any program using port 8080 e.g Jira, disable it `sudo /etc/init.d/jira stop`

#### Or
`sudo /etc/init.d/jenkins start`

## Check Jenkins status
`sudo service jenkins status`

## Opening Firewall
`sudo ufw allow 8080`

## Copy password
`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

## Install Suggested plugin
1. Git plugin
2. Green Balls

### Create User

## Configuration
1. click on “New Item”
2. Write the job name
3. select the “Freestyle project” option
4. select the “Discard Old Builds”
5. select the type of the repository (Git, Subversion, CVS)
6. Repositories
    * Add git repo url
##### Warning:
_the URL from this repository is public.
In a private repository, you will probably need to
configure a ssh key on the server so Jenkins can have access to the repository._

6. Build Trigger
    * Poll SCM
        * Every 15 minutes
        `H/15 * * * *`
7. Build
    * Execute Shell _Refer to sevices .jenkins_

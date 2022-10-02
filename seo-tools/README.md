[![Build Status](https://travis-ci.org/kodify/seo-tool.png?branch=master)](https://travis-ci.org/kodify/seo-tool)
[![Code Climate](https://codeclimate.com/github/kodify/seo-tool.png)](https://codeclimate.com/github/kodify/seo-tool)

## Seo-tool

### Set up the environment
Seo tool is packaged with a development environment on it, you can get this tool runing as is or use the default environment.

* To setup using provided VM you'll need to install the latest versions of the following software for your OS
    * Vagrant: http://downloads.vagrantup.com/ (>= 1.1)
    * Virtual Box: https://www.virtualbox.org/wiki/Downloads

* Once you have vagrant installed, fork the project to your GitHub account and clone from there to your machine.

    git clone git@github.com:kodify/seo-tool.git

Using the terminal navigate to the directory where you cloned the project and type:

    vagrant up
    vagrant ssh


### Get seo tool working
As any other rails application you can get it working easily with:

```
cd /var/www/seo-tool/current
bundle install
rake db:create
rake db:migrate
rails s
```

you also will need the next environment vars on your machine:

```
OAUTH_ID='google oauth id (the one related with mail)'
OAUTH_SECRET='google oauth secret'
OAUTH_VALID_DOMAIN='kodify.io'
SEOMOZ_ACCESS_ID='Seomoz access id'
SEOMOZ_SECRET_KEY='Seomozz secret key'
```

now you can access your application on http://localhost:3000


## Thats it! enjoy it
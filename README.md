# A simple Sinatra file upload application

* Only for image file upload!!!

## install rvm
    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    $ \curl -sSL https://get.rvm.io | bash -s stable
    
## install ruby
    $ rvm install 2.3.1
    $ sudo gem install bundle

## Setup using [Bundler](http://gembundler.com/ "Bundler")
    $ bundle install

## Starting
    $ sh start.sh
    
## App Server : puma  

## Deploy  

* in /path/to/app
  
  * make a temp dir
    $ mkdir -p tmp/puma

  * modify config/upload to fit your server and domain
    $ cp config/upload /etc/nginx/sites-available/
    $ ln -s /etc/nginx/sites-available/upload /etc/nginx/sites-enabled/upload

  * reload nginx
    $ service nginx configtest
    $ service nginx reload

  * run start.sh   
    $ sh start.sh

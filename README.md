# A simple Sinatra file upload application

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

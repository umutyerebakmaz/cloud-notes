# Nginx Virtual Hosting

## sites-available

```console
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
```

## sites-enabled

```console
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
```

restart http server

```console
service nginx restart
```

## Clone project from github repo

For this process, you must have previously defined the ssh key for the droplet in your github profile.

```console
git clone git@github.com:umutyerebakmaz/cloud-notes.git
```

```console
chmod -R 775 storage
chmod -R 775 bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
yarn install
composer install
php artisan key:generate
php artisan migrate
php artisan db:seed
sudo systemctl restart nginx
```

cd /var/www/umutyerebakmaz.com/umutyerebakmaz

## Add SSL Certificate with Certbot

```console
sudo certbot --nginx -d example.com -d www.example.com
sudo certbot --nginx -d <domain> --force-renewal

sudo certbot --authenticator standalone --installer nginx -d <domain> -d <domain> —pre-hook "service nginx stop" --post-hook "service nginx start"
```

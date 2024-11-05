map $sent_http_content_type $expires {
    default off;
    text/html epoch;
    text/css max;
    application/javascript max;
    ~image/ max;
}

server {

    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    gzip_min_length 256;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/x-font-ttf font/opentype font/x-woff image/svg+xml image/x-icon;

    root /var/www/yourdomain.com/yourdomain/public;
    index index.php index.html index.htm index.nginx-debian.html;

    charset utf-8;

    server_name yourdomain.com www.yourdomain.com;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_hide_header X-Powered-By;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }


    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    expires $expires;


    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}


server {
    if ($host = www.yourdomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = yourdomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    server_name yourdomain.com www.yourdomain.com;
    listen 80;
    return 404; # managed by Certbot
}

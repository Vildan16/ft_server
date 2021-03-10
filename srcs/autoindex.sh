#!/bin/bash

nginxCONFIGfile='/etc/nginx/sites-available/nginx.conf'

grep "autoindex on;" "$nginxCONFIGfile" > /dev/null
if [ $? -eq 0 ]; then
    echo "Changing the status and reloading the server......"
    sed -i "s/autoindex on/autoindex off/" "$nginxCONFIGfile"
    service nginx restart;
    echo "autoindex is OFF"
else
    
        echo "Changing the status and reloading the server......"
        sed -i "s/autoindex off/autoindex on/" "$nginxCONFIGfile"
        service nginx restart;
        echo "autoindex is ON"
fi

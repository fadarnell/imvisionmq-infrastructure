#!/bin/bash
rm -rf /var/efs/www/$1
rm -rf /var/efs/conf/$1.conf
/etc/init.d/nginx reload
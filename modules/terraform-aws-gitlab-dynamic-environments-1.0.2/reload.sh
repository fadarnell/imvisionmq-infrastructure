#!/bin/bash
aws s3 sync s3://"$BUCKET" /var/efs
/etc/init.d/nginx reload
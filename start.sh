#!/bin/sh
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
/etc/init.d/postgresql start &

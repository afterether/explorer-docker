#!/bin/sh
/etc/init.d/postgresql start
#/bin/sleep 60
/usr/bin/passwd -d postgres
/bin/su - postgres -c "psql < /setup.sql"
/usr/sbin/useradd -m aedev
/usr/bin/passwd -d aedev
#/bin/echo "aedev:123" | /usr/sbin/chpasswd

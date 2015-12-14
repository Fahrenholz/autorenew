# autorenew
Auto-Renew script for Letsencrypt. Uses letsencrypt-auto certonly. Easy-to-use as CRON-Job

## Installation

### Get files
Clone directory into your letsencrypt-users homedir

### Create a symlink
Inside the autorenew-dir, create a symlink to your letsencrypt-auto script. The link has to be called `letsencrypt-auto`
```
ln -s ../letsencrypt/letsencrypt-auto ./letsencrypt-auto
```

### Edit domain.conf
** Attention: for now, there is no possibility to add a comment. I'm working on it **

One certificate per line, one or more domains per certificate. To create multidomain certificates, write the domains on one line separated by a whitespace
```
numoon.net www.numoon.net
shop.numoon.net
update.numoon.net
```
creates 3 certificates: one for numoon.net and www.numoon.net, one for shop.numoon.net and one for update.numoon.net

### Create CRON-Job

execute `crontab -e` logged in as your letsencrypt-user and create your CRON-Job

##Licence
The tool is under GNU GPL v.3 Licence. Feel free to use, share, edit, contribute, whatsoever.


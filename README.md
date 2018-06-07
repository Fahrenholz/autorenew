# autorenew
* This repository is from the beginning of letsencrypt, when there was no good renewal built-in in it. I keep it merely for nostalgia. Please don't use it *

Auto-Renew script for Letsencrypt. Uses letsencrypt-auto certonly with standalone-plugin. Easy-to-use as CRON-Job

## Installation

### Get files
Clone directory into your letsencrypt-users homedir

### Create a symlink
Inside the autorenew-dir, create a symlink to your letsencrypt-auto script. The link has to be called `letsencrypt-auto`
```
ln -s ../letsencrypt/letsencrypt-auto ./letsencrypt-auto
```

### Edit domain.conf

One certificate per line, one or more domains per certificate. To create multidomain certificates, write the domains on one line separated by a whitespace
```
# This is a comment line
numoon.net www.numoon.net
# This too
shop.numoon.net
update.numoon.net
```
creates 3 certificates: one for numoon.net and www.numoon.net, one for shop.numoon.net and one for update.numoon.net

### Create CRON-Job

execute `crontab -e` logged in as your letsencrypt-user and create your CRON-Job

## Log File
All Input is redirected to a log file on execution. You'll find it in your autorenew-Directory, and it is called "cert_renew.log"

## Licence
The tool is under GNU GPL v.3 Licence. Feel free to use, share, edit, contribute, whatsoever.


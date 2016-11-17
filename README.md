# dynhost
Homemade script similar to update periodically your OVH DNS via DynHost. Mainly inspired by DynHost script given by OVH but (now offline).
New version by zwindler (zwindler.fr/wordpress)

## Cron
Use with cron to launch periodicaly

```
crontab -e
  00 * * * * /usr/local/dynhost
```

##History

Initial version was doing  nasty grep/cut on local ppp0 interface

This coulnd't work of course in a NATed environnement like on ISP boxes on private networks.

I also got rid of ipcheck.py dependancy thanks to mafiaman42

I did a code cleanup and switching from /bin/sh to /bin/bash to work around a bug in Debian Jessie ("if" clause not working as expected)

Lastly, this script uses curl to get the public IP, and then uses wget to update DynHost entry in OVH DNS

## More information

See [website](http://zwindler.fr/wordpress/2014/09/22/mise-a-jour-de-votre-dns-chez-ovh-avec-dynhost/) for more informations

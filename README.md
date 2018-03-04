# dynhost
Homemade script similar to update periodically your OVH DNS via DynHost. Mainly inspired by DynHost script given by OVH (but now offline).
New version by zwindler (https://blog.zwindler.fr)

## Cron
Use with cron to launch periodicaly

```
crontab -e
  00 * * * * /usr/local/dynhost/dynhost
```

## Config file

You can use the sample config file given (dynhost.sample.cfg). Rename it to dynhost.cfg and change the variables to meet your own parameters. Use cron this way.

```
crontab -e
  00 * * * * /usr/local/dynhost/dynhost /usr/local/dynhost/dynhost.cfg
```

## Docker image

I'm also building an Alpine docker image that can be used to update your DynHost records. You can use the Docker image both with configuration or environment variables. I'll give you 2 examples :

### Docker with variables

Don't forget to change HOST, LOGIN and PASSWORD in command line

```
docker run --rm -e HOST=YOURDYNHOST -e LOGIN=YOURLOGIN -e PASSWORD=YOURPASSWORD zwindler/dynhost
```

### Kubernetes as a CronJob and with configuration file 

Don't forget to change HOST, LOGIN and PASSWORD in the configMap section

```
---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: dynhost-cronjob
spec:
  schedule: "00,30 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: dynhost-cronjob
            image: zwindler/dynhost
            imagePullPolicy: Always
            volumeMounts:
            - name: config
              mountPath: /usr/local/dynhost/conf.d
          restartPolicy: OnFailure
          volumes:
          - name: config
            configMap:
              name: dynhost-configmap
              cat dynhost-cm.yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: dynhost-configmap
  namespace: default
data:
  dynhost.cfg: |-
    HOST=YOURDYNHOST
    LOGIN=YOURLOGIN
    PASSWORD=YOURPASSWORD
    LOG_FILE=/usr/local/dynhost/dynhost.log
```

## History

* Initial version was doing  nasty grep/cut on local ppp0 interface. This coulnd't work of course in a NATed environnement like on ISP boxes on private networks.
* I also got rid of ipcheck.py dependancy thanks to mafiaman42
* I did a code cleanup and switching from /bin/sh to /bin/bash to work around a bug in Debian Jessie ("if" clause not working as expected)
* Lastly, this script uses curl to get the public IP, and then uses wget to update DynHost entry in OVH DNS

## More information

See [website](https://blog.zwindler.fr/2014/09/22/mise-a-jour-de-votre-dns-chez-ovh-avec-dynhost/) for more informations

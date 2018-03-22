# abogushov_infra
abogushov Infra repository


## Connect to someinternalhost

```bash
ssh -i ~/.ssh/otus -J otus@35.204.71.134 otus@10.164.0.3
```

## SSH config

Append to ~/.ssh/config to simplify access:

```
Host bastion
  IdentityFile ~/.ssh/otus
  HostName 35.204.71.134
  User otus

Host someinternalhost
  IdentityFile ~/.ssh/otus
  HostName 10.164.0.3
  User otus
  ProxyJump bastion
```


## IP Addresses

bastion_IP = 35.204.71.134  
someinternalhost_IP = 10.164.0.3

## Homework 5

testapp_IP = 35.204.47.235
testapp_port = 9292

### Create a VM with the app

Run this from the root

```bash
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=config-scripts/startup.sh
```


Logs for startup scripts on remote machine lay here: `/var/log/syslog`.

You can force to rerun startup script:

```bash
sudo google_metadata_script_runner --script-type startup
```

### Add firewall rule

```bash
gcloud compute firewall-rules create default-puma-server\
  --allow=tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
```


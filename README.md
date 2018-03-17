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

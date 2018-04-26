# Инфраструктурный репозиторий

## Содержание

- [Домашняя работа 8](#домашняя-работа-8)
- [Домашняя работа 9](#домашняя-работа-9)


## Домашняя работа 9

Выполнено:

- Создан inventory файл для `ansible`.
- Создан `ansible.cfg` для упрощения конфигурации `ansible`.
- С помощью различных модулей были выполнены запросы к серверу приложения и серверу БД для получених статуса окружения и запущенных там служб.
- Был добавлен плейбук для копирования кода приложения на сервер.
- Создан инветори файл `inventory.json` и скрипт `inventory.py` для получения динамического инвентори в `ansible`.


Пинг сервера:

```bash
ansible appserver  -m ping
```

Время работы сервера:

```bash
ansible dbserver -m command -a uptime
```

Проверка версий окружения приложения:

```bash
ansible app -m shell -a 'ruby -v; bundler -v'
```

Использования модуля `systemd` для получения статуса `mongod`:

```bash
ansible db -m systemd -a name=mongod
```

Использования модуля `service` для получения статуса `mongod`:

```bash
ansible db -m service -a name=mongod
```

Загрузка кода приложения на сервер

```bash
ansible app -m git -a 'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit' 
```

Выполнения плейбука

```bash
ansible-playbook clone.yml
```

При выполнении плейбука на сервере где нет скопированно приложения будет выведен статус `changed=1`.

---

## Домашняя работа 8


Выполнено:

- Импорт правила файрволла.
- Создан ресурс для внешнего ip-адреса.
- Выполнено разбиение приложения на модули `app`, `db`, `vpc`.
- Создано два окружение `stage` и `prod`.
- С помощью модуля `storage-bucket` были созданы хранилища.
- Для всех окружений был создан удаленный бэкэнд.
- Была восставнолена конфигурация для автоматического деплоя приложения.
- Был пересобран образ с БД, так чтобы она была доступна для внешних клиентов.


Для иморта существующего правила файрволла:

```bash
terraform import google_compute_firewall.firewall_ssh default-allow-ssh
```

Сборка образа с приложением:

```bash
packer build -var-file=variables.json app.json
```

Сборка образа c БД для приложения:

```bash
packer build -var-file=variables.json db.json
```

Получил ошибку при попытке развернуть все окружения в одной зоне, поэтому нужно разворачивать окружения в разных зонах.

```bash
google_compute_address.app_ip: Error creating address: googleapi: Error 403: Quota 'STATIC_ADDRESSES' exceeded. Limit: 1.0 in region europe-west4., quotaExceeded
```


---


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

## Homework 7

- Terraform installed.
- Created config to deploy reddit-app to GCP.
- Created file with variables used to parameterize deploy.
- Specified ip's of instances created during deploy.
- Add resource to add few ssh-keys into project metadata.
- Created load balancer.
- App instance parametrized throw count variable.

### Problem with ssh keys

ssh keys added via web will be removed after `terraform apply`.

### Problem with deploying

Adding an instances manually via copying cannot be scaled.

To deploy app via terraform:

```bash
cd terraform
terraform apply
```

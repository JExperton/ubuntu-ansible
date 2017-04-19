
**Don't use with UFW and iptables if you want to test a playbook with a docker container unless you know what you're doing**

## Test a playbook with run-test

Make the test script executable
```
$ chmod +x run-test
```
Run the test script without argument to use the default lamp-test.yml playbook
```
$ ./run-test
```
You can specify a playbook as a first argument
```
$ ./run-test playbooks/lamp-prod.yml
```
Apache should be running [http://localhost:4080/](http://localhost:4080/)

## Customize existing playbooks

Edit playbooks/lamp-test.yml to change mysql user and password and to add or remove tasks.

## Select default php version

Since Apache is running with php-fpm you can install as many php versions as you want. 

Use the **default_php** variable to select the default php server that Apache should call. 

All php files called by Apache will be executed under this version unless you specify a custom php-fpm version in a virtualhost config file.

## Enable custom php version

Use the following instruction in a virtualhost config file to switch to a different php version

```
<FilesMatch ".+\.ph(p[3457]?|t|tml)$">
    SetHandler "proxy:unix:/run/php/php5.6-fpm.sock|fcgi://localhost"
</FilesMatch>
```
Replace the php version according to the custom php version to use.

When using the init-tz-(TZ).yaml file, make sure to go up a level and go to the templates folder and pull the timesyncd.conf file as well

When using the deploy-docker.yaml, you will need to login with root access and create a password after the playbook has run to be able to login with the newly created user. This is best used on a new install on bare metal/VM/LXC install.

The deploy Wazuh Agent playbook will use the DNS name of your servers/VMs/CTs/LXCs to deploy them and register them on the Wazuh server with easily readable names. This is done by using the ansible_hostname variables in the playbook.

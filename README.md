# Digitalocean

Let's create a new droplet by including the public keys.

## SSH Key Configuration

Access the server terminal with the digitalocean console.

follow this commands and edits

```terminal
sudo nano /etc/ssh/sshd_config
```

You should have a file like the one below, I ignored the comment lines

If you are having SFTP connection problems, make sure that this line is

`PubkeyAcceptedAlgorithms +ssh-rsa`

```document
Include /etc/ssh/sshd_config.d/*.conf
PermitRootLogin yes
PubkeyAcceptedAlgorithms +ssh-rsa
KbdInteractiveAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
```

## Add Authorized Key

```console
ssh-copy-id -f -i ~/.ssh/id_rsa.pub root@your_droplet_ip
```

## Check Authorized Key

```console
ssh root@your_droplet_ip
cat ~/.ssh/authorized_keys
```

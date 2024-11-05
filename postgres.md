# Installing PostgreSQL

Ubuntu’s default repositories contain Postgres packages, so you can install these using the apt packaging system.

If you’ve not done so recently, refresh your server’s local package index:

```console
sudo apt update
```

Then, install the Postgres package along with a `-contrib` package that adds some extra utilities and functionality:

```console
sudo apt install postgresql postgresql-contrib
```

Ensure that the server is running using the `systemctl start` command:

```console
sudo systemctl start postgresql.service
```

## Passsword Change

```console
sudo -u postgres psql
```

```sql
ALTER USER postgres WITH PASSWORD 'new_password';
```

## Remote Connection

open `pg_hba.conf` file and update this lanes

In the `pg_hba.conf` file, make sure that you set the authentication method used for connections to `md5`. `md5` is required for encrypted connections and provides password authentication. Make sure that the relevant lines in the file look like this:

```document
# IPv4 local connections:
host    all             all             0.0.0.0/0            md5
```

open `postgresql.conf` file and update this lanes

```document
listen_addresses = '*'
```

```terminal
sudo systemctl restart postgresql
```

## Add Firewall Rules

```terminal
sudo ufw allow 5432/tcp

```

## Remote Connection Test

```terminal
psql -h your_droplet_ip -U postgres -d your_database_name
```

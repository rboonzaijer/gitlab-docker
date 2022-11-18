# Gitlab in Docker (compose)

# 1. Clone this repo
```
git clone git@github.com:rboonzaijer/gitlab-docker.git

cd gitlab-docker
```


# 2. Setup
Create the .env file, and use your OWN data
```
cp .env.example .env
```

Make each 'do_{name}.sh' file executable
```
chmod +x do_*.sh
```


# 3. First run
```
docker compose up -d
```

Now wait until the container status is 'healty' (might take about 4 minutes on an i7)

You can keep checking the status with:
```
docker ps
```
When you see (healthy) in the status column, then Gitlab is running.

You can run the post_setup now (optional, you can also do this in the UI)
```
./do_post_setup.sh
```


# 4. Backup/Restore
We want to backup the data in the volumes. These files will be created:
- backup_gitlab_config.tar.bz2
- backup_gitlab_logs.tar.bz2
- backup_gitlab_data.tar.bz2

## Backup
This will shut down the container, create backups from the volumes, and then run the container again:
```
./do_backup.sh ./../my_backup_dir/
```

## Restore
This will shut down the container, restore (overwrite!) the backup files into the volumes, and start the container again.
```
./do_restore.sh ./../my_backup_dir/
```

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
docker ps --filter "name=gitlab"
```
When you see (healthy) in the status column, then Gitlab is running: http://localhost:30000 user=root, pass=(see .env file)

Notice the warning "Anyone can register for an account.", you can run the post_setup now to automatically disable this (optional, this can also be done in the UI).

You will get a test-mail when it's completed (or an error if you did not change the 'test_email_to', of misconfigured your smtp settings). Note: the default user gets an email to confirm its account!

Note: if you change your .env file, run `docker compose up -d` to recreate the container, then wait until the container is 'healthy' again ( `docker ps --filter "name=gitlab"` )
```
./do_post_setup.sh
```
After this command: refresh the UI and the warning is gone. Also, you've got a mail if SMTP was properly configured.

Hint (optional): You can also do any manual changes directly in the gitlab-rails console with: `docker exec -it gitlab gitlab-rails console`

# 4. Backup/Restore
We want to backup the data in the volumes. These files will be created:
- backup_gitlab_config.tar
- backup_gitlab_logs.tar
- backup_gitlab_data.tar
- backup_gitlab_lfs.tar

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

# 5. Update to latest gitlab
```
docker compose pull
docker compose up -d --remove-orphans
```

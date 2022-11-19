#!/bin/bash
start=$SECONDS

# get variables from .env file
export $(grep -v '^#' .env | xargs)

echo "Configuring (can take some time...)"

# Run docker command
docker exec -it gitlab gitlab-rails runner "

	# Disable user signups
	ApplicationSetting.last.update(signup_enabled: false)

	# Disable auto_devops
	ApplicationSetting.last.update(auto_devops_enabled: false)

	# Change root email
	if user = User.find_by_username('root')
		user.email = '${git_user_email}'
		user.skip_reconfirmation!
		user.save!
	end

	# Create a user
	User.create(
		:name => '${defaultuser_name}',
		:username => '${defaultuser_username}',
		:email => '${defaultuser_email}',
		:password => '${defaultuser_password}',
		:password_confirmation => '${defaultuser_password}',
		:admin => '${defaultuser_admin}'
	)

	# Send a test mail
	Notify.test_email('${test_email_to}', 'Gitlab server is configured!', 'This message means your gitlab server is configured!').deliver_now
"

# show how much time this took...
DURATION=$(( SECONDS - START ))
if (( $DURATION > 3600 )) ; then
	let "hours=DURATION/3600"
	let "minutes=(DURATION%3600)/60"
	let "seconds=(DURATION%3600)%60"
	echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $DURATION > 60 )) ; then
	let "minutes=(DURATION%3600)/60"
	let "seconds=(DURATION%3600)%60"
	echo "Completed in $minutes minute(s) and $seconds second(s)"
else
	echo "Completed in $DURATION seconds"
fi

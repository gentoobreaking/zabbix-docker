#!/bin/sh

apt -y install awscli

export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
printf "%s\n%s\nap-northeast-1\njson" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" | aws configure --profile my-profile
cat ~/.aws/config ~/.aws/credentials

apt -y remove docker-compose
apt -y remove golang-docker-credential-helpers
ecr_login=$(aws ecr get-login --no-include-email --region ap-northeast-1)
eval $ecr_login
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
/usr/local/bin/docker-compose --version

echo " - Please remember re-login when using docker-compose! "
# --- END --- #


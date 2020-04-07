#!/bin/bash


domains=(cli.sec-aau.dk ntp-event.dk)
rsa_key_size=4096
email="jbengt17@student.aau.dk"
staging=0 

echo "### Starting nginx ..."
docker-compose up --force-recreate -d nginx
echo

echo "### Requesting Let's Encrypt certificate for $domains ..."
#Join $domains to -d args
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="$domain_args -d $domain"
done

# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

docker-compose run --rm --entrypoint "\
  certbot certonly  
    $staging_arg \  
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --dns-cloudflare \ 
    --dns-cloudflare-credentials \
   /etc/letsencrypt/cloudflare_auth.key
    --force-renewal" certbot
echo

echo "### Reloading nginx ..."
docker-compose exec nginx nginx -s reload

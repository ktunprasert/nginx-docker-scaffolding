# nginx-docker-scaffolding

This is a dockerised nginx scaffolding that was used as an entry point for a django api. The repo is equipped with 2 containers: the nginx and the certbot.

## Quickstart

1. `cp .env{.example,}`
2. Set `DOMAINS` var in the `.env`
3. Change `kristun.xyz` within `nginx/nginx.conf` to your intended domain(s)
    - Be sure to add more :80 and :443 server blocks as needed
4. Run the `init-letsencrypt.sh` - this will generate a dummy certificate for us, doesn't matter if this fails
5. `docker-compose up`

## Containers

### Nginx

This container is quite straightforward. It proxy passes to an external container that exists on the same docker network within the host machine. If you look at the `docker-compose` file there is a shared external volume coming through from our django container. This volume is a shared, bound, mounted volume with the Django.

The intention is when the user uploads a file through Django the file will exist on the host machine and both docker containers have access, Django will handle the file admin while Nginx will handle file serving. We don't want to overload our already slow Django with file requests.

See `nginx/nginx.conf:99`

### Certbot

This exists only to sleep and check to renew the SSL certificate from Let'sEncrypt every 12 hours

See `docker-compose.yaml:25`

## Scripts

## init-letencrypt.sh

I did not make this script, I've only modified the `domains_list` to come from `.env`. I am documenting my Nginx docker journey for future uses. Resource below. You will notice that our `init-letsencrypt.sh` looks different than the repo version. Some bash genius fixed the script for multiple domains which the vanilla version wasn't capable of. Unfortunately I lost the link to where I found it. I will update this when I have it.

Resources:

-   https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
-   https://github.com/wmnnd/nginx-certbot/blob/master/init-letsencrypt.sh

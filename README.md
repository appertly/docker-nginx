# docker-nginx
Docker image of nginx with more throrough settings and a FastCGI connection to an HHVM Docker image.

## General config

The content root is configured for the Debian default, which is `/usr/share/nginx/html`.

Gzip compression is enabled for many common MIME types. See the included `nginx.conf`.

The default website is configured in `/etc/nginx/conf.d/default.conf`. It's set up to redirect all traffic to 443. It also provides an unencrypted location for load balancing health checks (e.g. `http://example.com/lb-ping`).

## HHVM

The default website dispatches all `.hh` and `.php` requests to a FastCGI backend listening on port 9000. You must launch this container using the `--link your-container-name:fpm` argument.

## SSL

There are three files that will be automatically generated if they're not provided by you.

* `/etc/ssl/dhparam.pem`: Diffie-Hellman parameter for DHE ciphersuites (will auto-generate a 2048 bit file if not provided)
* `/etc/ssl/private/key.pem`: RSA private key (will auto-generate a 4096 bit key if not provided)
* `/etc/ssl/cert.pem`: X.509 public certificate (will aut-generate a self-signed certificate if not provided)

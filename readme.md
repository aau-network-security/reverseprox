#### Reverse Proxy and Let's Encrypt 

- This `docker-compose.yml` file proposes a reverse proxy and automatic certificate renew for defined domains  in environment file. Only thing is to do is just:
  - Run: `docker-compose up -d`
  - Re-build and run : `docker-compose up -d --build`
  - Remove orphans : `docker-compose down --remove-orphans`

- Example `.env` file content 

    ```

        CERTIFICATES_PATH=<path-to-certificates>
        NGINX_CONF_PATH=<path-to-configuration-file-of-nginx>
        CLOUDFLARE_EMAIL=<cloudflare-email>
        CERT_DOMAINS=example.com,example2.com
        CLOUDFLARE_API_KEY=<api-key>

    ```

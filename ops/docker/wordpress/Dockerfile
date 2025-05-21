FROM bitnami/wordpress:6.8.1

USER root

RUN install_packages \
    mariadb-client \
    git \
    curl \
    unzip

COPY src/plugins/  /opt/bitnami/wordpress/wp-content/plugins/
COPY src/themes/   /opt/bitnami/wordpress/wp-content/themes/

RUN chown -R 1001:0 /opt/bitnami/wordpress/wp-content

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -fs http://127.0.0.1:8080/wp-login.php || exit 1

# The upstream CMD ["run.sh"] remains intact

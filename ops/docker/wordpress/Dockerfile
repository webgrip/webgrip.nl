########################
# 1. Builder stage
########################
FROM bitnami/wordpress:6.8.1 AS builder
USER root

RUN install_packages mariadb-client git curl unzip

# Install wp-cli
ENV WP_CLI_VERSION=2.12.0
RUN curl -sSL -o /usr/local/bin/wp https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar \
 && chmod +x /usr/local/bin/wp

# Work inside wp-content at correct place
WORKDIR /opt/bitnami/wordpress/wp-content

# Parent theme
COPY src/themes/enfold.zip ./themes/
RUN unzip ./themes/enfold.zip -d ./themes/ && rm ./themes/enfold.zip

# Child theme
COPY src/themes/enfold-child ./themes/enfold-child

RUN chown -R 1001:0 /opt/bitnami/wordpress/wp-content

########################
# 2. Runtime stage
########################
FROM bitnami/wordpress:6.8.1
USER root

COPY --from=builder /opt/bitnami/wordpress/wp-content /opt/bitnami/wordpress/wp-content

RUN chown -R 1001:0 /opt/bitnami/wordpress/wp-content

RUN install_packages mariadb-client curl unzip \
 && chown -R 1001:0 /opt/bitnami/wordpress/wp-content

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -fs http://127.0.0.1:8080/wp-login.php || exit 1

FROM php:fpm-alpine

ENV MS_ODBC_VER 17.5.2.1-1_amd64
ENV MS_DRIVER_VER 17

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apk add --no-cache wkhtmltopdf samba-client

RUN	curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql${MS_DRIVER_VER}_${MS_ODBC_VER}.apk && \
    curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_${MS_ODBC_VER}.apk && \
    apk add --allow-untrusted msodbcsql17_${MS_ODBC_VER}.apk && \
    apk add --allow-untrusted mssql-tools_${MS_ODBC_VER}.apk && \
    apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS unixodbc-dev && \
    pecl install pdo_sqlsrv && \
    docker-php-ext-enable pdo_sqlsrv && \
    apk del .phpize-deps && \
    rm msodbcsql17_${MS_ODBC_VER}.apk && \
    rm mssql-tools_${MS_ODBC_VER}.apk
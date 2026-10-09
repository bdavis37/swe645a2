# Name: Bryce Davis
# Simple dockerfile do build the assignment 2 web application image.
FROM httpd:2.4

COPY . /usr/local/apache2/htdocs/

EXPOSE 80
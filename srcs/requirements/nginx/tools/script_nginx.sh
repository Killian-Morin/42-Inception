echo "<============> NGINX SCRIPT <============>"

# Set Global Configuration Directives of NGINX
# daemon determine if NGINX should be a daemon or not
# Here as 'off' since we want to have NGINX on the foreground
nginx -g 'daemon off;'

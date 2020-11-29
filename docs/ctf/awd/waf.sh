shell="/tmp/waf.php"
if [! -n "$shell"];then
    echo "waf is not exist"
    exit 0
find /var/www/ ‐type f ‐path "*.php" | xargs sed ‐i "s/<?php/<?
php\nrequire_once('\/tmp\/waf.php');\n/g"
if [$? -eq 0];then
    echo "done";
    exit 0;
else
    sudo find /var/www/ ‐type f ‐path "*.php" | xargs sed ‐i "s/<?php/<?
php\nrequire_once('\/tmp\/waf.php');\n/g"
    exit 0;
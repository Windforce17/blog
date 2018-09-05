echo "begin backup web\n";
tar zcvf web.tar.gz /var/www/ ;
lsb_release  -a 2>/dev/null;
file /bin/ls 2>/dev/null;
getconf LONG_BIT 2>/dev/null;
cat /etc/issue 2>/dev/null;
uname -a 2>/dev/null;
whoami 2>/dev/null;
groups;

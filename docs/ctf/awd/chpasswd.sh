echo "change password for root";
sudo passwd root;
echo "change password for $(whoami)";
passwd;
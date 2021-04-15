set -e
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/config
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config

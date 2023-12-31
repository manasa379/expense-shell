source common.sh

echo Install NodeJS Repos
curl  -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file

echo Install NodeJS
dnf install nodejs -y >>$log_file

echo Copy Backend Service File
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo Add Application User
useradd expense >>$log_file

echo Clean App Content
rm  -rf /app  >>$log_file
mkdir /app

echo Download App Content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>$log_file

cd /app
echo Extract App Content
unzip /tmp/backend.zip >>$log_file

echo Download Dependencies
npm install >>$log_file

echo Start Backend Service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend  >>$log_file

echo Install MySQL Client
dnf install mysql -y >>$log_file

echo Load Schema
mysql -h mysql.devops155.online	 -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file

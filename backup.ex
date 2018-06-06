#! /usr/bin/expect -f

#This will be used for first argument ( your fortigatename for backup file )
set FGTNAME [lindex $argv 0]
#This will be used for second argument ( your FGT IP address. Be sure that you have administrative access to it )
set FGTIP [lindex $argv 1]
set timeout 8000
#Enter your FTP Server IP Address without quotes
set FTP_SERVER_IP "IP Address"
#Enter your FTP Server Username without quotes
set FTP_USER_NAME "ftpusername"
#Enter your FTP Server Password without quotes
set FTP_PASSWORD "ftppassword"
#This will be our date format while writing backup file
set date [clock format [clock seconds] -format {%d-%m-%Y}]

#change the username if you want
spawn ssh admin@$FGTIP

expect {

"password:" {
send "yourFGTpassword\r"}
"(yes/no)? " {
send "yes\r"
expect "password:" {
send "youFGTpassword\r"}}
}

expect "# "
send "config global\r"
expect "# "
send "execute backup full-config ftp /ftppath/$FGTNAME-$date.conf $FTP_SERVER_IP $FTP_USER_NAME $FTP_PASSWORD\r"
expect "# "
send "exit\r"

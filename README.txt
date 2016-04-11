Simple Connection Monitor

**Background**
I have some computers at home on wireless that 
drop connections every few days.  Other devices in the same
location do not drop connections, so I believe the problem
is not a configuration error.  This is my fix, a script
that runs 24/7 and pings my router every five seconds.
When the ping fails, it automatically attempts a wireless
reconnect.

I did not set this up as a system service or a crontab job,
I just launch it manually as root.

**Pre-requisites**
This script should run on any recent version
of Linux, you just need the GNU Guile Scheme implementation
installed.  For Debian GNU/Linux and derivatives of Debian
like Ubuntu that also use the APT package tool, that would be
"apt-get install guile" or in some cases "apt-get install guile-2.0"
You will need to run the command as root or with the "sudo" command,
"sudo apt-get install guile" or "sudo apt-get install guile-2.0"

On Fedora Linux and other versions of Linux that use the YUM or 
DNF package tool, do "yum install guile" or "dnf install guile".
Again, you need to run the command as root or with the "sudo" command,
"sudo yum install guile" or "sudo yum install guile".

**Use**
You will need to modify connection_mon.sh to have it run the commands you
want.  On line 17, change:
(let ((status (system "ping -c 1 -W 2 192.168.1.1 > /dev/null")))
and substitute the address of your gateway, e.g. 10.1.1.1, or 192.168.0.1,
or whatever that might be.

On line 26, change
(system "nmcli --ask c up ifname wlp3s0 ap 'guywalksintoabar'")
To do (system "....") where "...." is the quoted command you need to run
to re-establish your connection.  If you need to run multiple commands,
just add multiple (system "....") lines for each command.

To run it, make sure the file is owned by the root user
"chown root connection_mon.sh" or "sudo chown root connection_mon.sh"
then make sure the file is executable
"chmod u+x connection_mon.sh" or "sudo chmod u+x connection_mon.sh"
then run it.  The program will 'own' the current terminal until you 
exit it by restarting your Linux workstation or use Ctrl-C or the 'kill' 
command to stop it.
"./connection_mon.sh"  

**License**

This software is released under the GPLv3, see the included LICENSE.txt
for details.





#!/usr/bin/bash

if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

jenkins_delete ()
{
   sudo apt-get remove --purge jenkins
}

jenkins_install (){

status="$(dpkg-query -W --showformat='${db:Status-Status}' "jenkins" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
        sudo apt-get update
        sleep 10
        sudo apt-get install jenkins
        echo "jenkins has been installed"
else
        echo "jenkins already installed"
fi
}

jenkins_update (){
sudo apt-get --only-upgrade install jenkins
}

jenkins_restart () {
sudo systemctl restart jenkins
}


case "$1" in 
	"-install")
	jenkins_install
	;;
	"-delete")
	jenkins_delete
	;;
	"-update")
	jenkins_update
	;;
	"-restart")
	jenkins_restart
	;;
esac	

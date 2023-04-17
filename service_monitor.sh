#/bin/sh
NOW=`date '+%Y-%m-%d %H:%M:%S'`

log=<log_path>/tomcat_monitor.log

hostname="<hostname>"
notification_list="<Notification email>"
flag=0
mail_path="s-nail -S smtp=<mail_path>:25"
date_path="/bin/date"
message="Mail from $hostname Environment"
detail="Notification alert "

notify_by_email()
{
        echo $message >> ${log}
        echo -e " $message - detected on $NOW !!! \n\n$detail" | ${mail_path} -r "<email_used_for_notification>" -s "$message detected on $NOW" -v "$notification_list"
}

echo "--------tomcat Monitor services on $NOW -------------" >> ${log}
#
 tomcat1_servie=`ps -ef | egrep -i "/<path_of_tomcat>" | grep -v grep | wc -l`
    if [ $tomcat1_service =  1 ]; then
             echo " Tomcat SERVICES are running." >> ${log}
             #notify_by_email
          else
             echo "Tomcat SERVICE is not running." >> ${log}
 	     detail="${detail} ,Tomcat service is down"
             
             flag=1
    fi 

 apache1_service=$(service apache2 status)
    if [[ $apache1_service == *"active (running)"* ]]; then
             echo "apache is running." >> ${log}
             #notify_by_email
          else
             echo "apache is not running." >> ${log}
 	     detail="${detail} ,apache is down"
             
             flag=1
    fi 
	
    if [ $flag  =  1 ]; then
          echo $detail >> ${log}
	  notify_by_email
       else
         echo "All the service is up and running." >> ${log}
    fi

echo " ------------- tomcat service end ---------" >> ${log}



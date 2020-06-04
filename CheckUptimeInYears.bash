#!/bin/bash
#Get uptime in years as well as days
#(JL 11/30-12/28/16)
#Added some "scale" syntax for more accurate decimal remainder output
#(JL 1/9/16)
#Added "`echo 0`" to the whole number portion (field is empty if less than 1yr)
#(JL 01/19/17)
#Also discovered that script bombs if the uptime is less than 1 day, due to the
#":" separating the hour/minute section; in progress
#(JL 01/19/17)
#Added "$Uptime_AwkF3/$UpTimeCheck" (check4 uptime less than 1 day)
#(JL 1/24-1/26/17)
#Added a space after "bc" in $UptimeInYears
#(JL 11/10/17)
#
Uptime_AwkF3=$(/usr/bin/uptime|awk '{print $3}'|sed "s/,//g")
UpTimeCheck=$(/usr/bin/uptime|awk '{print $3,$4}'|sed "s/,//g"|grep day|wc -l)
UptimeInYears=$(echo "scale=2;`/usr/bin/uptime|\
                awk '{print $3}'`/365"|bc \
                 2>/dev/null
                )
UptimeinDays=$(/usr/bin/uptime|awk '{print $3"_"$4}'|sed "s/,//g")
if [[ "$UpTimeCheck" = "0" ]]
then
echo ""
echo "uptime (`hostname`): Up less than 1 day ($Uptime_AwkF3 (h/m))."
echo ""
exit 1
fi
for y in $UptimeInYears
do echo ""
echo "uptime (`hostname`): `echo 0`$y year(s) ($UptimeinDays)"
echo ""
done
#Done!

#!/usr/bin/ruby
tiempo = Time.new
#Defines the directory to be backed up
$target = "/home/javiles/target"
#Defines where is it going to be stored
$output = '/home/javiles/backup'
#Date format used for filename: YYYYmmdd
$time = tiempo.strftime("%Y%m%d")
#Amount of days to be evaluated for removal
$days = 14
#Directory where the log is going to be stored
$logDir = "./"
#Logfile name
$logFile = "crBackup.log"
#prefix used in each logline
$logPre = tiempo.strftime("%Y-%m-%d %H:%M:%S") + ": "

system "touch " + $logDir + $logFile 
system "echo INITIALIZING CRIMSON BACKUP >> " + $logDir + $logFile
Dir.chdir($target) do
	system "zip -rv " + $time + ".zip picapollo *"
	system	"mv " + $time + ".zip " + $output
end

Dir.glob($output+ "/*.zip").each do |item|
	next if item == '.' or item == '..'
	system "echo " + $logPre + "Scanning: "+ item + " >> " + $logDir + $logFile
	fileN = item.split(//).last(12).join
	fileN = fileN[0..7]
	if fileN.to_i <= ($time.to_i - $days)
		system "rm -rf " + item
		system "echo " + $logPre + "FILE DELETED: " + fileN + " >> " + $logDir + $logFile
		
	end
end

system "echo CRIMSON BACKUP FINISHED >> " + $logDir + $logFile



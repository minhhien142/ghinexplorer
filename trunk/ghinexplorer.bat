echo on
rem set PATH=%PATH%;C:\PROGRA~1\JDK1.3\bin
rem set your java bin - version 
set PATH=%PATH%;C:\j2sdk1.4.0\bin

rem Set this line to be the directory where your new
rem application is located.
rem set your java classpath
set CLASSPATH = %CLASSPATH%;\lib\dnsns.jar;\lib\hsqldb.jar

rem to run this bat file you should set your java_home and dir path location 
java.exe -Xms32m -cp GhinExplorer.jar GhinExplorer

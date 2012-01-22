@echo off

mkdir .\build\jar
copy ..\*.xsl .\build\jar
C:\ant\bin\ant.bat compile jar
pause


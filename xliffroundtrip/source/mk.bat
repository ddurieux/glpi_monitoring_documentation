@echo off
echo (c) copyright Bryan Schnabel 2009
javac xrtV07.java
pause
rem jar cmfv MANIFEST1.MF xliffRoundTrip.0.7.jar  *.class xrtt.gif
jar cmfv MANIFEST1.MF xliffRoundTrip.0.7.jar  *.class
jar cmfv MANIFEST2.MF command-lineXRT.0.7.jar  clxrtV07.class
del *.class
pause

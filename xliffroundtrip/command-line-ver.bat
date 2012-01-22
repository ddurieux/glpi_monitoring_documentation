@echo off
echo /// May 2009
echo /// Bryan Schnabel
echo /// xliffRoundTrip Tool version 0.7
echo /// (c) Copyright Bryan Schnabel
echo /// 
echo /// Apache License\
echo /// Version 2.0, January 2004
echo /// http://www.apache.org/licenses/ 
java -jar command-lineXRT.0.7.jar samples/xliffRoundTripToolUser_docbook.xml xml2xliff.xsl > sample_doc.xlf
pause
java -jar command-lineXRT.0.7.jar sample_doc.xlf xliff2xml.xsl > back-sample_doc.xml
echo take a look at your files now, after you hit any key they will be deleted
pause
del sample_doc.xlf
del back-sample_doc.xml
pause

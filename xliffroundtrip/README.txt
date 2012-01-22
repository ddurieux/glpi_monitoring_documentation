xliffRoundTrip Tool preliminary version 0.7

(c) Bryan Schnabel 2009

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

Synopsis:

xliffRoundTrip Tool is now on v.07. This version makes use
of XLIFF 1.2 (v.06 used XLIFF 1.1). Users can immediately use
the GUI (xliffRoundTrip.0.7.jar), or command line (command-lineXRT.0.7.jar),
or compile thier own.

Included files:

- for instant processing
xliffRoundTrip.0.7.jar (invokes GUI)
command-lineXRT.0.7.jar (for command line transformations)
xliff2xml.xsl
xml2xliff.xsl

- for customization and compilation
source/xrtV07.java
source/MANIFEST1.MF
source/MANIFEST2.MF

- for ant build
ant_builder/build.xml
ant_builder/build_command_line_version.xml

- for more details on how it all works
xliffRoundTripToolUserGuide-0.7.pdf

- for XML validation of XLIFF files
samples\xmarker.xsd
samples\xliff-core-1.2-strict.xsd (or get the latest 
from http://www.oasis-open.org/committees/tc_home.php?wg_abbrev=xliff

There are various other files that you may discover (bat files, sample files,
docbook documentation files, etc.). They should all be pretty easy to figure.

Questions, bug reports, comments, etc. should go to:
bschnabel@bschnabel.com


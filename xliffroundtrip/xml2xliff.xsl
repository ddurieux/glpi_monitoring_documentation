<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               version="1.0"
               xmlns:xmrk="urn:xmarker">

<!--
////////////////////////////////////
/// May 2009
/// Bryan Schnabel
/// xliffRoundTrip Tool version 0.7
/// (c) Copyright Bryan Schnabel
/// 
/// Apache License\
/// Version 2.0, January 2004
/// http://www.apache.org/licenses/ 
////////////////////////////////////
-->

<xsl:output method="xml" indent="yes" encoding="utf-8" />

<xsl:strip-space elements="*" />

<xsl:template match="node()|@*">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="node()|@*" mode="skel">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()" mode="skel" />
 </xsl:copy>
</xsl:template>

<xsl:template match="text()" mode="skel" priority="100" />

<xsl:template match="*" mode="skel" priority="50">
 <xsl:element name="{concat('xmrk:',local-name())}" namespace="urn:xmarker">
  <xsl:attribute name="xmarker_idref">
   <xsl:value-of select="concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))" />
  </xsl:attribute>
  <xsl:for-each select="@*">
   <xsl:attribute name="{name()}">
    <xsl:value-of select="." />
   </xsl:attribute>
  </xsl:for-each>  
  <xsl:apply-templates mode="skel" />
 </xsl:element>
</xsl:template>

<xsl:template match="*[count(ancestor::*)='0']" priority="5">
 <xliff xmlns="urn:oasis:names:tc:xliff:document:1.2" 
        xmlns:xmrk="urn:xmarker" 
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        xsi:schemaLocation="urn:oasis:names:tc:xliff:document:1.2          
        xliff-core-1.2-strict.xsd
        urn:xmarker  
        xmarker.xsd" version="1.2">
  <file datatype="plaintext" source-language="en" original="{name()}">
   <header>
    <xmrk:nest>
     <xsl:element name="{concat('xmrk:',local-name())}" namespace="urn:xmarker">
     <xsl:attribute name="xmarker_idref">
      <xsl:value-of select="concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))" />
     </xsl:attribute>
      <xsl:for-each select="@*">
       <xsl:attribute name="{name()}">
        <xsl:value-of select="." />
       </xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates mode="skel" />
     </xsl:element>
    </xmrk:nest>
   </header>
   <body>
    <xsl:choose>
     <xsl:when test="not(text())">
      <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'axmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <xsl:apply-templates />
      </group>
     </xsl:when>
     <xsl:otherwise>
      <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'axmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <trans-unit id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
        <source>
         <xsl:apply-templates />
        </source>
        <target>
         <xsl:apply-templates />
        </target>
       </trans-unit>
      </group>
     </xsl:otherwise>
    </xsl:choose>
   </body>
  </file>
 </xliff>
</xsl:template>

<xsl:template match="*[count(ancestor::*)>'0'][not(ancestor::*[text()])][child::*]" priority="100">
 <xsl:variable name="ancestors" select="count(ancestor::*)" />
  <xsl:call-template name="inner" />
</xsl:template>

<xsl:template name="inner">
 <xsl:variable name="ancestors" select="count(ancestor::*)" />
 <xsl:choose>
<!-- has text, parent has text-->
  <xsl:when test="text() and parent::*[text()]">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has text, ancestor has no text -->
  <xsl:when test="text() and not(ancestor::*[text()])">
   <trans-unit id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <source>
     <xsl:apply-templates />
    </source>
    <target>
     <xsl:apply-templates />
    </target>
   </trans-unit>
  </xsl:when>
<!-- has text, ancestor has text -->
  <xsl:when test="text() and ancestor::*[text()]">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has no text, ancestor has no text -->
  <xsl:when test="not(text()) and not(ancestor::*[text()]) and child::*">
   <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'bxmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
     <xsl:apply-templates />
   </group>
  </xsl:when>
<!-- has no text, ancestor has text -->
  <xsl:when test="not(text()) and ancestor::*[text()] and child::*">
    <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <xsl:apply-templates />
    </g>
  </xsl:when>
<!-- has no text, has child, parent has text -->
  <xsl:when test="not(text()) and parent::*[text()] and child::*">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has no text, has no child, parent has text -->
  <xsl:when test="not(text()) and parent::*[text()] and not(child::*)">
   <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </x>
  </xsl:when>
<!-- has no text, has no child, ancestor has no text -->
<!-- rev 0.7, maybe take this out -->
  <xsl:when test="not(text()) and not(ancestor::*[text()]) and not(child::*)">
   <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'cxmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
<!-- per Rodolfo, don't need
    <trans-unit id="{generate-id()}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <source>
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <xsl:apply-templates />
      </x>
     </source>
     <target id="{generate-id()}">
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <xsl:apply-templates />
      </x>
     </target>
    </trans-unit>
-->
   </group>
  </xsl:when>
<!-- has no text, has no child, ancestor has text -->
  <xsl:when test="not(text()) and ancestor::*[text()] and not(child::*)">
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
       <xsl:apply-templates />
      </x>
  </xsl:when>
  <xsl:otherwise>
   <blip was="{name()}" id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
    <xsl:apply-templates />
   </blip>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="*[count(ancestor::*)>'0']">
 <xsl:variable name="ancestors" select="count(ancestor::*)" />
 <xsl:choose>
<!-- has text, parent has text-->
  <xsl:when test="text() and parent::*[text()]">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has text, ancestor has no text -->
  <xsl:when test="text() and not(ancestor::*[text()])">
   <trans-unit id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <source>
     <xsl:apply-templates />
    </source>
    <target>
     <xsl:apply-templates />
    </target>
   </trans-unit>
  </xsl:when>
<!-- has text, ancestor has text -->
  <xsl:when test="text() and ancestor::*[text()]">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has no text, ancestor has no text -->
  <xsl:when test="not(text()) and not(ancestor::*[text()]) and child::*">
   <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'dxmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
     <xsl:apply-templates />
   </group>
  </xsl:when>
<!-- has no text, ancestor has text -->
  <xsl:when test="not(text()) and ancestor::*[text()] and child::*">
    <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <xsl:apply-templates />
    </g>
  </xsl:when>
<!-- has no text, has child, parent has text -->
  <xsl:when test="not(text()) and parent::*[text()] and child::*">
   <g id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </g>
  </xsl:when>
<!-- has no text, has no child, parent has text -->
  <xsl:when test="not(text()) and parent::*[text()] and not(child::*)">
   <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <xsl:apply-templates />
   </x>
  </xsl:when>
<!-- has no text, has no child, ancestor has no text -->
  <xsl:when test="not(text()) and not(ancestor::*[text()]) and not(child::*)">
   <group xmlns="urn:oasis:names:tc:xliff:document:1.2" id="{concat(generate-id(),'exmark',local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
<!-- per Rodolfo, don't need
    <trans-unit id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
     <source>
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <xsl:apply-templates />
      </x>
     </source>
     <target>
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
       <xsl:apply-templates />
      </x>
     </target>
    </trans-unit>
-->
   </group>
  </xsl:when>
<!-- has no text, has no child, ancestor has text -->
  <xsl:when test="not(text()) and ancestor::*[text()] and not(child::*)">
      <x id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}" xmlns="urn:oasis:names:tc:xliff:document:1.2">
       <xsl:apply-templates />
      </x>
  </xsl:when>
  <xsl:otherwise>
   <blip was="{name()}" ancs="{$ancestors}" id="{concat(local-name(),'-',(count(preceding::*)+count(ancestor::*)))}">
    <xsl:apply-templates />
   </blip>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

</xsl:transform>

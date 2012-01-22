<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               version="1.0"
               xmlns:xlf="urn:oasis:names:tc:xliff:document:1.2"
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

<xsl:template match="xlf:xliff|xlf:file|xlf:header|xlf:body|xlf:target|xmrk:nest" priority="3">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="xlf:group">
 <xsl:variable name="id" select="substring-after(@id,'xmark')" />
 <xsl:element name="{local-name(//xmrk:*[@xmarker_idref=$id])}">
  <xsl:for-each select="//xmrk:*[@xmarker_idref=$id]/@*[local-name()!='xmarker_idref']">
   <xsl:copy />
  </xsl:for-each>
  <xsl:apply-templates select="xlf:group|xlf:g|xlf:trans-unit" />
 </xsl:element>
</xsl:template>

<xsl:template match="xlf:g|xlf:x">
 <xsl:variable name="id" select="@id" />
 <xsl:element name="{local-name(//xmrk:*[@xmarker_idref=$id])}">
  <xsl:for-each select="//xmrk:*[@xmarker_idref=$id]/@*[local-name()!='xmarker_idref']">
   <xsl:copy />
  </xsl:for-each>
  <xsl:apply-templates />
 </xsl:element>
</xsl:template>

<xsl:template match="xlf:trans-unit">
 <xsl:variable name="id" select="@id" />
 <xsl:element name="{local-name(//xmrk:*[@xmarker_idref=$id])}">
  <xsl:for-each select="//xmrk:*[@xmarker_idref=$id]/@*[local-name()!='xmarker_idref']">
   <xsl:copy />
  </xsl:for-each>
  <xsl:apply-templates select="xlf:target" />
 </xsl:element>
</xsl:template>

<xsl:template match="xmrk:*">
<!--
 <xsl:variable name="idref" select="@xmarker_idref" />
 <xsl:variable name="tu_idref" select="count(//xlf:trans-unit[@id=$idref])" />
 <xsl:variable name="tg_idref" select="count(//xlf:target/xlf:g[@id=$idref])" />
 <xsl:variable name="gg_idref" select="count(//xlf:target//xlf:g/xlf:g[@id=$idref])" />-->
<!--
 <xsl:variable name="my_nest">
  <xsl:for-each select="//xlf:trans-unit[@id=$idref]/xlf:target">
    select="count(//xlf:target//xlf:g/xlf:g[@id=$idref])" />
  </xsl:for-each>
 </xsl:variable>
-->
<!--
 <xsl:element name="{local-name()}">
  <xsl:for-each select="@*[local-name()!='xmarker_idref']">
   <xsl:attribute name="{local-name()}">
    <xsl:value-of select="." />
   </xsl:attribute>
  </xsl:for-each>
  <xsl:if test="$tu_idref&gt;0">
   <xsl:attribute name="tu_idref">
    <xsl:value-of select="$tu_idref" />
   </xsl:attribute>
  </xsl:if>
  <xsl:if test="$tg_idref&gt;0">
   <xsl:attribute name="tg_idref">
    <xsl:value-of select="$tg_idref" />
   </xsl:attribute>
  </xsl:if>
  <xsl:if test="$gg_idref&gt;0">
   <xsl:attribute name="gg_idref">
    <xsl:value-of select="$gg_idref" />
   </xsl:attribute>
  </xsl:if>
  <xsl:apply-templates />
 </xsl:element>-->
</xsl:template>

</xsl:transform>

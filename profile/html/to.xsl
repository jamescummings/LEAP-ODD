<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tei xs xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">

    <!-- import base conversion style -->

    <xsl:import href="/home/jamesc/git/TEIC/Stylesheets/html/html.xsl"/>

  <xsl:param name="cssFileInclude">true</xsl:param>
  <xsl:param name="cssFile" as="xs:string">leap-doc.css</xsl:param>
  <xsl:param name="tocDepth">1</xsl:param>
  <xsl:param name="institution">LEAP Project</xsl:param>
  <xsl:param name="verboseSpecDesc">true</xsl:param>
  <xsl:param name="attsOnSameLine">6</xsl:param>
  <xsl:param name="wrapLength">150</xsl:param>
  <xsl:param name="attLength">60</xsl:param>
   
</xsl:stylesheet>

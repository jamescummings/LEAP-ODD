<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="tei m"
                version="2.0">
    <!-- import base conversion style -->

    <xsl:import href="../../../latex/latex.xsl"/>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>

         <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		


Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
         <p>Author: See AUTHORS</p>
         <p>Id: $Id: to.xsl 10345 2012-05-15 08:37:59Z rahtz $</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
   
 <xsl:param name="parIndent">2em</xsl:param>   
<xsl:param name="pagebreakStyle">plain</xsl:param>
<xsl:param name="pageStyle">empty</xsl:param>
  
<xsl:template priority="1000" match="tei:milestone"/>
<xsl:template priority="1000" match="tei:pb"> {\newline <xsl:if test="@n">[<xsl:value-of select="@n"/>]</xsl:if>}</xsl:template>
<xsl:template priority="1000" match="@facs"/>

<xsl:template priority="1000" match="tei:geogName"><xsl:apply-templates/></xsl:template>

<xsl:template priority="1000" match="tei:add">[<xsl:apply-templates/>]</xsl:template>

<xsl:template priority="1000" match="tei:supplied">[<xsl:apply-templates/>]</xsl:template>
  
   
<xsl:template priority="1000" match="tei:space">
<!-- <xsl:text>[</xsl:text><xsl:value-of select="concat(@unit, ' ')"/><xsl:value-of select="@quantity"/><xsl:text>]</xsl:text> -->
<xsl:apply-templates/>
</xsl:template>

<xsl:template priority="1000" match="tei:facsimile |tei:surface/tei:graphic"/>

<xsl:template priority="1000" match="tei:addrLine"> {\newline <xsl:apply-templates/>}</xsl:template>

<xsl:template priority="1000" match="tei:p"> \par <xsl:apply-templates/></xsl:template>
   
<xsl:template priority="1000" match="tei:p[@rend='no-indent'] | tei:ab"> \par\noindent <xsl:apply-templates/> </xsl:template>
   
<xsl:template priority="1000" match="tei:app"><xsl:apply-templates select="tei:rdg[1]"/></xsl:template>
  
<xsl:template priority="1000" match="tei:figDesc[text()]">[<xsl:apply-templates/>]</xsl:template>
    
  <xsl:template priority="1000" match="tei:choice[tei:orig]"><xsl:apply-templates select="tei:orig[1]"/></xsl:template>
  <xsl:template priority="1000" match="tei:choice[tei:abbr]"><xsl:apply-templates select="tei:abbr[1]"/></xsl:template>
  <xsl:template priority="1000" match="tei:choice[tei:sic]"><xsl:apply-templates select="tei:sic[1]"/></xsl:template>
  <xsl:template priority="1000" match="tei:expan|tei:reg|tei:corr"/>
  
  <xsl:template priority="1000" match="tei:salute|tei:term|tei:unclear|tei:foreign|tei:orig|tei:sic|tei:dateline|tei:abbr"><xsl:apply-templates/></xsl:template>
  
  <xsl:template priority="1000" match="tei:dateline[@rend='right']">{\par\begin{flushright} \hspace*{0pt}\hfill <xsl:apply-templates/> \end{flushright}}</xsl:template>
  
  <xsl:template priority="1000" match="tei:lb"> \newline </xsl:template>

  <xsl:template priority="1000" match="tei:lb[preceding-sibling::node()[1][name()='dateline']]"/> 
  

  <xsl:template name="tei:item"><xsl:text>\item</xsl:text><xsl:if test="@n">[<xsl:value-of select="@n"/>]</xsl:if><xsl:text> </xsl:text><xsl:apply-templates/></xsl:template>
  
  <!--
  <xsl:template name="latexPackages">\usepackage{parskip}</xsl:template>   
  -->
  
  
  <xsl:template name="beginDocumentHook">{\newline Published by Livingstone Online (livingstoneonline.org)}
    \let\cleardoublepage\clearpage
    \setlength{\parskip}{0pt} 
  </xsl:template>   


  <xsl:template name="latexOther">
  <!--  <xsl:text>\def\TheFullDate{</xsl:text>
    <xsl:sequence select="tei:generateDate(.)"/>
    <xsl:if test="not($useFixedDate='true')">
      <xsl:variable name="revdate">
        <xsl:sequence select="tei:generateRevDate(.)"/>
      </xsl:variable>
      <xsl:if test="not($revdate='')">
        <xsl:text> (</xsl:text>
        <xsl:sequence select="tei:i18n('revisedWord')"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="$revdate"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:text>}&#10;</xsl:text>
    <xsl:text>\def\TheID{</xsl:text>
    <xsl:choose>
      <xsl:when test="not($REQUEST='')">
        <xsl:value-of select="not($REQUEST='')"/>
      </xsl:when>
      <xsl:when test="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno">
        <xsl:value-of select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno[1]"/>
      </xsl:when>
    </xsl:choose>
    <xsl:text>\makeatother </xsl:text>-->
    <xsl:text>  &#10;\def\TheDate{</xsl:text>
    <!--<xsl:sequence select="tei:generateDate(/*)"/>-->
    <xsl:text>}&#10;\title{</xsl:text>
    <xsl:choose>
      <xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='alternative']"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='alternative']"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/></xsl:otherwise>
    </xsl:choose>
    <!--<xsl:sequence select="tei:generateSimpleTitle(/*)"/>-->
    <xsl:text>}&#10;\author{</xsl:text>
    <xsl:sequence select="tei:generateAuthor(/*)"/>
    <xsl:text>}</xsl:text>
    <xsl:text>\makeatletter </xsl:text>
    <xsl:call-template name="latexBegin"/>
    <xsl:text>\makeatother </xsl:text>
  </xsl:template>
  

  <xsl:template name="makeInline">
    <xsl:param name="before"/>
    <xsl:param name="style"/>
    <xsl:param name="after"/>
    <xsl:value-of select="$before"/>
    <xsl:sequence select="tei:makeHyperTarget(@xml:id)"/>
    <xsl:choose>
      <xsl:when test="$style=('add','unclear','term','foreign', 'bibl')"><xsl:apply-templates/></xsl:when>
        
      <xsl:when test="$style=('add','unclear','docAuthor','titlem','italic','mentioned','term','foreign')">
        <xsl:text>\textit{</xsl:text>
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$style='supplied'">
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
      </xsl:when>
      <xsl:when test="$style='bold'">
        <xsl:text>\textbf{</xsl:text>
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$style='strikethrough'">
        <xsl:text>\sout{</xsl:text>
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$style='sup'">
        <xsl:text>\textsuperscript{</xsl:text>
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="$style='sub'">
        <xsl:text>\textsubscript{</xsl:text>
        <xsl:value-of select="tei:escapeChars(normalize-space(.),.)"/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="local-name()='label'">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:when test="not($style)">
        <xsl:sequence select="concat('{\',local-name(),' ')"/>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="concat('{\',$style[1], ' ')"/>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$after"/>
  </xsl:template>
  


   
   
    
</xsl:stylesheet>

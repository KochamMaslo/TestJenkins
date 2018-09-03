<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<html>
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
		<title></title>
    <style type="text/css">
      <![CDATA[
    body { font-family: Verdana, Sans-Serif; font-size: 10pt; margin: 10px 15px; text-align: justify; }
    h1 { font-family: Verdana, Sans-Serif; font-size: 15pt; font-variant: small-caps; }
  ]]>
    </style>
	</head>
	
      <!--
      $translationPath is set according to requested language. If requested language is not supported,
      it falls back to default language.
      -->
      <xsl:variable name="availableLanguages" select="'#__AVAILABLE_LANGUAGES__#'" />
      <xsl:variable name="translationPath">
        <xsl:choose>
          <xsl:when test="contains($availableLanguages, '$__LANGUAGE__$')">
            <xsl:value-of select="'#__ACTION_ROOT_PATH__#/translation/translate.$__LANGUAGE__$.xml'" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'#__ACTION_ROOT_PATH__#/translation/translate.#__FALLBACK_LANGUAGE__#.xml'" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      
      <xsl:variable name="guideTranslation" select="document($translationPath)/lang" />	
	
	<body>
	<xsl:for-each select="$guideTranslation/guide/topic">
		<h1><xsl:value-of select="heading"></xsl:value-of></h1>
		<div><xsl:value-of select="body"></xsl:value-of></div>
	</xsl:for-each>
	</body>
</html>

</xsl:template>
</xsl:stylesheet>

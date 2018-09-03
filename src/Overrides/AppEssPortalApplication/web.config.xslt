<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/>

  <xsl:template match="//defaultDocument//add">
      <add value="IWS.aspx" />
  </xsl:template>

  <xsl:template match="//webclient">
    <webclient >
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="useCapabilitiesCache">false</xsl:attribute>
      <xsl:apply-templates select="node()" />
    </webclient>
  </xsl:template>

  <!-- By default, copy all elements, attributes, and text -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

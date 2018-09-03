<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/>

  <xsl:template match="//defaultDocument//add">
      <add value="Admin.aspx" />
  </xsl:template>
  
  <xsl:template match="//system.web//authentication">
  </xsl:template>
  
  <xsl:template match="//webclient">
    <webclient >
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="useCapabilitiesCache">false</xsl:attribute>
      <xsl:apply-templates select="node()" />
    </webclient>
  </xsl:template>

  <xsl:template match="//webclient">
    <webclient >
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="mapStorageFolder">%programdata%\Hexagon\Geospatial Server\Admin Portal\Maps\</xsl:attribute>      
      <xsl:attribute name="administrationConsoleTemplates">Admin.aspx</xsl:attribute>
      <xsl:apply-templates select="node()" />
    </webclient>
  </xsl:template>
  
  <xsl:template match="//castle/components/component[@id='authManager']">
    <component>
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="type">Intergraph.WebSolutions.Core.WebClient.Platform.Security.AlwaysAdminAuthenticationManager</xsl:attribute>
      <xsl:apply-templates select="node()" />
    </component>
  </xsl:template>

  <!-- By default, copy all elements, attributes, and text -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

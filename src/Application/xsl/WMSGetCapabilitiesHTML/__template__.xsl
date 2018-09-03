<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gml="http://www.opengis.net/gml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:fn="http://www.w3.org/2004/10/xpath-functions" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:ows="http://www.opengis.net/ows" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:fes="http://www.opengis.net/fes/2.0" xmlns:dct="http://purl.org/dc/terms/" xmlns:wfs="http://www.opengis.net/wfs">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select=".//*[local-name()='Title']"/>
				</title>
				<style type="text/css"><![CDATA[ 
          * { font-family: verdana,arial,sans-serif; font-size: 11px; line-height:150%; }
  	h1 { font-size:16px; }
  	.header { background-color: #1C9495; color:#ffffff; font-weight: bold; }
  	.body { background-color: #FFFFFFF; font-family: verdana,arial,sans-serif; font-size: 11px; line-height:150%; }
  	.title { text-align: right; width:100px; }
  	.envelope { border-width: 0px; border-collapse: collapse; margin:0px; padding:0px; width:700px; }
  	.envelope td { border:1px solid #126363; padding: 2px 7px 2px 7px; vertical-align:top; }
  	.fontss {font-color:white; font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold; position:relative;}
  	a:link {color: #000000; text-decoration: underline;}
	a:active {color: #0000ff; text-decoration: underline;}
	a:visited {color: #008000; text-decoration: underline;}
	a:hover {color: #ff0000; text-decoration: none;}
	.textTitleHead {color:#000; font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold;}
	.textTitle {color:#000; font-family:verdana,arial,sans-serif; font-size:11px;}
	.spanBold {color:black; font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold;}
	.text8 {color:black; font-family:verdana,arial,sans-serif; font-size:11px;}
	h4.textSekcji {font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold; text-decoration:underline; background:#CCC; margin-top:10px; margin-bottom:0px; padding:1px;}
	.columnStyle{font-family:verdana,arial,sans-serif; font-size:11px; clolor:black; font-weight:bold}
    #main_table {margin-left:10px; width:95%;} 
    th {background:#DDD;}
    span.menu {font-size:16px;}
    span.maintitle {font-size:18px; font-weight:bold;}
    td.bline {border-top:1px solid #CCC; height:20px;}
    ul {margin-bottom:0px; margin-top:0px;}
    ul li, ul li span {margin-top:0px; margin bottom:0px; line-height:150%;}
    ]]>
    </style>
			</head>
			<!--
      $translationPath is set according to requested language. If requested language is not supported,
      it falls back to default language.
      -->
			<xsl:variable name="availableLanguages" select="'#__AVAILABLE_LANGUAGES__#'"/>
			<xsl:variable name="translationPath">
				<xsl:choose>
					<xsl:when test="contains($availableLanguages, '$__LANGUAGE__$')">
						<xsl:value-of select="'#__ACTION_ROOT_PATH__#/translation/translate.$__LANGUAGE__$.xml'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'#__ACTION_ROOT_PATH__#/translation/translate.#__FALLBACK_LANGUAGE__#.xml'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="wfsCapsTranslation" select="document($translationPath)/lang"/>

			<body>
            
				<table id="main_table">
         
         <tr>
                <td colspan="2">
                <span class="maintitle">
								<xsl:value-of select=".//*[local-name()='Title']"/>
                </span>
          </td>
         </tr>
        
        
					<tr align="left">
						<th>
            <xsl:value-of select="$wfsCapsTranslation/ServiceInformation"/><br/>
						</th>
						<th></th>
					</tr>
					<tr align="left">
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ServiceName"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<!--xsl:value-of select="./ows:ServiceIdentification/ows:ServiceType"/-->
								<xsl:value-of select=".//*[local-name()='Name']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ServiceVersion"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='WMS_Capabilities']/@*[local-name()='version']" />
                <xsl:value-of select=".//*[local-name()='WMT_MS_Capabilities']/@*[local-name()='version']" />
							</span>
						</td>
					</tr>
          <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Abstract"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='Abstract']" />
							</span>
						</td>
					</tr>
           <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Keywords"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
                <xsl:for-each select=".//*[local-name()='KeywordList']/*[local-name()='Keyword']">
										<xsl:value-of select="."/><xsl:text>, </xsl:text> 
								</xsl:for-each>
							</span>
						</td>
					</tr>
					<tr align="left">
						<th>
							<xsl:value-of select="$wfsCapsTranslation/ServiceProvider"/><br/>
						</th>
						<th></th>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ProviderName"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ContactInformation']/*[local-name()='ContactPersonPrimary']/*[local-name()='ContactOrganization']"/>
							</span>
						</td>
					</tr>
					<tr align="left">
						<th><xsl:value-of select="$wfsCapsTranslation/ContactInformation"/>: <br/>
						</th>
						<th></th>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/IndividualName"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ContactInformation']/*[local-name()='ContactPersonPrimary']/*[local-name()='ContactPerson']"/>
							</span>
						</td>
					</tr>
          <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ContactPosition"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ContactInformation']/*[local-name()='ContactPosition']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Phone"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ContactInformation']/*[local-name()='ContactVoiceTelephone']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Address"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='Address']"/>
								<xsl:text> </xsl:text>
								<br/>
								<xsl:value-of select=".//*[local-name()='City']"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select=".//*[local-name()='PostCode']"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select=".//*[local-name()='Country']"/>
							</span>
						</td>
					</tr>
					 <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/EmailContact"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ContactInformation']/*[local-name()='ContactElectronicMailAddress']"/>
							</span>
						</td>
					</tr>
					<tr height="20">
						<td colspan="2"/>
						<td/>
					</tr>
					<tr align="left">
						<th colspan="2">
							<xsl:value-of select="$wfsCapsTranslation/MetadataSection"/><br/>
						</th>
					</tr>
					<br/>
          <tr align="left">
						<th><xsl:value-of select="$wfsCapsTranslation/Requests"/><br/>
						</th>
						<th></th>
					</tr>
				  <xsl:for-each select=".//*[local-name()='Capability']/*[local-name()='Request']/*">
					  <tr>
              <td valign="top"><xsl:value-of select="name()"/></td>
              <td>
                <tr>
                  <td><xsl:value-of select="$wfsCapsTranslation/Format"/>: </td>
                  <td><span class="columnStyle">
                  <xsl:for-each select=".//*[local-name()='Format']">
                    <xsl:value-of select="."/><xsl:text>, </xsl:text>
                  </xsl:for-each>
                    </span>
                    </td>
                </tr>
                <xsl:for-each select=".//*[local-name()='DCPType']">
                  <xsl:for-each select=".//*[local-name()='HTTP']/*">
                    <tr><td><xsl:value-of select="$wfsCapsTranslation/RequestMethod"/>: </td>
                      <td>
                        <xsl:value-of select="name()"/>
                      </td>
                    </tr> 
                    <tr>
                      <td><xsl:value-of select="$wfsCapsTranslation/OnlineResource"/>:</td>
                      <td><span class="columnStyle"><xsl:value-of select=".//*[local-name()='OnlineResource']/@xlink:href"/></span></td>
                    </tr>
                    </xsl:for-each>
                  </xsl:for-each>
              </td>
            </tr>
				  </xsl:for-each>
          <tr align="left">
            <th><xsl:value-of select="$wfsCapsTranslation/Layers"/></th>
            <th></th>
          </tr>
          <xsl:choose>
            <xsl:when test=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='SRS'] or .//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='CRS']">
          <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/SRS"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
                <xsl:for-each select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='SRS']">
								  <xsl:value-of select="."/><xsl:text>, </xsl:text>
                </xsl:for-each>
								<xsl:for-each select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='CRS']">
									<xsl:value-of select="."/><xsl:text>, </xsl:text>
								</xsl:for-each>
							</span>
						</td>
					</tr>
              </xsl:when>
           </xsl:choose>
          <xsl:choose>
            <xsl:when test=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='BoundingBox']">
            <tr>
						  <td>
							  <span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/BoundingBox"/>: </span>
						  </td>
						  <td>
							  <span class="columnStyle">
								  <xsl:value-of select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='BoundingBox']/@miny"/>
							  </span><xsl:text>, </xsl:text>
                <span class="columnStyle">
								  <xsl:value-of select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='BoundingBox']/@minx"/>
							  </span><xsl:text>, </xsl:text>
                <span class="columnStyle">
								  <xsl:value-of select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='BoundingBox']/@maxy"/>
							  </span><xsl:text>, </xsl:text>
                <span class="columnStyle">
								  <xsl:value-of select=".//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='BoundingBox']/@maxx"/>
							  </span>
						  </td>
					  </tr>
            </xsl:when>
           </xsl:choose>
          <tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/LayersCount"/>: </span>
						</td>
						<td>
							<xsl:value-of select="count(.//*[local-name()='Capability']/*[local-name()='Layer']/*[local-name()='Layer'])"/>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

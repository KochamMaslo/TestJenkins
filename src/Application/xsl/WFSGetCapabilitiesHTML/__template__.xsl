<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gml="http://www.opengis.net/gml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:fn="http://www.w3.org/2004/10/xpath-functions" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:ows="http://www.opengis.net/ows" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:fes="http://www.opengis.net/fes/2.0" xmlns:dct="http://purl.org/dc/terms/" xmlns:wfs="http://www.opengis.net/wfs">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="*[local-name()='WFS_Capabilities']">
		<html>
			<head>
				<title>
					<xsl:value-of select=".//*[local-name()='Title']"/>
				</title>
				<style type="text/css">
          <![CDATA[ 
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
        
          <tr >
          <td colspan="2">
                <span class="maintitle">
								<xsl:value-of select=".//*[local-name()='Title']"/>
                </span>
          </td>
          </tr>
          
          <tr>
          <td colspan="2" class="bline">
          </td>
          </tr>
        
					<tr align="left">
						<th>
              <xsl:value-of select="$wfsCapsTranslation/ServiceInformation"/>
						</th>
						<th></th>
					</tr>
					<tr align="left">
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ServiceType"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<!--xsl:value-of select="./ows:ServiceIdentification/ows:ServiceType"/-->
								<xsl:value-of select=".//*[local-name()='ServiceType']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ServiceVersion"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<!--xsl:value-of select="./ows:ServiceIdentification/ows:ServiceTypeVersion"/-->
								<xsl:value-of select=".//*[local-name()='ServiceTypeVersion']"/>
							</span>
						</td>
					</tr>
					<tr height="20">
						<td colspan="2"/>
						<td/>
					</tr>
					<tr align="left">
						<th>
							<xsl:value-of select="$wfsCapsTranslation/ServiceProvider"/><br/>
						</th>
            <th></th>
						<td/>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ProviderName"/>: </span>
						</td>
						<!--xsl:variable name="providerName" select="./ows:ServiceProvider/ows:ProviderName"/-->
						<xsl:variable name="providerName" select=".//*[local-name()='ProviderName']"/>
						<td>
							<span class="columnStyle">
								<xsl:choose>
									<xsl:when test="$providerName = ''">
										<xsl:value-of select="$wfsCapsTranslation/NoAvailableData"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select=".//*[local-name()='ProviderName']"/>
									</xsl:otherwise>
								</xsl:choose>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ProvidersSite"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='ProviderSite']/@xlink:href"/>
							</span>
						</td>
					</tr>
					<tr align="left">
						<th><xsl:value-of select="$wfsCapsTranslation/ContactInformation"/>: <br/>
						</th>
            <th></th>
						<td/>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/IndividualName"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='IndividualName']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Phone"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='Voice']"/>
							</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Address"/>: </span>
						</td>
						<td>
							<span class="columnStyle">
								<xsl:value-of select=".//*[local-name()='DeliveryPoint']"/>
								<xsl:text> </xsl:text>
								<br/>
								<xsl:value-of select=".//*[local-name()='City']"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select=".//*[local-name()='AdministrativeArea']"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select=".//*[local-name()='PostalCode']"/>
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
								<xsl:value-of select=".//*[local-name()='ElectronicMailAddress']"/>
							</span>
						</td>
					</tr>
					<tr height="20">
						<td colspan="2"/>
						<td/>
					</tr>
					<tr align="left">
						<th>
							<xsl:value-of select="$wfsCapsTranslation/MetadataSection"/><br/>
						</th>
            <th></th>
					</tr>
					<br/>
					<br/>
					<xsl:for-each select=".//*[local-name()='Operation']">
						<tr>
							<td>
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Name"/>: </span>
							</td>
							<td>
								<span class="columnStyle">
									<xsl:value-of select="./@name"/>
								</span>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Link"/>: </span>
							</td>
							<td>
								<span class="columnStyle">
									HTTP Get:
										<xsl:for-each select=".//*[local-name()='HTTP']">
										<xsl:choose>
											<xsl:when test="count(.//*[local-name()='Get']/@xlink:href)>1">
												<ul>
													<xsl:for-each select=".//*[local-name()='Get']">
														<li>
															<xsl:value-of select="./@xlink:href"/>
														</li>
													</xsl:for-each>
												</ul>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select=".//*[local-name()='Get']/@xlink:href"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</span>
								<br/>
								<span class="columnStyle">
									HTTP Post:
									<xsl:for-each select=".//*[local-name()='HTTP']">
										<xsl:choose>
											<xsl:when test="count(.//*[local-name()='Post']/@xlink:href)>1">
												<ul>
													<xsl:for-each select=".//*[local-name()='Post']">
														<li>
															<xsl:value-of select="./@xlink:href"/>
														</li>
													</xsl:for-each>
												</ul>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select=".//*[local-name()='Post']/@xlink:href"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</span>
							</td>
						</tr>
						<xsl:for-each select=".//*[local-name()='Parameter']">
							<xsl:if test="./@name='AcceptVersions'">
								<tr>
									<td valign="top">
										<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/AcceptedVersion"/>: </span>
									</td>
									<td>
										<span class="columnStyle">
											<xsl:choose>
												<xsl:when test="count(.//*[local-name()='Value'])>1">
													<ul>
														<xsl:for-each select=".//*[local-name()='Value']">
															<li>
																<xsl:value-of select="."/>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="."/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="./@name='AcceptFormats'">
								<tr>
									<td valign="top">
										<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/AcceptedFormat"/>: </span>
									</td>
									<td>
										<span class="columnStyle">
											<xsl:choose>
												<xsl:when test="count(.//*[local-name()='Value'])>1">
													<ul>
														<xsl:for-each select=".//*[local-name()='Value']">
															<li>
																<xsl:value-of select="."/>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="."/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="./@name='outputFormat'">
								<tr>
									<td valign="top">
										<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/OutputFormat"/>: </span>
									</td>
									<td>
										<span class="columnStyle">
											<xsl:choose>
												<xsl:when test="count(.//*[local-name()='Value'])>1">
													<ul>
														<xsl:for-each select=".//*[local-name()='Value']">
															<li>
																<xsl:value-of select="."/>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="."/>
												</xsl:otherwise>
											</xsl:choose>
										</span>
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>
						<tr height="5">
							<td colspan="2"/>
							<td/>
						</tr>
						<tr height="5">
							<td colspan="2"/>
							<td/>
						</tr>
					</xsl:for-each>
					<tr height="5">
						<td colspan="2"/>
						<td/>
					</tr>
					<xsl:for-each select=".//*[local-name()='Parameter']">
						<xsl:if test="./@name='srsName'">
							<tr>
								<td valign="top">
									<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/CoordinateSystem"/>: </span>
								</td>
								<td>
									<span class="columnStyle">
										<xsl:choose>
											<xsl:when test="count(.//*[local-name()='Value'])>1">
												<ul>
													<xsl:for-each select=".//*[local-name()='Value']">
														<li>
															<xsl:value-of select="."/>
														</li>
													</xsl:for-each>
												</ul>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="."/>
											</xsl:otherwise>
										</xsl:choose>
									</span>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
					<tr height="20">
						<td colspan="2"/>
						<td/>
					</tr>
					<xsl:for-each select=".//*[local-name()='FeatureTypeList']">
						<tr align="left">
							<th>
								 <xsl:value-of select="$wfsCapsTranslation/FeatureTypeList"/><br/>
							</th>
              <th></th>
							<td/>
						</tr>
						<tr>
							<td valign="top">
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Operation"/>: </span>
							</td>
							<td>
								<span class="columnStyle">
									<xsl:value-of select=".//*[local-name()='Operation']"/>
								</span>
							</td>
						</tr>
						<tr height="5">
							<td colspan="2"/>
							<td/>
						</tr>
						<xsl:for-each select=".//*[local-name()='FeatureType']">
							<xsl:variable name="SRS" select="count(.//*[local-name()='OtherSRS'])"/>
							<xsl:variable name="CRS" select="count(.//*[local-name()='OtherCRS'])"/>
							<tr>
								<td>
									<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Name"/>: </span>
								</td>
								<td>
									<span class="columnStyle">
										<xsl:value-of select=".//*[local-name()='Name']"/>
									</span>
								</td>
							</tr>
							<tr>
								<td>
									<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Title"/>: </span>
								</td>
								<td>
									<span class="columnStyle">
										<xsl:value-of select=".//*[local-name()='Title']"/>
									</span>
								</td>
							</tr>
							<tr>
								<td>
									<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/DefaultSrs"/>: </span>
								</td>
								<td>
									<xsl:choose>
										<xsl:when test=".//*[local-name()='DefaultSRS']">
											<span class="columnStyle">
												<xsl:value-of select=".//*[local-name()='DefaultSRS']"/>
											</span>
										</xsl:when>
										<xsl:otherwise>
											<span class="columnStyle">
												<xsl:value-of select=".//*[local-name()='DefaultCRS']"/>
											</span>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<xsl:choose>
									<xsl:when test=".//*[local-name()='OtherSRS']">
										<td valign="top">
											<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/OtherSrs"/>: 
											</span>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="$SRS >1">
													<ul>
														<xsl:for-each select=".//*[local-name()='OtherSRS']">
															<li>
																<span class="columnStyle">
																	<xsl:value-of select="."/>
																</span>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:when>
												<xsl:otherwise>
													<span class="columnStyle">
														<xsl:value-of select=".//*[local-name()='OtherSRS']"/>
													</span>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</xsl:when>
									<xsl:when test=".//*[local-name()='OtherCRS']">
										<td valign="top">
											<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/OtherCrs"/>:
											</span>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="$CRS >1">
													<ul>
														<xsl:for-each select=".//*[local-name()='OtherCRS']">
															<li>
																<span class="columnStyle">
																	<xsl:value-of select="."/>
																</span>
															</li>
														</xsl:for-each>
													</ul>
												</xsl:when>
												<xsl:otherwise>
													<span class="columnStyle">
														<xsl:value-of select=".//*[local-name()='OtherCRS']"/>
													</span>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</xsl:when>
								</xsl:choose>
							</tr>
							<xsl:for-each select=".//*[local-name()='WGS84BoundingBox']">
								<tr>
									<td valign="top">
										<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/Wgs84Bbox"/>: </span>
									</td>
									<td>
										<span class="columnStyle">
											<xsl:value-of select="$wfsCapsTranslation/LowerCorner"/>: 
											<xsl:value-of select=".//*[local-name()='LowerCorner']"/>
											<br/>
											<xsl:value-of select="$wfsCapsTranslation/UpperCorner"/>: 
											<xsl:value-of select=".//*[local-name()='UpperCorner']"/>
										</span>
									</td>
								</tr>
							</xsl:for-each>
							<tr height="10">
								<td colspan="2"/>
								<td/>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
					<tr height="20">
						<td colspan="2"/>
						<td/>
					</tr>
					<xsl:for-each select=".//*[local-name()='Filter_Capabilities']">
						<tr align="left">
							<th>
								<xsl:value-of select="$wfsCapsTranslation/FilterCapabilities"/><br/>
							</th>
              <th></th>
							<td/>
						</tr>
						<tr>
							<td valign="top">
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/GeometryOperands"/>: </span>
							</td>
							<td>
								<ul>
									<xsl:for-each select=".//*[local-name()='GeometryOperand']">
										<xsl:choose>
											<xsl:when test="./@name">
												<li>
													<span class="columnStyle">
														<xsl:value-of select="./@name"/>
													</span>
												</li>
											</xsl:when>
											<xsl:otherwise>
												<li>
													<span class="columnStyle">
														<xsl:value-of select="."/>
													</span>
												</li>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</ul>
							</td>
						</tr>
						<tr height="10">
							<td colspan="2"/>
							<td/>
						</tr>
						<tr>
							<td valign="top">
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/SpatialOperators"/>: </span>
							</td>
							<td>
								<ul>
									<xsl:for-each select=".//*[local-name()='SpatialOperator']">
										<xsl:choose>
											<xsl:when test="./@name">
												<li>
													<span class="columnStyle">
														<xsl:value-of select="./@name"/>
													</span>
												</li>
											</xsl:when>
											<xsl:otherwise>
												<li>
													<span class="columnStyle">
														<xsl:value-of select="."/>
													</span>
												</li>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</ul>
							</td>
						</tr>
						<tr height="10">
							<td colspan="2"/>
							<td/>
						</tr>
						<tr>
							<td valign="top">
								<span class="spanBold"><xsl:value-of select="$wfsCapsTranslation/ComparisonOperators"/>: </span>
							</td>
							<td>
								<ul>
									<xsl:for-each select=".//*[local-name()='ComparisonOperator']">
										<xsl:choose>
											<xsl:when test="./@name">
												<li>
													<span class="columnStyle">
														<xsl:value-of select="./@name"/>
													</span>
												</li>
											</xsl:when>
											<xsl:otherwise>
												<li>
													<span class="columnStyle">
														<xsl:value-of select="."/>
													</span>
												</li>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:for-each>
								</ul>
							</td>
						</tr>
						<tr height="10">
							<td colspan="2"/>
							<td/>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

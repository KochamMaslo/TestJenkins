<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/xs:schema">
		<html>
			<head>
				<title>GIS4EU</title>
				<style type="text/css">
					<!--	<![CDATA[-->
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
  
  <!-- ]]> -->
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
			<xsl:variable name="wfsFeaturesTranslation" select="document($translationPath)/lang"/>

			<body>
        <table id="main_table">
        
        
          <tr >
          <td colspan="2">
                <span class="maintitle">
								<xsl:value-of select="$wfsFeaturesTranslation/DescribeFeatureTypeDocument"/>
                </span>
          </td>
          </tr>
          
          <tr>
          <td colspan="2" class="bline">
          </td>
          </tr>
        
					<tr>
						<th align="left"><xsl:value-of select="$wfsFeaturesTranslation/Elements"/>:<br/>
						</th>
            <th></th>
						<td/>
					</tr>
					<xsl:for-each select="./xs:element">
						<tr>
							<td>
								<span class="spanBold"><xsl:value-of select="$wfsFeaturesTranslation/Name"/>:</span>
							</td>
							<td>
								<span class="columnStyleSecond">
									<xsl:value-of select="./@name"/>
								</span>
							</td>
						</tr>
						<tr>
							<td>
								<span class="spanBold"><xsl:value-of select="$wfsFeaturesTranslation/Type"/>:</span>
							</td>
							<td>
								<span class="columnStyle">
									<xsl:value-of select="./@type"/>
								</span>
							</td>
						</tr>
						<xsl:if test="./@substitutionGroup">
							<tr>
								<td>
									<span class="spanBold"><xsl:value-of select="$wfsFeaturesTranslation/SubstitutionGroup"/>:</span>
								</td>
								<td>
									<span class="columnStyle">
										<xsl:value-of select="./@substitutionGroup"/>
									</span>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<td>
								<span class="spanBold" colspan="2"><xsl:value-of select="$wfsFeaturesTranslation/Attributes"/>:</span>
							</td>
						</tr>
						<xsl:variable name="typeName" select="./@type"/>
						<xsl:for-each select="../xs:complexType">
							<xsl:if test="./@name=substring-after($typeName,':')">
								<xsl:for-each select="descendant::xs:element">
									<xsl:choose>
										<xsl:when test="./@ref"/>
										<xsl:otherwise>
											<tr>
												<td>
													<span class="spanBold">  </span>
												</td>
												<td>
													<span class="columnStyle">
														<xsl:value-of select="./@name"/>:
									<xsl:choose>
															<xsl:when test="./@type">
																<xsl:value-of select="./@type"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:choose>
																	<xsl:when test="descendant::xs:extension">
																		<xsl:for-each select="descendant::xs:extension">
																			<xsl:choose>
																				<xsl:when test="./@base='gml:AbstractMemberType'">
																					<xsl:if test="descendant::xs:attributeGroup">
																						<xsl:choose>
																							<xsl:when test="not(descendant::xs:element)">
																								<xsl:text>gml:ReferenceType</xsl:text>
																							</xsl:when>
																							<xsl:when test="descendant::xs:element">
																								<xsl:value-of select="descendant::xs:element/@ref"/>
																							</xsl:when>
																							<xsl:otherwise>
																								<xsl:value-of select="./@base"/>
																							</xsl:otherwise>
																						</xsl:choose>
																					</xsl:if>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="./@base"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</xsl:for-each>
																	</xsl:when>
																	<xsl:when test="not(descendant::xs:extension)">
																		<xsl:for-each select="descendant::xs:complexType">
																			<xsl:choose>
																				<xsl:when test="./@base='gml:AbstractMemberType'">
																					<xsl:if test="descendant::xs:attributeGroup">
																						<xsl:choose>
																							<xsl:when test="not(descendant::xs:element)">
																								<xsl:text>gml:ReferenceType</xsl:text>
																							</xsl:when>
																							<xsl:when test="descendant::xs:element">
																								<xsl:value-of select="descendant::xs:element/@ref"/>
																							</xsl:when>
																							<xsl:otherwise>
																								<xsl:value-of select="./@base"/>
																							</xsl:otherwise>
																						</xsl:choose>
																					</xsl:if>
																				</xsl:when>
																				<xsl:when test="not(./@base='gml:AbstractMemberType')">
																					<xsl:choose>
																						<xsl:when test="not(descendant::xs:element)">
																							<xsl:text>gml:ReferenceType</xsl:text>
																						</xsl:when>
																						<xsl:when test="descendant::xs:element">
																							<xsl:value-of select="descendant::xs:element/@ref"/>
																						</xsl:when>
																					</xsl:choose>
																				</xsl:when>
																				<xsl:otherwise>
																					<xsl:value-of select="./@base"/>
																				</xsl:otherwise>
																			</xsl:choose>
																		</xsl:for-each>
																	</xsl:when>
																</xsl:choose>
															</xsl:otherwise>
														</xsl:choose>
													</span>
												</td>
											</tr>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
						<tr height="25">
							<td colspan="2"/>
							<td/>
						</tr>
					</xsl:for-each>
					<tr height="15">
						<td colspan="2"/>
						<td/>
					</tr>
					<xsl:if test="./xs:simpleType">
						<tr>
							<th colspan="2" align="left"><xsl:value-of select="$wfsFeaturesTranslation/EnumerationAndCodeLists"/>:<br/>
							</th>
							<td/>
						</tr>
						<xsl:for-each select="./xs:simpleType">
							<tr>
								<td valign="top">
									<span class="spanBold">
										<xsl:value-of select="./@name"/>
									</span>
								</td>
								<td>
									<ul>
										<xsl:for-each select="descendant::xs:enumeration">
											<li>
												<span class="columnStyle">
													<xsl:value-of select="./@value"/>
												</span>
											</li>
										</xsl:for-each>
									</ul>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:if>
				</table>
				<br/>
				<table id="main_table">
					<!--xsl:for-each select="namespace::*">
						<tr>
							<td colspan="2">
								<span class="column">
									<xsl:choose>
										<xsl:when test="not(name())">xmlns=<xsl:value-of select="."/>
										</xsl:when>
										<xsl:otherwise>xmlns:<xsl:value-of select="name()"/>=<xsl:value-of select="."/>
										</xsl:otherwise>
									</xsl:choose>
								</span>
							</td>
							<td/>
						</tr>
					</xsl:for-each-->
					<!--xsl:for-each select="xs:import">
						<tr>
							<td colspan="2">
								<span class="column">
								<xsl:variable name="schemaLocation" select="@schemaLocation"></xsl:variable>
								<xsl:for-each select="namespace">
								<xsl:if test 
								<a href="{$schemaLocation}"><xsl:value-of select="@namespace"/></a>
								</span>
							</td>
							<td/>
						</tr>
					</xsl:for-each-->
					<br/>
					<xsl:if test="./xs:import">
						<tr>
							<th align="left"><xsl:value-of select="$wfsFeaturesTranslation/ImportedNamespaces"/>:<br/>
							</th>
							<td/>
						</tr>
						<xsl:for-each select="xs:import">
							<tr>
								<td colspan="2">
									<span class="column">
										<xsl:variable name="schemaLocation" select="@schemaLocation"/>
										<xsl:variable name="namespace_uri" select="@namespace"/>
										<xsl:for-each select="namespace::*">
											<xsl:variable name="namespace_prefix" select="."/>
											<xsl:if test="contains($namespace_prefix,$namespace_uri)">
												<xsl:value-of select="name()"/>=</xsl:if>
										</xsl:for-each>
										<a href="{$schemaLocation}" target="_blank">
											<xsl:value-of select="@namespace"/>
										</a>
									</span>
								</td>
								<td/>
							</tr>
						</xsl:for-each>
					</xsl:if>
				</table>
				<br/>
				<br/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

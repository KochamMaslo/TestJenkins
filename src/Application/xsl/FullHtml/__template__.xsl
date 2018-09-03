<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:fn="http://www.w3.org/2004/10/xpath-functions" xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:ows="http://www.opengis.net/ows" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dct="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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

  <xsl:variable name="metadataMaintenanceDisplay">Data quality information</xsl:variable>
  <xsl:variable name="metadataTranslation" select="document($translationPath)/lang"/>
  <xsl:template match="//gmd:MD_Metadata">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Intergraph CSW 2.0.2</title>
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
      <xsl:variable name="metadataTranslation" select="document($translationPath)/lang"/>
      <!-- *******************************************************************************************************

														 HierarchyLevel = SERVICE

				 ********************************************************************************************************
			-->
      <xsl:if test="./gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='service'">
        <body>
          <table id="main_table">
            <tr >
              <td colspan="2">
                <span class="maintitle">
                  <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                </span>
              </td>
            </tr>
            <tr>
              <td colspan="2" class="bline">
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <span class="textTitleHead">
                  <xsl:value-of select="$metadataTranslation/Abstract"/>:
                </span>
                <br/>
                <span class="textTitle">
                  <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:abstract/gco:CharacterString"/>
                </span>
                <br/>
                <br/>
              </td>
            </tr>
            <tr>
              <td colspan="2" class="bline">
              </td>
            </tr>
            <tr>
              <td colspan="2">

                <!-- ********************    MENU      ****************** -->
                <a name="Menu">
                  <span class="menu">ISO Metadata</span>
                </a>
                <br/>
                <br/>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#MetadaneInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/MetadataInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DataInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/IdentificationInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#ExtentInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/ExtentInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DataQualityInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DistributionInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/InformationAboutDistribution"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <br/>
                <!-- ********************    Metadata information     ****************** -->
                <br/>
                <a name="MetadaneInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/MetadataInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/FileIdentifier"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:fileIdentifier/gco:CharacterString"/>
                  </span>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/MetadataLanguage"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:language/gmd:LanguageCode/@codeListValue"/>
                  </span>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/MetadataCharacterSet"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:characterSet/gmd:MD_CharacterSetCode/@codeListValue"/>
                  </span>
                  <br/>
                  <xsl:if test="./gmd:parentIdentifier/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/ParentIdentifier"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:parentIdentifier/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:for-each select="./gmd:hierarchyLevel">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/HierarchyLevel"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="attribute"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attribute"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="attributeType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attributeType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="collectionHardware"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionHardware"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="collectionSession"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionSession"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="dataset"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dataset"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="series"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_series"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="nonGeographicDataset"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_nonGeographicDataset"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="dimensionGroup"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dimensionGroup"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="feature"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_feature"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="featureType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_featureType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="propertyType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_propertyType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="fieldSession"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_fieldSession"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="software"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_software"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="service"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_service"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="model"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_model"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="tile"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_tile"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:MD_ScopeCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                  </xsl:for-each>
                  <xsl:for-each select="./gmd:hierarchyLevelName">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/HierarchyLevelName"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:for-each>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/MetadataPointOfContact"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:contact">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                      </span>
                      <span>
                        <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                      </span>
                      <br/>
                      <xsl:if test="/gmd:CI_ResponsibleParty/gmd:individualName">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/PointOfContact_IndividualName"/>:
                        </span>
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString"/>
                        </span>
                        <br/>
                      </xsl:if>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:positionName">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/PointOfContact_PositionName"/>:
                        </span>
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:positionName/gco:CharacterString"/>
                        </span>
                        <br/>
                      </xsl:if>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/Phone"/>:
                        </span>
                        <br/>
                        <xsl:for-each select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                          <blockquote>
                            <span>
                              <xsl:value-of select="./gco:CharacterString"/>
                            </span>
                            <br/>
                          </blockquote>
                        </xsl:for-each>
                      </xsl:if>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/Address"/>:
                        </span>
                        <blockquote>
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>:
                          </span>
                          <a href="mailto:{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
                            <span>
                              <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                            </span>
                          </a>
                          <br/>
                        </blockquote>
                      </xsl:if>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/OnlineResource"/>:
                        </span>
                        <blockquote>
                          <span class="spanBold">URL: </span>
                          <xsl:choose>
                            <xsl:when test="contains(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL,'http')">
                              <a href="{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank">
                                <span>
                                  <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                                </span>
                              </a>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:variable name="url">
                                http://<xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                              </xsl:variable>
                              <a href="{$url}" target="_blank">
                                <span>
                                  <xsl:value-of select="$url"/>
                                </span>
                              </a>
                            </xsl:otherwise>
                          </xsl:choose>
                          <br/>
                        </blockquote>
                      </xsl:if>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Role"/>:
                      </span>
                      <xsl:choose>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:contact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                  </blockquote>
                  <br/>
                  <xsl:if test="./gmd:dateStamp/gco:Date">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataDate"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:dateStamp/gco:Date"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:metadataStandardName/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataStandardName"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:metadataStandardName/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:metadataStandardVersion/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataStandardVersion"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:metadataStandardVersion/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************    Identification information     ****************** -->
                <br/>
                <a name="DataInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/IdentificationInformation"/>:
                  </h4>
                </a>
                <br/>
                <br/>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/Citation"/>:
                </span>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/Title"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                  </span>
                  <br/>
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/AlternateTitle"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:date">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Date"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:CI_Date/gmd:date/gco:Date"/>
                    </span>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/TypeOfDate"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="creation"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_creation"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="publication"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_publication"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="revision"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_revision"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                  </xsl:for-each>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceIdentifier"/>:
                  </span>
                  <xsl:choose>
                    <xsl:when test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString">
                      <span>
                        <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test='./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="template"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="unknown"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="missing"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="inapplicable"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_innaplicable"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="withheld"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/PartyResponsibleForTheResource"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                      </span>
                      <span>
                        <xsl:value-of select="./gmd:organisationName/gco:CharacterString"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Role"/>:
                      </span>
                      <xsl:choose>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                      <br/>
                      <br/>
                    </xsl:for-each>
                  </blockquote>
                </blockquote>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/Abstract"/>:
                </span>
                <br/>
                <span>
                  <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:abstract/gco:CharacterString"/>
                </span>
                <br/>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/PointOfContact"/>:
                </span>
                <blockquote>
                  <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:pointOfContact">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                    </span>
                    <br/>
                    <xsl:if test="./gmd:CI_ResponsibleParty//gmd:individualName">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/PointOfContact_IndividualName"/>:
                      </span>
                      <span>
                        <xsl:value-of select="./gmd:CI_ResponsibleParty//gmd:individualName/gco:CharacterString"/>
                      </span>
                      <br/>
                    </xsl:if>
                    <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Phone"/>:
                      </span>
                      <br/>
                      <xsl:for-each select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                        <blockquote>
                          <span>
                            <xsl:value-of select="./gco:CharacterString"/>
                          </span>
                          <br/>
                        </blockquote>
                      </xsl:for-each>
                    </xsl:if>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Address"/>:
                    </span>
                    <blockquote>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>:
                      </span>
                      <a href="mailto:{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                        </span>
                      </a>
                      <br/>
                    </blockquote>
                    <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/OnlineResource"/>:
                      </span>
                      <blockquote>
                        <span class="spanBold">URL: </span>
                        <xsl:choose>
                          <xsl:when test="contains(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL,'http')">
                            <a href="{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank">
                              <span>
                                <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                              </span>
                            </a>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:variable name="url">
                              http://<xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                            </xsl:variable>
                            <a href="{$url}" target="_blank">
                              <span>
                                <xsl:value-of select="$url"/>
                              </span>
                            </a>
                          </xsl:otherwise>
                        </xsl:choose>
                        <br/>
                      </blockquote>
                    </xsl:if>

                    <!-- Include MaintenanceAndUpdateFrequency -->
                    <xsl:if test="$metadataMaintenanceDisplay!='Data quality information'">
                      <xsl:if test="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>(a):
                        </span>
                        <span>
                          <xsl:apply-templates select="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode" mode="ingr_Decode_MaintenanceFrequency" />
                        </span>
                        <br/>
                      </xsl:if>


                    </xsl:if>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Role"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                    <br/>
                  </xsl:for-each>
                </blockquote>

                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/Keywords"/>:
                </span>
                <blockquote>
                  <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString">
                    <ul>
                      <li>
                        <span>
                          <xsl:value-of select="."/>
                        </span>
                      </li>
                    </ul>
                  </xsl:for-each>
                </blockquote>
                <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/TypeOfKeywords"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode/@codeListValue"/>
                  </span>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ThesaurusName"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                  </span>
                  <br/>
                  <br/>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceConstraints"/>:
                  </span>
                  <blockquote>
                    <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints/gmd:MD_RestrictionCode">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/AccessConstraints"/>:
                      </span>
                      <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints">
                        <xsl:choose>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="copyright"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_copyright"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patent"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patent"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patentPending"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patentPending"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="trademark"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_trademark"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="license"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_license"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="intellectualPropertyRights"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_intellectualPropertyRights"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="restricted"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_restricted"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="otherRestrictions"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_otherRestrictions"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:otherwise>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="./gmd:MD_RestrictionCode/@codeListValue"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints/gmd:MD_RestrictionCode">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/UseContraints"/>:
                      </span>
                      <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints">
                        <xsl:choose>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="copyright"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_copyright"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patent"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patent"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patentPending"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patentPending"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="trademark"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_trademark"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="license"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_license"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="intellectualPropertyRights"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_intellectualPropertyRights"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="restricted"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_restricted"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="otherRestrictions"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_otherRestrictions"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:otherwise>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="./gmd:MD_RestrictionCode/@codeListValue"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/OtherConstraints"/>:
                      </span>
                      <ul>
                        <li>
                          <span>
                            <xsl:value-of select="/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString"/>
                          </span>
                        </li>
                      </ul>
                    </xsl:if>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification">
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:serviceType">
                    <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:serviceType">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/SpatialDataServiceType"/>:
                      </span>
                      <xsl:choose>
                        <xsl:when test='./gco:LocalName="Discovery Service"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_ServiceType_discovery"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gco:LocalName="Download Service"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_ServiceType_download"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gco:LocalName="View Service"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_ServiceType_view"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gco:LocalName"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                    <br/>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:serviceTypeVersion">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/VersionOfService"/>:
                    </span>
                    <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:serviceTypeVersion">
                      <span>
                        <xsl:value-of select="./gco:CharacterString"/>
                      </span>
                      <br/>
                      <br/>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:couplingType">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/CouplingType"/>:
                    </span>
                    <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:couplingType">
                      <xsl:choose>
                        <xsl:when test='./srv:SV_CouplingType/@codeListValue="loose"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_CouplingType_loose"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./srv:SV_CouplingType/@codeListValue="mixed"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_CouplingType_mixed"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./srv:SV_CouplingType/@codeListValue="tight"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/SV_CouplingType_tight"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./srv:SV_CouplingType/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                    <br/>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:containsOperations">
                    <xsl:if test="not(./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:containsOperations[@gco:nilReason])">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/MethodProvidedByService"/>:
                      </span>
                      <blockquote>
                        <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:containsOperations/srv:SV_OperationMetadata">
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/MethodsName"/>:
                          </span>
                          <span>
                            <xsl:value-of select="./srv:operationName/gco:CharacterString"/>
                          </span>
                          <br/>
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/DCP"/>:
                          </span>
                          <span>
                            <xsl:value-of select="./srv:DCP/srv:DCPList/@codeListValue"/>
                          </span>
                          <br/>
                          <xsl:if test="./srv:parameters">
                            <span class="spanBold">
                              <xsl:value-of select="$metadataTranslation/Parameters"/>:
                            </span>
                            <xsl:for-each select="./srv:parameters/srv:SV_Parameter">
                              <ul style="margin-bottom:0; margin-left:50; margin-top:0; ">
                                <li>
                                  <xsl:if test="./srv:name">
                                    <span class="spanBold">
                                      <xsl:value-of select="./srv:name/gco:aName/gco:CharacterString"/>
                                    </span>
                                    <span>
                                      (<xsl:value-of select="./srv:name/gco:attributeType/gco:TypeName"/>) -
                                      <xsl:choose>
                                        <xsl:when test='./srv:optionality/gco:CharacterString="mandatory"'>
                                          <xsl:value-of select="$metadataTranslation/Mandatory"/>
                                        </xsl:when>
                                        <xsl:when test='./srv:optionality/gco:CharacterString="optional"'>
                                          <xsl:value-of select="$metadataTranslation/Optional"/>
                                        </xsl:when>
                                      </xsl:choose>
                                      <xsl:if test='./srv:description/gco:CharacterString!=""'>
                                        <span>
                                          - (<xsl:value-of select="./srv:description/gco:CharacterString"/>)
                                        </span>
                                      </xsl:if>
                                    </span>
                                  </xsl:if>
                                  <br/>
                                </li>
                              </ul>
                            </xsl:for-each>
                          </xsl:if>
                          <xsl:if test="./srv:connectPoint/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
                            <span class="spanBold">URL: </span>
                            <xsl:apply-templates select="./gmd:CI_OnlineResource/gmd:linkage" mode="ingr_Process_URL" />


                          </xsl:if>
                          <br/>
                          <br/>
                          <br/>
                          <br/>
                        </xsl:for-each>
                      </blockquote>
                      <br/>
                    </xsl:if>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:operatesOn">
                  <xsl:if test="not(./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:operatesOn[@gco:nilReason])">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/CoupledResource"/>:
                    </span>
                    <blockquote>
                      <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:operatesOn">
                        <span>
                          <xsl:value-of select="./@xlink:href"/>
                        </span>
                        <br/>
                      </xsl:for-each>
                    </blockquote>
                  </xsl:if>
                </xsl:if>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************   Extent information     ****************** -->
                <br/>
                <a name="ExtentInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/ExtentInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement">
                    <xsl:if test="not[./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/@nilReason]">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/TemporalElement"/>:
                      </span>
                      <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimeInstant">
                        <blockquote>
                          <xsl:for-each select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement">
                            <span>
                              <xsl:value-of select="./gmd:EX_TemporalExtent/gmd:extent/gml:TimeInstant/gml:timePosition"/>
                            </span>
                            <br/>
                          </xsl:for-each>
                        </blockquote>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod">
                      <blockquote>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/BeginDate"/>:
                        </span>
                        <xsl:choose>
                          <xsl:when test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:begin">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:begin/gml:TimeInstant/gml:timePosition"/>
                            </span>
                          </xsl:when>
                          <xsl:when test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition"/>
                            </span>
                          </xsl:when>
                        </xsl:choose>
                        <br/>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/EndDate"/>:
                        </span>
                        <xsl:choose>
                          <xsl:when test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:end">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:end/gml:TimeInstant/gml:timePosition"/>
                            </span>
                          </xsl:when>
                          <xsl:when test="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:endPosition">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:endPosition"/>
                            </span>
                          </xsl:when>
                        </xsl:choose>
                      </blockquote>
                    </xsl:if>
                  </xsl:if>
                  <xsl:if test="//gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/GeographicBoundingBox"/>:
                    </span>
                    <blockquote>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/WestLongitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/EastLongitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/SouthLatitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/NorthLatitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/srv:SV_ServiceIdentification/srv:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal"/>
                      </span>
                    </blockquote>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************   Data quality information     ****************** -->
                <br/>
                <a name="DataQualityInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ScopeOfQualityInformation"/>:
                  </span>
                  <xsl:choose>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="attribute"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attribute"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="attributeType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attributeType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="collectionHardware"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionHardware"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="collectionSession"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionSession"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="dataset"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dataset"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="series"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_series"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="nonGeographicDataset"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_nonGeographicDataset"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="dimensionGroup"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dimensionGroup"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="feature"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_feature"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="featureType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_featureType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="propertyType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_propertyType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="fieldSession"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_fieldSession"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="software"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_software"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="service"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_service"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="model"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_model"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="tile"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_tile"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <span>
                        <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue"/>
                      </span>
                    </xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Lineage"/>:
                    </span>
                    <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString">
                      <span>
                        <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString"/>
                      </span>
                      <br/>
                    </xsl:if>
                    <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason">
                      <xsl:choose>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="template"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="unknown"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="missing"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="inapplicable"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="withheld"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                      <br/>
                    </xsl:if>
                  </xsl:if>
                  <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep/gmd:description/gco:CharacterString">
                    <span>
                      <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep/gmd:description/gco:CharacterString"/>
                    </span>
                  </xsl:if>
                  <br/>
                  <xsl:if test="not(./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result[@gco:nilReason])">
                    <br/>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Report"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason">
                        <xsl:choose>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="template"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="unknown"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="missing"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="inapplicable"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="withheld"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                            </span>
                          </xsl:when>
                          <xsl:otherwise>
                            <span>
                              <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:otherwise>
                        <br/>
                        <blockquote>
                          <xsl:for-each select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result">
                            <span class="spanBold">
                              <xsl:value-of select="$metadataTranslation/Specification"/>:
                            </span>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString">
                              <span>
                                <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                              </span>
                              <br/>
                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason">
                              <xsl:choose>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="template"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="unknown"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="missing"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="inapplicable"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="withheld"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <xsl:if test="$metadataMaintenanceDisplay='Data quality information'">
                                    <xsl:if test="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode">
                                      <span class="spanBold">
                                        <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>(c):
                                      </span>
                                      <span>
                                        <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason"/>
                                      </span>



                                      <br/>
                                    </xsl:if>
                                  </xsl:if>


                                </xsl:otherwise>
                              </xsl:choose>
                              <br/>

                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString">
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/Explanation"/>:
                              </span>
                              <span>
                                <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString"/>
                              </span>
                              <br/>
                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean">
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/Pass"/>:
                              </span>
                              <xsl:if test='./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean="true"'>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/Boolean_true"/>
                                </span>
                              </xsl:if>
                              <xsl:if test='./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean="false"'>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/Boolean_false"/>
                                </span>
                              </xsl:if>
                            </xsl:if>
                            <br/>
                            <br/>
                          </xsl:for-each>
                          <br/>
                        </blockquote>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                </blockquote>
                <br/>

                <!-- ********************    Distribution information    ****************** -->
                <br/>
                <a name="DistributionInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/InformationAboutDistribution"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution">

                    <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat">
                      <xsl:if test="not[./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:name/@nilReason|./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:version/@nilReason]">
                        <xsl:for-each select="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat">
                          <br/>
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/DistributionFormat"/>:
                          </span>
                          <blockquote>
                            <xsl:if test="./gmd:MD_Format">
                              <xsl:for-each select="gmd:MD_Format">
                                <table>
                                  <tr style="width: 100%;">
                                    <td>
                                      <span class="spanBold">
                                        <xsl:value-of select="$metadataTranslation/FormatName"/>:
                                      </span>
                                    </td>
                                    <td>
                                      <xsl:if test="./gmd:name/gco:CharacterString">
                                        <span>
                                          <xsl:value-of select="./gmd:name/gco:CharacterString"/>
                                        </span>
                                      </xsl:if>
                                      <xsl:if test="./gmd:name/@gco:nilReason">
                                        <xsl:choose>
                                          <xsl:when test='./gmd:name/@gco:nilReason="template"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:name/@gco:nilReason="unknown"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:name/@gco:nilReason="missing"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:name/@gco:nilReason="inapplicable"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:name/@gco:nilReason="withheld"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <span>
                                              <xsl:value-of select="./gmd:name/@gco:nilReason"/>
                                            </span>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </xsl:if>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td>
                                      <span class="spanBold">
                                        <xsl:value-of select="$metadataTranslation/FormatVersion"/>:
                                      </span>
                                    </td>
                                    <td>
                                      <xsl:if test="./gmd:version/gco:CharacterString">
                                        <span>
                                          <xsl:value-of select="./gmd:version/gco:CharacterString"/>
                                        </span>
                                      </xsl:if>
                                      <xsl:if test="./gmd:version/@gco:nilReason">
                                        <xsl:choose>
                                          <xsl:when test='./gmd:version/@gco:nilReason="template"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="unknown"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="missing"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="inapplicable"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="withheld"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <span>
                                              <xsl:value-of select="./gmd:version/@gco:nilReason"/>
                                            </span>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </xsl:if>
                                    </td>
                                  </tr>
                                </table>
                              </xsl:for-each>
                            </xsl:if>
                          </blockquote>
                          <br/>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/DistributorTransferOptions"/>:
                      </span>
                      <br/>
                      <blockquote>
                        <xsl:for-each select="./gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
                          <span class="spanBold">URL: </span>
                          <xsl:apply-templates select="./gmd:CI_OnlineResource/gmd:linkage" mode="ingr_Process_URL" />
                          <br/>
                        </xsl:for-each>
                        <br/>
                      </blockquote>
                    </xsl:if>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
              </td>
            </tr>
          </table>
          <br/>
          <br/>
        </body>
      </xsl:if>
      <!-- *******************************************************************************************************

														 HierarchyLevel != SERVICE

				********************************************************************************************************
			-->
      <xsl:if test="./gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue!='service'">
        <body >
          <table id="main_table">
            <tr >
              <td colspan="2">
                <span class="maintitle">
                  <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                </span>
              </td>
            </tr>
            <tr>
              <td colspan="2" class="bline">
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <span class="textTitleHead">
                  <xsl:value-of select="$metadataTranslation/Abstract"/>:
                </span>
                <br/>
                <span class="textTitle">
                  <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString"/>
                </span>
                <br/>
                <br/>
              </td>
            </tr>

            <tr>
              <td colspan="2" class="bline">
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <!-- ********************    MENU      ****************** -->
                <a name="Menu">
                  <span class="menu">ISO 19115 - Metadata</span>
                </a>
                <br/>
                <br/>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#MetadaneInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/MetadataInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DataInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/IdentificationInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#ExtentInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/ExtentInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DataQualityInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#SRSInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/ReferenceSystemInformation"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <ul style="margin-bottom:0; margin-top:0; ">
                  <li>
                    <a href="#DistributionInformation">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/InformationAboutDistribution"/>
                      </span>
                    </a>
                  </li>
                </ul>
                <br/>
                <!-- ********************    Metadata information     ****************** -->
                <br/>
                <a name="MetadataInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/MetadataInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/FileIdentifier"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:fileIdentifier/gco:CharacterString"/>
                  </span>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/MetadataLanguage"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:language/gmd:LanguageCode/@codeListValue"/>
                  </span>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/MetadataCharacterSet"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:characterSet/gmd:MD_CharacterSetCode/@codeListValue"/>
                  </span>
                  <br/>
                  <xsl:if test="./gmd:parentIdentifier/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/ParentIdentifier"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:parentIdentifier/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:for-each select="./gmd:hierarchyLevel">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/HierarchyLevel"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="attribute"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attribute"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="attributeType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attributeType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="collectionHardware"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionHardware"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="collectionSession"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionSession"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="dataset"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dataset"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="series"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_series"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="nonGeographicDataset"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_nonGeographicDataset"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="dimensionGroup"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dimensionGroup"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="feature"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_feature"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="featureType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_featureType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="propertyType"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_propertyType"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="fieldSession"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_fieldSession"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="software"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_software"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="service"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_service"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="model"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_model"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:MD_ScopeCode/@codeListValue="tile"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_ScopeCode_tile"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:MD_ScopeCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                  </xsl:for-each>
                  <xsl:for-each select="./gmd:hierarchyLevelName">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/HierarchyLevel"/> name:
                    </span>
                    <span>
                      <xsl:value-of select="./gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:for-each>
                  <xsl:for-each select="./gmd:contact">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataPointOfContact"/>:
                    </span>
                    <blockquote>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                      </span>
                      <span>
                        <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                      </span>
                      <br/>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/Phone"/>:
                        </span>
                        <br/>
                        <xsl:for-each select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                          <blockquote>
                            <span>
                              <xsl:value-of select="./gco:CharacterString"/>
                            </span>
                            <br/>
                          </blockquote>
                        </xsl:for-each>
                      </xsl:if>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Address"/>:
                      </span>
                      <blockquote>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>:
                        </span>
                        <a href="mailto:{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
                          <span>
                            <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                          </span>
                        </a>
                        <br/>
                      </blockquote>
                      <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/OnlineResource"/>:
                        </span>
                        <blockquote>
                          <span class="spanBold">URL: </span>

                          <xsl:if test="contains(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL,'http')">
                            <a href="{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank">
                              <span>
                                <xsl:apply-templates select="./gmd:CI_OnlineResource/gmd:linkage" mode="ingr_Process_URL" />
                              </span>
                            </a>
                          </xsl:if>
                          <br/>
                        </blockquote>
                      </xsl:if>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Role"/>:
                      </span>
                      <xsl:choose>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </blockquote>
                    <br/>
                  </xsl:for-each>
                  <xsl:if test="./gmd:dateStamp/gco:Date">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataDate"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:dateStamp/gco:Date"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:metadataStandardName/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataStandardName"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:metadataStandardName/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:if test="./gmd:metadataStandardVersion/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MetadataStandardVersion"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:metadataStandardVersion/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************    Identification information     ****************** -->
                <br/>
                <a name="DataInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/IdentificationInformation"/>:
                  </h4>
                </a>
                <br/>
                <br/>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/Citation"/>:
                </span>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/Title"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                  </span>
                  <br/>
                  <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/AlternateTitle"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString"/>
                    </span>
                    <br/>
                  </xsl:if>
                  <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Date"/>:
                    </span>
                    <br/>
                    <span>
                      <xsl:value-of select="./gmd:CI_Date/gmd:date/gco:Date"/>
                      <br/>
                    </span>
                    <span class="spanBold">
                      <br/>
                      <xsl:value-of select="$metadataTranslation/TypeOfDate"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="creation"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_creation"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="publication"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_publication"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue="revision"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_revision"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                  </xsl:for-each>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceIdentifier"/>:
                  </span>
                  <xsl:choose>
                    <xsl:when test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString">
                      <span>
                        <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="template"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="unknown"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="missing"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="inapplicable"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason="withheld"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/@gco:nilReason"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <br/>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/PartyResponsibleForTheResource"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                      </span>
                      <span>
                        <xsl:value-of select="./gmd:organisationName/gco:CharacterString"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Role"/>:
                      </span>
                      <xsl:choose>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                      <br/>
                      <br/>
                    </xsl:for-each>
                  </blockquote>
                </blockquote>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/Abstract"/>:
                </span>
                <br/>
                <span>
                  <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString"/>
                </span>
                <br/>

                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:purpose">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/Purpose"/>:
                  </span>
                  <br/>
                  <span class="blockquoteIndent">
                    <span>
                      <xsl:apply-templates select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:purpose" mode="ingr_Get_Locate_Text" />
                    </span>
                  </span>
                </xsl:if>
                <br/>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/StatusOfTheDataset"/>:
                  </span>
                  <xsl:choose>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="completed"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_completed"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="historicalArchive"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_historicalArchive"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="obsolete"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_obsolete"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="onGoing"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_onGoing"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="planned"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_planned"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="required"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_required"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue="underDevelopment"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_StatusCode_underDevelopment"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <span>
                        <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
                      </span>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
                <br/>
                <br/>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/PointOfContact"/>:
                </span>
                <blockquote>
                  <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                    </span>
                    <span>
                      <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                    </span>
                    <br/>
                    <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/Phone"/>:
                      </span>
                      <br/>
                      <xsl:for-each select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                        <blockquote>
                          <span>
                            <xsl:value-of select="./gco:CharacterString"/>
                          </span>
                          <br/>
                        </blockquote>
                      </xsl:for-each>
                    </xsl:if>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Address"/>:
                    </span>
                    <blockquote>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>:
                      </span>
                      <a href="mailto:{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                        </span>
                      </a>
                      <br/>
                    </blockquote>
                    <xsl:if test="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/OnlineResource"/>:
                      </span>
                      <blockquote>
                        <span class="spanBold">URL: </span>
                        <xsl:choose>
                          <xsl:when test="contains(./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL,'http')">
                            <a href="{./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL}" target="_blank">
                              <span>
                                <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                              </span>
                            </a>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:variable name="url">
                              http://<xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
                            </xsl:variable>
                            <a href="{$url}" target="_blank">
                              <span>
                                <xsl:value-of select="$url"/>
                              </span>
                            </a>
                          </xsl:otherwise>
                        </xsl:choose>
                        <br/>
                      </blockquote>
                    </xsl:if>
                    <!-- Include metadataMaintenance -->
                    <xsl:if test="$metadataMaintenanceDisplay!='Data quality information'">
                      <xsl:if test="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/FileIdentifier"/>:
                        </span>
                        <span>
                          <xsl:apply-templates select="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode" mode="ingr_Decode_MaintenanceFrequency" />
                        </span>
                      </xsl:if>
                    </xsl:if>

                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Role"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                        </span>
                      </xsl:when>
                      <xsl:when test='./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                        <span>
                          <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                        </span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span>
                          <xsl:value-of select="./gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                        </span>
                      </xsl:otherwise>
                    </xsl:choose>
                    <br/>
                    <br/>
                    <br/>
                  </xsl:for-each>
                </blockquote>
                <span class="spanBold">
                  <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>:
                </span>
                <xsl:choose>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="continual"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_continual"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="daily"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_daily"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="weekly"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_weekly"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="fortnightly"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_fortnightly"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="monthly"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_monthly"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="quarterly"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_quartely"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="biannually"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_biannually"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="annually"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_annually"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="asNeeded"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_asNeeded"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="irregular"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_irregular"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="notPlanned"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_notPlanned"/>
                    </span>
                  </xsl:when>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue="unknown"'>
                    <span>
                      <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span>
                      <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue"/>
                    </span>
                  </xsl:otherwise>
                </xsl:choose>
                <br/>
                <br/>

                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/Keywords"/>:
                  </span>
                  <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords">
                    <!-- responsible for lines between keywrords - - -
                    <xsl:if test="position()!='1'">
                      <hr class="hrListSep"/>
                    </xsl:if>
                    -->
                    <xsl:apply-templates select="." mode="ingr_Display_Keyword"/>
                  </xsl:for-each>
                  <br/>
                </xsl:if>

                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/TypeOfKeywords"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode/@codeListValue"/>
                    <br/>
                  </span>
                  <br/>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ThesaurusName"/>:
                  </span>
                  <span>
                    <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                  </span>
                  <br/>
                  <br/>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceConstraints"/>:
                  </span>
                  <blockquote>
                    <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints/gmd:MD_RestrictionCode">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/AccessConstraints"/>:
                      </span>
                      <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:accessConstraints">
                        <xsl:choose>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="copyright"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_copyright"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patent"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patent"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patentPending"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patentPending"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="trademark"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_trademark"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="license"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_license"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="intellectualPropertyRights"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_intellectualPropertyRights"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="restricted"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_restricted"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="otherRestrictions"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_otherRestrictions"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:otherwise>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="./gmd:MD_RestrictionCode/@codeListValue"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints/gmd:MD_RestrictionCode">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/UseContraints"/>:
                      </span>
                      <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:useConstraints">
                        <xsl:choose>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="copyright"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_copyright"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patent"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patent"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="patentPending"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patentPending"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="trademark"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_trademark"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="license"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_license"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="intellectualPropertyRights"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_intellectualPropertyRights"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="restricted"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_restricted"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_RestrictionCode/@codeListValue="otherRestrictions"'>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_otherRestrictions"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:when>
                          <xsl:otherwise>
                            <ul>
                              <li>
                                <span>
                                  <xsl:value-of select="./gmd:MD_RestrictionCode/@codeListValue"/>
                                </span>
                              </li>
                            </ul>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/OtherConstraints"/>:
                      </span>
                      <ul>
                        <li>
                          <span>
                            <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString"/>
                          </span>
                        </li>
                      </ul>
                    </xsl:if>
                    <br/>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialRepresentationType">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/SpatialRepresentationType"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialRepresentationType">
                      <xsl:choose>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="vector"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_vector"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="grid"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_grid"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="textTable"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_textTable"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="tin"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_tin"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="stereoModel"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_stereoModel"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:MD_SpatialRepresentationTypeCode/@codeListValue="video"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_video"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:MD_SpatialRepresentationTypeCode/@codeListValue"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/SpatialResolution"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution">
                      <span>
                        <xsl:value-of select="./gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
                      </span>
                    </xsl:for-each>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language/gmd:LanguageCode/@codeListValue">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceLanguage"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language">
                      <span>
                        <xsl:value-of select="./gmd:LanguageCode/@codeListValue"/>
                      </span>
                      <br/>
                    </xsl:for-each>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/gmd:MD_CharacterSetCode/@codeListValue">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ResourceCharacterSet"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet">
                      <span>
                        <xsl:value-of select="./gmd:MD_CharacterSetCode/@codeListValue"/>
                      </span>
                      <br/>
                    </xsl:for-each>
                  </blockquote>
                </xsl:if>
                <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory/gmd:MD_TopicCategoryCode">
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/TopicCategory"/>:
                  </span>
                  <blockquote>
                    <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification">
                      <xsl:choose>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="farming"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_farming"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="biota"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_biota"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="boundaries"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_boundaries"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="climatologyMeteorologyAtmosphere"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_climatologyMeteorologyAtmosphere"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="economy"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_economy"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="elevation"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_elevation"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="environment"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_environment"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="geoscientificInformation"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_geoscientificInformation"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="health"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_health"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="imageryBaseMapsEarthCover"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_imageryBaseMapsEarthCover"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="intelligenceMilitary"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_intelligenceMilitary"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="inlandWaters"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_inlandWaters"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="location"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_location"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="oceans"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_oceans"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="planningCadastre"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_planningCadastre"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="society"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_society"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="structure"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_structure"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="transportation"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_transportation"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:topicCategory/gmd:MD_TopicCategoryCode="utilitiesCommunication"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_utilitiesCommunication"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:topicCategory/gmd:MD_TopicCategoryCode"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                      <br/>
                    </xsl:for-each>
                  </blockquote>
                </xsl:if>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************   Extent information     ****************** -->
                <br/>
                <a name="ExtentInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/ExtentInformation"/>:
                  </h4>
                </a>
                <blockquote>
                  <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement">
                    <xsl:if test="not[./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/@nilReason]">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/TemporalElement"/>:
                      </span>
                      <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimeInstant">
                        <blockquote>
                          <xsl:for-each select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement">
                            <span>
                              <xsl:value-of select="./gmd:EX_TemporalExtent/gmd:extent/gml:TimeInstant/gml:timePosition"/>
                            </span>
                            <br/>
                          </xsl:for-each>
                        </blockquote>
                      </xsl:if>
                    </xsl:if>
                    <!--xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod"-->
                    <xsl:if test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod">
                      <blockquote>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/BeginDate"/>:
                        </span>
                        <xsl:choose>
                          <xsl:when test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:begin">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:begin/gml:TimeInstant/gml:timePosition"/>
                            </span>
                          </xsl:when>
                          <xsl:when test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition">
                            <span>
                              <xsl:value-of select="../gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition"/>
                            </span>
                          </xsl:when>
                        </xsl:choose>
                        <br/>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/EndDate"/>:
                        </span>
                        <xsl:choose>
                          <xsl:when test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:end">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:end/gml:TimeInstant/gml:timePosition"/>
                            </span>
                          </xsl:when>
                          <xsl:when test="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:endPosition">
                            <span>
                              <xsl:value-of select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:endPosition"/>
                            </span>
                          </xsl:when>
                        </xsl:choose>

                      </blockquote>
                    </xsl:if>
                  </xsl:if>
                  <br/>
                  <xsl:if test="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/GeographicBoundingBox"/>:
                    </span>
                    <blockquote>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/WestLongitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/EastLongitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/SouthLatitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal"/>
                      </span>
                      <br/>
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/NorthLatitude"/>:
                      </span>
                      <span>
                        <xsl:value-of select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal"/>
                      </span>
                    </blockquote>
                  </xsl:if>
                </blockquote>
                <br/>

                <!-- Include metadataMaintenance & resourceMaintenance -->
                <xsl:choose>
                  <xsl:when test='./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue!=""'>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>(y):
                    </span>
                    <span>
                      <xsl:apply-templates select="./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode" mode="ingr_Decode_MaintenanceFrequency" />
                    </span>
                    <br/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:if test="$metadataMaintenanceDisplay='Data quality information'">
                      <xsl:if test="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>(z):
                        </span>
                        <span>
                          <xsl:apply-templates select="./gmd:metadataMaintenance/gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode" mode="ingr_Decode_MaintenanceFrequency" />
                        </span>
                        <br/>
                      </xsl:if>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>

                <!-- ********************   Data quality information     ****************** -->
                <br/>
                <a name="DataQualityInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ScopeOfQualityInformation"/>:
                  </span>
                  <xsl:choose>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="attribute"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attribute"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="attributeType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attributeType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="collectionHardware"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionHardware"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="collectionSession"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionSession"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="dataset"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dataset"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="series"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_series"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="nonGeographicDataset"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_nonGeographicDataset"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="dimensionGroup"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dimensionGroup"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="feature"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_feature"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="featureType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_featureType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="propertyType"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_propertyType"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="fieldSession"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_fieldSession"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="software"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_software"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="service"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_service"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="model"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_model"/>
                      </span>
                    </xsl:when>
                    <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue="tile"'>
                      <span>
                        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_tile"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <span>
                        <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue"/>
                      </span>
                    </xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Lineage"/>:
                    </span>
                    <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString">
                      <span>
                        <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString"/>
                      </span>
                      <br/>
                    </xsl:if>
                    <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason">
                      <xsl:choose>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="template"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="unknown"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="missing"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="inapplicable"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                          </span>
                        </xsl:when>
                        <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason="withheld"'>
                          <span>
                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                          </span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span>
                            <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/@gco:nilReason"/>
                          </span>
                        </xsl:otherwise>
                      </xsl:choose>
                      <br/>
                    </xsl:if>
                  </xsl:if>
                  <br/>
                  <xsl:if test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep/gmd:description/gco:CharacterString">
                    <span>
                      <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:processStep/gmd:LI_ProcessStep/gmd:description/gco:CharacterString"/>
                    </span>
                  </xsl:if>
                  <br/>
                  <xsl:if test="not(./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result[@gco:nilReason])">
                    <br/>
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/Report"/>:
                    </span>
                    <xsl:choose>
                      <xsl:when test="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason">
                        <xsl:choose>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="template"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="unknown"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="missing"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="inapplicable"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason="withheld"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                            </span>
                          </xsl:when>
                          <xsl:otherwise>
                            <span>
                              <xsl:value-of select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/@gco:nilReason"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:otherwise>
                        <br/>
                        <blockquote>
                          <xsl:for-each select="./gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result">
                            <span class="spanBold">
                              <xsl:value-of select="$metadataTranslation/Specification"/>:
                            </span>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString">
                              <span>
                                <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
                              </span>
                              <br/>
                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason">
                              <xsl:choose>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="template"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="unknown"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="missing"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="inapplicable"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                  </span>
                                </xsl:when>
                                <xsl:when test='./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason="withheld"'>
                                  <span>
                                    <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                  </span>
                                </xsl:when>
                                <xsl:otherwise>
                                  <span>
                                    <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/@gco:nilReason"/>
                                  </span>
                                </xsl:otherwise>
                              </xsl:choose>
                              <br/>
                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString">
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/Explanation"/>:
                              </span>
                              <span>
                                <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString"/>
                              </span>
                              <br/>
                            </xsl:if>
                            <xsl:if test="./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean">
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/Pass"/>:
                              </span>
                              <xsl:if test='./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean="true"'>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/Boolean_true"/>
                                </span>
                              </xsl:if>
                              <xsl:if test='./gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean="false"'>
                                <span>
                                  <xsl:value-of select="$metadataTranslation/Boolean_false"/>
                                </span>
                              </xsl:if>
                              <!--responsible for viewing date -->
                              <span class="spanBold">
                                <br/>
                                <xsl:value-of select="$metadataTranslation/Date"/>:
                              </span>
                              <span>
                                <xsl:value-of select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
                              </span>
                              <span>
                                <xsl:apply-templates select="./gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode" mode="ingr_Decode_DateType" />
                              </span>
                              <br/>
                            </xsl:if>
                            <br/>
                          </xsl:for-each>
                          <br/>
                        </blockquote>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************    Reference System Information    ****************** -->
                <br/>
                <a name="SRSInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/ReferenceSystemInformation"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <span class="spanBold">
                    <xsl:value-of select="$metadataTranslation/ReferenceSystemIdentifier"/>:
                  </span>
                  <br/>
                  <blockquote>
                    <table>
                      <tbody>
                        <xsl:for-each select="./gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier">
                          <tr style="width: 100%;">
                            <td>
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/ReferenceSystem_code"/>:
                              </span>
                              <span>
                                <xsl:value-of select="./gmd:code/gco:CharacterString"/>
                              </span>
                            </td>
                            <td style="width: 4px;"/>
                            <td>
                              <span class="spanBold">
                                <xsl:value-of select="$metadataTranslation/ReferenceSystem_codeSpace"/>:
                              </span>
                              <span>
                                <xsl:value-of select="./gmd:codeSpace/gco:CharacterString"/>
                              </span>
                            </td>

                          </tr>
                        </xsl:for-each>
                      </tbody>
                    </table>
                  </blockquote>
                  <br/>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
                <!-- ********************    Distribution information    ****************** -->
                <br/>
                <a name="DistributionInformation">
                  <h4 class="textSekcji">
                    <xsl:value-of select="$metadataTranslation/InformationAboutDistribution"/>:
                  </h4>
                </a>
                <br/>
                <blockquote>
                  <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor">
                    <span class="spanBold">
                      <xsl:value-of select="$metadataTranslation/InformationAboutDistributor"/>:
                    </span>
                    <xsl:for-each select="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor">
                      <blockquote>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/PointOfContact_OrganizationName"/>:
                        </span>
                        <span>
                          <xsl:value-of select="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
                        </span>
                        <br/>
                        <xsl:if test="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString">
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/Phone"/>:
                          </span>
                          <br/>
                          <xsl:for-each select="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice">
                            <blockquote>
                              <span>
                                <xsl:value-of select="./gco:CharacterString"/>
                              </span>
                              <br/>
                            </blockquote>
                          </xsl:for-each>
                        </xsl:if>
                        <xsl:if test="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/Address"/>:
                          </span>
                          <blockquote>
                            <span class="spanBold">
                              <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>:
                            </span>
                            <a href="mailto:{./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
                              <span>
                                <xsl:value-of select="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
                              </span>
                            </a>
                            <br/>
                          </blockquote>
                        </xsl:if>
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/Role"/>:
                        </span>
                        <xsl:choose>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="resourceProvider"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="custodian"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="owner"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="user"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="distributor"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="originator"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="pointOfContact"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="principalInvestigator"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="processor"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="publisher"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
                            </span>
                          </xsl:when>
                          <xsl:when test='./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue="author"'>
                            <span>
                              <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
                            </span>
                          </xsl:when>
                          <xsl:otherwise>
                            <span>
                              <xsl:value-of select="./gmd:MD_Distributor/gmd:distributorContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                        <br/>
                      </blockquote>
                      <xsl:if test="./gmd:MD_Distributor/gmd:distributionOrderProcess">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/OrderingProcess"/>:
                        </span>
                        <blockquote>
                          <span class="spanBold">
                            <xsl:value-of select="$metadataTranslation/Fees"/>:
                          </span>
                          <br/>
                          <span>
                            <xsl:value-of select="./gmd:MD_Distributor/gmd:distributionOrderProcess/gmd:MD_StandardOrderProcess/gmd:fees/gco:CharacterString"/>
                          </span>
                          <br/>
                        </blockquote>
                      </xsl:if>
                      <xsl:if test="./gmd:MD_Distributor/gmd:distributorFormat">
                        <xsl:if test="not[./gmd:MD_Distributor/gmd:distributitorFormat/gmd:MD_Format/gmd:name/@nilReason|./gmd:MD_Distributor/gmd:distributorFormat/gmd:MD_Format/gmd:version/@nilReason]">
                          <blockquote>
                            <span class="spanBold">
                              <xsl:value-of select="$metadataTranslation/DistributionFormat"/>:
                            </span>
                            <br/>
                            <table>
                              <tbody>
                                <xsl:for-each select="./gmd:MD_Distributor/gmd:distributorFormat/gmd:MD_Format">
                                  <tr style="width: 100%;">
                                    <td>
                                      <span class="spanBold">
                                        <xsl:value-of select="$metadataTranslation/FormatName"/>:
                                      </span>
                                    </td>
                                    <td>
                                      <span>
                                        <xsl:value-of select="./gmd:name/gco:CharacterString"/>
                                      </span>
                                    </td>
                                    <td style="width: 5px;"/>
                                    <td>
                                      <span class="spanBold">
                                        <xsl:value-of select="$metadataTranslation/FormatVersion"/>:
                                      </span>
                                    </td>
                                    <td>
                                      <xsl:if test="./gmd:version/gco:CharacterString">
                                        <span>
                                          <xsl:value-of select="./gmd:version/gco:CharacterString"/>
                                        </span>
                                      </xsl:if>
                                      <xsl:if test="./gmd:version/@gco:nilReason">
                                        <xsl:choose>
                                          <xsl:when test='./gmd:version/@gco:nilReason="template"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="unknown"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="missing"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="inapplicable"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:when test='./gmd:version/@gco:nilReason="withheld"'>
                                            <span>
                                              <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                            </span>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <span>
                                              <xsl:value-of select="./gmd:version/@gco:nilReason"/>
                                            </span>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                      </xsl:if>
                                    </td>
                                  </tr>
                                </xsl:for-each>
                              </tbody>
                            </table>
                          </blockquote>
                        </xsl:if>
                      </xsl:if>
                      <xsl:if test="./gmd:MD_Distributor/gmd:distributorTransferOptions">
                        <span class="spanBold">
                          <xsl:value-of select="$metadataTranslation/DistributorTransferOptions"/>:
                        </span>
                        <br/>
                        <blockquote>
                          <xsl:for-each select="./gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
                            <span class="spanBold">URL: </span>
                            <xsl:apply-templates select="./gmd:CI_OnlineResource/gmd:linkage" mode="ingr_Process_URL" />
                            <br/>
                          </xsl:for-each>
                          <br/>
                        </blockquote>
                      </xsl:if>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution">
                    <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:name/gco:CharacterString">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/DistributionFormat"/>:
                      </span>
                      <xsl:for-each select="./gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat">
                        <xsl:if test="./gmd:MD_Format">
                          <blockquote>
                            <xsl:for-each select="gmd:MD_Format">
                              <table>
                                <tr style="width: 100%;">
                                  <td>
                                    <span class="spanBold">
                                      <xsl:value-of select="$metadataTranslation/FormatName"/>:
                                    </span>
                                  </td>
                                  <td>
                                    <xsl:if test="./gmd:name/gco:CharacterString">
                                      <span>
                                        <xsl:value-of select="./gmd:name/gco:CharacterString"/>
                                      </span>
                                    </xsl:if>
                                    <xsl:if test="./gmd:name/@gco:nilReason">
                                      <xsl:choose>
                                        <xsl:when test='./gmd:name/@gco:nilReason="template"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:name/@gco:nilReason="unknown"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:name/@gco:nilReason="missing"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:name/@gco:nilReason="inapplicable"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:name/@gco:nilReason="withheld"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <span>
                                            <xsl:value-of select="./gmd:name/@gco:nilReason"/>
                                          </span>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:if>
                                  </td>
                                </tr>
                                <tr>
                                  <td>
                                    <span class="spanBold">
                                      <xsl:value-of select="$metadataTranslation/FormatVersion"/>:
                                    </span>
                                  </td>
                                  <td>
                                    <xsl:if test="./gmd:version/gco:CharacterString">
                                      <span>
                                        <xsl:value-of select="./gmd:version/gco:CharacterString"/>
                                      </span>
                                    </xsl:if>
                                    <xsl:if test="./gmd:version/@gco:nilReason">
                                      <xsl:choose>
                                        <xsl:when test='./gmd:version/@gco:nilReason="template"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_template"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:version/@gco:nilReason="unknown"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:version/@gco:nilReason="missing"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_missing"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:version/@gco:nilReason="inapplicable"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_inapplicable"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:when test='./gmd:version/@gco:nilReason="withheld"'>
                                          <span>
                                            <xsl:value-of select="$metadataTranslation/NilReason_withheld"/>
                                          </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                          <span>
                                            <xsl:value-of select="./gmd:version/@gco:nilReason"/>
                                          </span>
                                        </xsl:otherwise>
                                      </xsl:choose>
                                    </xsl:if>
                                  </td>
                                </tr>
                              </table>
                            </xsl:for-each>
                          </blockquote>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:if>
                    <xsl:if test="./gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions">
                      <span class="spanBold">
                        <xsl:value-of select="$metadataTranslation/DistributorTransferOptions"/>:
                      </span>
                      <blockquote class="blockquoteIndent">
                        <xsl:for-each select="./gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
                          <span class="spanBold">URL: </span>
                          <xsl:apply-templates select="./gmd:CI_OnlineResource/gmd:linkage" mode="ingr_Process_URL" />
                          <br/>
                        </xsl:for-each>
                        <br/>
                      </blockquote>
                    </xsl:if>
                  </xsl:if>
                </blockquote>
                <br/>
                <a href="#Menu">
                  <span class="text8">Menu</span>
                </a>
              </td>
            </tr>
          </table>
          <br/>
          <br/>
        </body>
      </xsl:if>
    </html>
  </xsl:template>

  <xsl:template match="*" mode="ingr_Decode_MaintenanceFrequency">
    <xsl:choose>
      <xsl:when test='./@codeListValue="continual"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_continual"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="daily"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_daily"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="weekly"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_weekly"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="fortnightly"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_fortnightly"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="monthly"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_monthly"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="quarterly"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_quarterly"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="biannually"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_biannually"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="annually"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_annually"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="asNeeded"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_asNeeded"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="irregular"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_irregular"/>:
      </xsl:when>
      <xsl:when test='./@codeListValue="notPlanned"'>
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_notPlanned"/>
      </xsl:when>
      <xsl:when test='./@codeListValue="unknown"'>
        <xsl:value-of select="$metadataTranslation/NilReason_unknown"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="./@codeListValue"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="*" mode="ingr_Decode_DateType">
    <xsl:if test="./@codeListValue">
      <br/>
      <span class="spanBold">
        <xsl:value-of select="$metadataTranslation/TypeOfDate"/>:
      </span>
      <xsl:text> (</xsl:text>
      <xsl:choose>
        <xsl:when test='./@codeListValue="creation"'>
          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_creation"/>
        </xsl:when>
        <xsl:when test='./@codeListValue="publication"'>
          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_publication"/>
        </xsl:when>
        <xsl:when test='./@codeListValue="revision"'>
          <xsl:value-of select="$metadataTranslation/MD_DateTypeCode_revision"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./@codeListValue"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>


  <xsl:template match="gmd:URL|@xlink:href" mode="ingr_Process_URL" >
    <xsl:variable name="urlTitle" select="."/>
    <xsl:variable name="url">
      <xsl:choose>
        <xsl:when test="contains($urlTitle,'http')">
          <xsl:value-of select="$urlTitle"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('http://',$urlTitle)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a href="{$url}" target="new">
      <span>
        <xsl:value-of select="$urlTitle"/>
      </span>
    </a>
  </xsl:template>


  <xsl:template match="*" mode="ingr_Get_Locate_Text">
    <xsl:choose>
      <xsl:when test="./gmd:PT_FreeText">
        <xsl:choose>
          <xsl:when test="./gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString/@locale = '$__LANGUAGE__$'">
            <xsl:value-of select="./gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='$__LANGUAGE__$']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="./gco:CharacterString"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="./gco:CharacterString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template match="*" mode="ingr_Decode_KeywordType">
    <xsl:variable name="tpKeyword" select="./@codeListValue"/>
    <xsl:choose>
      <xsl:when test='$tpKeyword="discipline"'>
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_discipline"/>
      </xsl:when>
      <xsl:when test='$tpKeyword="place"'>
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_place"/>
      </xsl:when>
      <xsl:when test='$tpKeyword="stratum"'>
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_stratum"/>
      </xsl:when>
      <xsl:when test='$tpKeyword="temporal"'>
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_temporal"/>
      </xsl:when>
      <xsl:when test='$tpKeyword="theme"'>
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_theme"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$tpKeyword"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="*" mode="ingr_Display_Keyword">
    <ul>
      <xsl:for-each select="./gmd:keyword">
        <li class="keyword">
          <span class="keyword">
            <xsl:apply-templates select="." mode="ingr_Get_Locate_Text" />
          </span>
        </li>
      </xsl:for-each>
    </ul>
    <blockquote class="blockquoteIndent">
      <xsl:if test="./gmd:type">
        <span class="spanBold">
          <xsl:value-of select="$metadataTranslation/TypeOfKeywords"/>:
        </span>
        <span>
          <xsl:apply-templates select="./gmd:type/gmd:MD_KeywordTypeCode" mode="ingr_Decode_KeywordType" />
        </span>
        <br/>
      </xsl:if>
      <xsl:if test="./gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString">
        <span class="spanBold">
          <xsl:value-of select="$metadataTranslation/ThesaurusName"/>:
        </span>
        <span>
          <xsl:apply-templates select="./gmd:thesaurusName/gmd:CI_Citation/gmd:title" mode="ingr_Get_Locate_Text" />
        </span>
        <br/>
      </xsl:if>
      <xsl:if test="./gmd:thesaurusName/gmd:CI_Citation/gmd:date">
        <xsl:if test="./gmd:thesaurusName/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date != ''">
          <span class="spanBold">
            <xsl:value-of select="$metadataTranslation/Date"/>:
          </span>
          <span>
            <xsl:value-of select="./gmd:thesaurusName/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
            <xsl:apply-templates select="./gmd:thesaurusName/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode" mode="ingr_Decode_DateType" />
          </span>
        </xsl:if>
      </xsl:if>
      <xsl:if test="./gmd:thesaurusName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:code/gco:CharacterString">
        <span class="spanBold">
          <xsl:value-of select="$metadataTranslation/ThesaurusCode"/>:
          <br/>
        </span>
        <span>
          <xsl:apply-templates select="./gmd:thesaurusName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:code" mode="ingr_Get_Locate_Text" />
        </span>
        <br/>
      </xsl:if>
      <xsl:if test="./gmd:thesaurusName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString">
        <span class="spanBold">
          <xsl:value-of select="$metadataTranslation/ThesaurusCodeSpace"/>:
        </span>
        <span>
          <xsl:apply-templates select="./gmd:thesaurusName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:codeSpace" mode="ingr_Get_Locate_Text" />
        </span>
        <br/>
      </xsl:if>
    </blockquote>
  </xsl:template>
</xsl:stylesheet>



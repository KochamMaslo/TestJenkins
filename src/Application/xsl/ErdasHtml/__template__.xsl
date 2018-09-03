<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

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

  <xsl:output method="html"/>
  <xsl:template match="text()|@*">
    <!-- Destroy whitespace so test cases function properly -->
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="text()|@*">
    <!-- Destroy whitespace so test cases function properly -->
    <xsl:value-of select="normalize-space(.)"></xsl:value-of>
  </xsl:template>

  <xsl:template match="/*">
    <!--
      the describes element has another MD_Metadata element as a child,
      which does not have any child elements itself. That case is covered
      in the xsl:otherwise clause.
    -->
    <xsl:choose>
      <xsl:when test="count(./*) &gt; 0">
        <html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml" lang="en">
          <head>
            <title>
              <xsl:value-of select="$metadataTranslation/Metadata"/>
            </title>
            <style type="text/css">

              <![CDATA[ 

* { font-family: verdana,arial,sans-serif; font-size: 11px; line-height:150%; }
  	h1 { font-size:16px; }
  	.header { background-color: #1C9495; color:#ffffff; font-weight: bold; }
  	.body { background-color: #FFFFFF; font-family: verdana,arial,sans-serif; font-size: 11px; line-height:150%; }
  	.title { text-align: left; min-width:100px; padding-left:15px; }
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

              *{
              font-family: Arial !important;
              font-size: 11px;
              cursor: default;
              }

              body {
              font-family:Arial !important;
              font-size: 11px;
              cursor: default;
              background-color:white;
              margin: 5px;
              color: #545559;
              }

              .title{
              color: #0097BA;
              padding-top:3px;
              }

              .divTableOfContents {
              color: #0097ba;
              margin: 15px;
              }

              td.bline {
              border-top: 1px dotted #CCC;
              height:0px;
              }

              .ulTableOfContents{
              margin-bottom: 0px;
              margin-top: 0px;
              list-style-type: square;
              }

              .ulTableOfContents li a:link {
              color: #0097ba;
              text-decoration: underline;
              font-size: 12px;
              cursor: hand;
              }

              .ulTableOfContents li a:visited {
              color: #0097ba;
              }

              .ulTableOfContents li a:hover {
              color: #7FAF42;
              }

              .ulTableOfContents li a:active {
              color: #BAD879;
              }

              .divTableOfContents h4 {
              font-size: 14px;
              padding: 0px;
              margin: 5px;
              }

              .sectionDiv{
              width:100%;
              }

              .sectionHeaderDiv {
              background-color: #0097BA;
              color: white;
              padding-left: 5px;
              width: 100%;
              }

              .sectionHeaderDiv h4 {
              padding:3px;
              font-size: 14px;
              margin-bottom: 5px;
              }

              .sectionBodyDiv{

              }

              .backDiv{
              text-align:right;
              padding-top:5px;
              padding-bottom:5px;
              padding-right:5px;
              color: #0097ba;
              }

              .backDiv a{
              color: #0097ba;
              font-size:11px;
              font-family: Arial !important;
              cursor:hand;
              }

              .backDiv a:visited{
              color: #0097ba;
              }

              .backDiv a:hover{
              color: #7FAF42;
              }

              .backDiv a:active{
              color: #BAD879;
              }


              /***************************** SubSection *******************************************/

              /*Subsection level 1*/
              div.sectionDiv div.sectionBodyDiv div.subSection{
              margin-left:15px;
              margin-right:15px;
              border: none;
              margin-top:0px;
              }

              /*Subsection level 2*/
              div.sectionDiv div.sectionBodyDiv div.subSection div.subSectionBody div.subSection {
              margin-left:15px;
              margin-right:15px;
              border: none;
              margin-top:0px;
              }

              /*Subsection level 3*/
              div.sectionDiv div.sectionBodyDiv div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection{
              margin-left:15px;
              margin-right:15px;
              border:1px dotted;
              margin-top:2px;
              }

              /*Subsection level 4*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection {
              margin-left:15px;
              margin-right:15px;
              border: none;
              margin-top:0px;
              }

              /*Subsection level = 5*/
              div.subSection {
              margin-left:15px;
              margin-right:15px;
              border: none;
              margin-top:0px;
              }

              /***************************** SubSection Header *******************************************/

              /*SubSection Header level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionHeader{
              background-color: #85CDDB;
              border: none;
              color: white;
              font-size:13px;
              font-weight:bold;
              padding-left: 5px;
              }

              /*SubSection Header level 2*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionHeader{
              background-color: #f5f5f5;
              border:1px solid #e6e6e6;
              color: #545559;
              font-size:12px;
              font-weight:bold;
              padding-left: 5px;
              }

              /*SubSection Header level 3*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionHeader{
              background-color:white;
              border:none;
              color: #0097ba;
              font-size:11px;
              font-weight:bold;
              padding-left: 5px;
              }

              /*SubSection Header level 4*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionHeader{
              background-color:white;
              border:none;
              color: #545559;
              font-size:11px;
              font-weight:bold;
              padding-left: 5px;
              }

              /*SubSection Header level = 5*/
              div.subSectionHeader {
              background-color:white;
              border:none;
              color: #545559;
              font-size:11px;
              font-weight:bold;
              padding-left: 5px;
              }

              /***************************** SubSection Body *******************************************/

              /*SubSection Body level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody {
              padding-left:5px;
              padding-top:5px;
              padding-bottom:5px;
              padding-right:5px;
              margin-top:0px;
              margin-bottom:0px;
              }

              /*SubSection Body level 2*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody{
              padding-left:5px;
              padding-top:5px;
              padding-bottom:5px;
              padding-right:5px;
              margin-top:0px;
              margin-bottom:0px;
              }

              /*SubSection Body level 3*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody{
              padding-left:15px;
              padding-top:0px;
              padding-bottom:0px;
              padding-right:0px;
              margin-top:2px;
              margin-bottom:2px;
              }

              /*SubSection Body level 4*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody{
              padding-left:15px;
              padding-top:0px;
              padding-bottom:0px;
              padding-right:0px;
              margin-top:2px;
              margin-bottom:2px;
              }

              /*SubSection Body level = 5*/
              div.subSectionBody {
              padding-left:15px;
              padding-top:0px;
              padding-bottom:0px;
              padding-right:0px;
              margin-top:2px;
              margin-bottom:2px;
              }

              /***************************** Property *******************************************/

              /*Property level 0*/
              div.sectionDiv div.sectionBodyDiv div.property{
              margin-left:15px;
              margin-right:15px;
              margin-top:2px;
              margin-bottom: 2px;
              padding-bottom: 2px;
              padding-top:2px;
              border: none;
              }

              /*Property level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.property{
              margin-left:15px;
              margin-right:15px;
              margin-top:2px;
              margin-bottom: 2px;
              padding-bottom: 2px;
              padding-top:2px;
              border: none;
              }

              /*Property level 2*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property {
              margin-left:15px;
              margin-right:15px;
              margin-top:2px;
              margin-bottom: 2px;
              padding-bottom: 2px;
              padding-top:2px;
              border:1px dotted;
              }

              /*Property level 3*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property{
              margin-left:15px;
              margin-right:15px;
              margin-top:2px;
              margin-bottom: 2px;
              padding-bottom: 2px;
              padding-top:2px;
              border: none;
              }

              /*Property level = 5*/
              div.property {
              margin-left:15px;
              margin-right:15px;
              margin-top:2px;
              margin-bottom: 2px;
              padding-bottom: 2px;
              padding-top:2px;
              border: none;

              }

              /***************************** Property Label *******************************************/

              /*SubSection Header level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.property  div.propertyLabel{
              background-color: #85CDDB;
              border: none;
              padding-left: 5px;
              font-size:13px !important;
              font-weight:bold;
              color: white;
              float:none;
              padding-right:0px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.property  div.propertyLabel .propertyLabelSpan{
              font-size:12px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.property  div.propertyLabel::after{
              content: "" !important;
              }


              /*Property Label level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.property  div.propertyLabel{
              background-color: #f5f5f5;
              border:1px solid #e6e6e6;
              padding-left: 5px;
              font-size:12px !important;
              font-weight:bold;
              color: #545559;
              float:none;
              padding-right:0px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.property  div.propertyLabel .propertyLabelSpan{
              font-size:12px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.property  div.propertyLabel::after{
              content: "" !important;
              }


              /*Property Label level 2*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel{
              background-color:white;
              border:none;
              padding-left: 5px;
              font-size:11px !important;
              font-weight:bold;
              color: #0097ba;
              float: left;
              padding-right:0px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel .propertyLabelSpan{
              font-size:11px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel::after{
              content: ":" !important;
              padding-right:5px;
              }

              /*Property Label level 3*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel{
              background-color:white;
              border:none;
              padding-left: 5px;
              font-size:11px !important;
              font-weight:bold;
              color: #545559;
              float: left;
              padding-right:0px !important;

              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel .propertyLabelSpan{
              font-size:11px !important;
              }

              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyLabel::after{
              content: ":" !important;
              padding-right:5px;
              }

              /*Property Label level >=4 */
              div.propertyLabel {
              background-color:white;
              border:none;
              padding-left: 5px;
              font-size:11px !important;
              font-weight:bold;
              color: #545559;
              float: left;
              padding-right:0px !important;
              }

              div.propertyLabel .propertyLabelSpan{
              font-size:11px !important;
              }

              div.propertyLabel::after {
              content: ":";
              padding-right:5px;
              }

              /***************************** Property Value *******************************************/

              /*SubSection Body level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.propertyValue {
              padding-left:5px;
              padding-top:5px;

              }

              /*Property Value level 1*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.property  div.propertyValue{
              padding-left:5px;
              padding-top:5px;
              }

              /*Property Value level 2*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyValue{
              padding-left:5px;
              padding-top:0px;
              }

              /*Property Value level 3*/
              div.sectionDiv  div.sectionBodyDiv  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.subSection  div.subSectionBody  div.property  div.propertyValue{
              padding-left:5px;
              padding-top:0px;
              }

              /*Property Value level = 5*/
              div.propertyValue {
              padding-left:5px;
              padding-top:0px;
              min-width:15px;
              min-height:14px;
              }


            </style>

          </head>

          <body>
            <table width="100%">
              <tr id="topPage">
                <td>
                  <div class="title">
                    <h1>$__TITLE__$</h1>
                  </div>
                </td>
              </tr>
              <tr>
                <td class="bline">
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%">
                    <tr>
                      <td>
                        <div class="divTableOfContents">
                          <xsl:call-template name="tableOfContents"/>
                        </div>
                      </td>
                      <td class="overviewImg">
                        <div id="thumbnailSpan">
                          <img src="Proxy.WebClient.ashx?action=credentials&amp;mapServiceId=$__MAPSERVICEID__$&amp;url=$__APOLLOURL__$/erdas-apollo/catalog/content/items/$__ID__$/attachment/thumbnail" alt="Not available"
                               onerror="this.src='img/no_thumbnail.png'"/>
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              <tr>
                <td>
                  <div id="generalInformation" class="sectionDiv">
                    <div class="sectionHeaderDiv">
                      <h4>
                        <xsl:value-of select="$metadataTranslation/GeneralInformation"/>
                      </h4>
                    </div>

                    <div class="sectionBodyDiv">

                      <xsl:apply-templates select="*[local-name()='dateStamp']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='language']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='dataSetURI']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='fileIdentifier']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='characterSet']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='parentIdentifier']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='metadataStandardName']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='metadataStandardVersion']"></xsl:apply-templates>
                      <xsl:apply-templates select="*[local-name()='locale']"/>
                      <xsl:apply-templates select="*[local-name()='hierarchyLevel']"/>
                      <xsl:apply-templates select="*[local-name()='hierarchyLevelName']"/>

                      <xsl:apply-templates select="*[local-name()='metadataIdentifier']"/>
                      <xsl:apply-templates select="*[local-name()='defaultLocale']"/>
                      <xsl:apply-templates select="*[local-name()='parentMetadata']"/>
                      <xsl:apply-templates select="*[local-name()='metadataScope']"/>
                      <xsl:apply-templates select="*[local-name()='dateInfo']"/>
                      <xsl:apply-templates select="*[local-name()='metadataStandard']"/>
                      <xsl:apply-templates select="*[local-name()='metadataProfile']"/>
                      <xsl:apply-templates select="*[local-name()='alternativeMetadataReference']"/>
                      <xsl:apply-templates select="*[local-name()='otherLocale']"/>
                      <xsl:apply-templates select="*[local-name()='metadataLinkage']"/>

                      <xsl:call-template name="toTheTop"/>
                    </div>
                  </div>
                </td>
              </tr>

              <xsl:if test="(*[local-name()='contact'] and node()) or contact[.!='']">
                <tr>
                  <td>
                    <div id="contact" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/ContactInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='contact']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="(*[local-name()='spatialRepresentationInfo'] and node()) or spatialRepresentationInfo[.!='']">
                <tr>
                  <td>
                    <div id="spatialRepresentationInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/SpatialRepresentation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='spatialRepresentationInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='referenceSystemInfo']">
                <tr>
                  <td>
                    <div id="referenceSystemInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/ReferenceSystem"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='referenceSystemInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="*[local-name()='metadataExtensionInfo']">
                <tr>
                  <td>
                    <div id="metadataExtensionInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/MetadataExtensionInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='metadataExtensionInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="(*[local-name()='identificationInfo'] and node()) or identificationInfo[.!='']">
                <tr>
                  <td>
                    <div id="identificationInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/Identification"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='identificationInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="*[local-name()='contentInfo']">
                <tr>
                  <td>
                    <div id="contentInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/ContentInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='contentInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='distributionInfo']">
                <tr>
                  <td>
                    <div id="distributionInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/DistributionInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='distributionInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='dataQualityInfo']">
                <tr>
                  <td>
                    <div id="dataQualityInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='dataQualityInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='resourceLineage']">
                <tr>
                  <td>
                    <div id="resourceLineage" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/ResourceLineage"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='resourceLineage']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='portrayalCatalogueInfo']">
                <tr>
                  <td>
                    <div id="portrayalCatalogueInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/PortrayalCatalogueInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='portrayalCatalogueInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='metadataConstraints']">
                <tr>
                  <td>
                    <div id="metadataConstraints" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/MetadataConstraints"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='metadataConstraints']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='applicationSchemaInfo']">
                <tr>
                  <td>
                    <div id="applicationSchemaInfo" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/ApplicationSchemaInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='applicationSchemaInfo']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='metadataMaintenance']">
                <tr>
                  <td>
                    <div id="metadataMaintenance" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/MetadataMaintenance"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='metadataMaintenance']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='acquisitionInformation']">
                <tr>
                  <td>
                    <div id="acquisitionInformation" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/AcquisitionInformation"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='acquisitionInformation']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='series']">
                <tr>
                  <td>
                    <div id="series" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/Series"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='series']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='describes']">
                <tr>
                  <td>
                    <div id="describes" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/Describes"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='describes']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='propertyType']">
                <tr>
                  <td>
                    <div id="propertyType" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/PropertyType"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='propertyType']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='featureType']">
                <tr>
                  <td>
                    <div id="featureType" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/FeatureType"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='featureType']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

              <xsl:if test="*[local-name()='featureAttribute']">
                <tr>
                  <td>
                    <div id="featureAttribute" class="sectionDiv">
                      <div class="sectionHeaderDiv">
                        <h4>
                          <xsl:value-of select="$metadataTranslation/FeatureAttribute"/>
                        </h4>
                      </div>
                      <div class="sectionBodyDiv">
                        <xsl:apply-templates select="*[local-name()='featureAttribute']"/>
                        <xsl:call-template name="toTheTop"/>
                      </div>
                    </div>
                  </td>
                </tr>
              </xsl:if>

            </table>
          </body>
        </html>

      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="$metadataTranslation/Metadata"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="tableOfContents">
    <h4>
      <xsl:value-of select="$metadataTranslation/TableOfContents"/>
    </h4>
    <ul class="ulTableOfContents">
      <li>
        <a href="#generalInformation">
          <xsl:value-of select="$metadataTranslation/GeneralInformation"/>
        </a>
      </li>

      <xsl:if test="*[local-name()='contact']">
        <li>
          <a href="#contact">
            <xsl:value-of select="$metadataTranslation/ContactInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='spatialRepresentationInfo']">
        <li>
          <a href="#spatialRepresentationInfo">
            <xsl:value-of select="$metadataTranslation/SpatialRepresentation"/>
          </a>
        </li>
      </xsl:if>

      <xsl:if test="*[local-name()='referenceSystemInfo']">
        <li>
          <a href="#referenceSystemInfo">
            <xsl:value-of select="$metadataTranslation/ReferenceSystem"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='metadataExtensionInfo']">
        <li>
          <a href="#metadataExtensionInfo">
            <xsl:value-of select="$metadataTranslation/MetadataExtensionInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='identificationInfo']">
        <li>
          <a href="#identificationInfo">
            <xsl:value-of select="$metadataTranslation/Identification"/>
          </a>
        </li>
      </xsl:if>

      <xsl:if test="*[local-name()='contentInfo']">
        <li>
          <a href="#contentInfo">
            <xsl:value-of select="$metadataTranslation/ContentInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='distributionInfo']">
        <li>
          <a href="#distributionInfo">
            <xsl:value-of select="$metadataTranslation/DistributionInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='dataQualityInfo']">
        <li>
          <a href="#dataQualityInfo">
            <xsl:value-of select="$metadataTranslation/DataQualityInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='resourceLineage']">
        <li>
          <a href="#resourceLineage">
            <xsl:value-of select="$metadataTranslation/ResourceLineage"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='portrayalCatalogueInfo']">
        <li>
          <a href="#portrayalCatalogueInfo">
            <xsl:value-of select="$metadataTranslation/PortrayalCatalogueInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='metadataConstraints']">
        <li>
          <a href="#metadataConstraints">
            <xsl:value-of select="$metadataTranslation/MetadataConstraints"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='applicationSchemaInfo']">
        <li>
          <a href="#applicationSchemaInfo">
            <xsl:value-of select="$metadataTranslation/ApplicationSchemaInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='metadataMaintenance']">
        <li>
          <a href="#metadataMaintenance">
            <xsl:value-of select="$metadataTranslation/MetadataMaintenance"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='acquisitionInformation']">
        <li>
          <a href="#acquisitionInformation">
            <xsl:value-of select="$metadataTranslation/AcquisitionInformation"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='series']">
        <li>
          <a href="#series">
            <xsl:value-of select="$metadataTranslation/Series"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='describes']">
        <li>
          <a href="#describes">
            <xsl:value-of select="$metadataTranslation/Describes"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='propertyType']">
        <li>
          <a href="#propertyType">
            <xsl:value-of select="$metadataTranslation/PropertyType"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='featureType']">
        <li>
          <a href="#featureType">
            <xsl:value-of select="$metadataTranslation/FeatureType"/>
          </a>
        </li>
      </xsl:if>
      <xsl:if test="*[local-name()='featureAttribute']">
        <li>
          <a href="#featureAttribute">
            <xsl:value-of select="$metadataTranslation/FeatureAttribute"/>
          </a>
        </li>
      </xsl:if>
    </ul>
  </xsl:template>

  <xsl:template name="toTheTop">
    <div class="backDiv">
      <a href="#topPage">
        <xsl:value-of select="$metadataTranslation/ToTheTop"/>
      </a>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='MD_CharacterSetCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='ucs2' or text()='ucs2'">
        UCS2
      </xsl:when>
      <xsl:when test="@codeListValue='ucs4' or text()='ucs4'">
        UCS4
      </xsl:when>
      <xsl:when test="@codeListValue='utf7' or text()='utf7'">
        UTF7
      </xsl:when>
      <xsl:when test="@codeListValue='utf8' or text()='utf8'">
        UTF8
      </xsl:when>
      <xsl:when test="@codeListValue='utf16' or text()='utf16'">
        UTF16
      </xsl:when>
      <xsl:when test="@codeListValue='8859part1' or text()='8859part1'">
        ISO/IEC 8859-1
      </xsl:when>
      <xsl:when test="@codeListValue='8859part2' or text()='8859part2'">
        ISO/IEC 8859-2
      </xsl:when>
      <xsl:when test="@codeListValue='8859part3' or text()='8859part3'">
        ISO/IEC 8859-3
      </xsl:when>
      <xsl:when test="@codeListValue='8859part4' or text()='8859part4'">
        ISO/IEC 8859-4
      </xsl:when>
      <xsl:when test="@codeListValue='8859part5' or text()='8859part5'">
        ISO/IEC 8859-5
      </xsl:when>
      <xsl:when test="@codeListValue='8859part6' or text()='8859part6'">
        ISO/IEC 8859-6
      </xsl:when>
      <xsl:when test="@codeListValue='8859part7' or text()='8859part7'">
        ISO/IEC 8859-7
      </xsl:when>
      <xsl:when test="@codeListValue='8859part8' or text()='8859part8'">
        ISO/IEC 8859-8
      </xsl:when>
      <xsl:when test="@codeListValue='8859part9' or text()='8859part9'">
        ISO/IEC 8859-9
      </xsl:when>
      <xsl:when test="@codeListValue='8859part10' or text()='8859part10'">
        ISO/IEC 8859-10
      </xsl:when>
      <xsl:when test="@codeListValue='8859part11' or text()='8859part11'">
        ISO/IEC 8859-11
      </xsl:when>
      <xsl:when test="@codeListValue='8859part13' or text()='8859part13'">
        ISO/IEC 8859-13
      </xsl:when>
      <xsl:when test="@codeListValue='8859part14' or text()='8859part14'">
        ISO/IEC 8859-14
      </xsl:when>
      <xsl:when test="@codeListValue='8859part15' or text()='8859part15'">
        ISO/IEC 8859-15
      </xsl:when>
      <xsl:when test="@codeListValue='8859part16' or text()='8859part16'">
        ISO/IEC 8859-16
      </xsl:when>
      <xsl:when test="@codeListValue='jis' or text()='jis'">
        JIS
      </xsl:when>
      <xsl:when test="@codeListValue='shiftJIS' or text()='shiftJIS'">
        Shift JIS
      </xsl:when>
      <xsl:when test="@codeListValue='eucJP' or text()='eucJP'">
        EUC-JP
      </xsl:when>
      <xsl:when test="@codeListValue='usAscii' or text()='usAscii'">
        ASCII
      </xsl:when>
      <xsl:when test="@codeListValue='ebcdic' or text()='ebcdic'">
        EBCDIC
      </xsl:when>
      <xsl:when test="@codeListValue='eucKR' or text()='eucKR'">
        EUC-KR
      </xsl:when>
      <xsl:when test="@codeListValue='big5' or text()='big5'">
        big5
      </xsl:when>
      <xsl:when test="@codeListValue='GB2312' or text()='GB2312'">
        GB2312
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- DEFINE ENUMS -->
  <xsl:template match="*[local-name()='CI_DateTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='creation' or text()='creation'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_creation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='publication' or text()='publication'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_publication"/>
      </xsl:when>
      <xsl:when test="@codeListValue='revision' or text()='revision'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_revision"/>
      </xsl:when>
      <xsl:when test="@codeListValue='expiry' or text()='expiry'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_expiry"/>
      </xsl:when>
      <xsl:when test="@codeListValue='lastUpdate' or text()='lastUpdate'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_lastUpdate"/>
      </xsl:when>
      <xsl:when test="@codeListValue='lastRevision' or text()='lastRevision'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_lastRevision"/>
      </xsl:when>
      <xsl:when test="@codeListValue='nextUpdate' or text()='nextUpdate'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_nextUpdate"/>
      </xsl:when>
      <xsl:when test="@codeListValue='unavailable' or text()='unavailable'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_unavailable"/>
      </xsl:when>
      <xsl:when test="@codeListValue='inForce' or text()='inForce'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_inForce"/>
      </xsl:when>
      <xsl:when test="@codeListValue='adopted' or text()='adopted'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_adopted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='deprecated' or text()='deprecated'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_deprecated"/>
      </xsl:when>
      <xsl:when test="@codeListValue='superseded' or text()='superseded'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_superseded"/>
      </xsl:when>
      <xsl:when test="@codeListValue='validityBegins' or text()='validityBegins'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_validityBegins"/>
      </xsl:when>
      <xsl:when test="@codeListValue='validityExpires' or text()='validityExpires'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_validityExpires"/>
      </xsl:when>
      <xsl:when test="@codeListValue='released' or text()='released'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_released"/>
      </xsl:when>
      <xsl:when test="@codeListValue='distribution' or text()='distribution'">
        <xsl:value-of select="$metadataTranslation/CI_DateTypeCode_distribution"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='CI_OnLineFunctionCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='information' or text()='information'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_information"/>
      </xsl:when>
      <xsl:when test="@codeListValue='download' or text()='download'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_download"/>
      </xsl:when>
      <xsl:when test="@codeListValue='offlineAccess' or text()='offlineAccess'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_offlineAccess"/>
      </xsl:when>
      <xsl:when test="@codeListValue='order' or text()='order'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_order"/>
      </xsl:when>
      <xsl:when test="@codeListValue='search' or text()='search'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_search"/>
      </xsl:when>
      <xsl:when test="@codeListValue='completeMetadata' or text()='completeMetadata'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_completeMetadata"/>
      </xsl:when>
      <xsl:when test="@codeListValue='browseGraphic' or text()='browseGraphic'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_browseGraphic"/>
      </xsl:when>
      <xsl:when test="@codeListValue='upload' or text()='upload'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_upload"/>
      </xsl:when>
      <xsl:when test="@codeListValue='emailService' or text()='emailService'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_emailService"/>
      </xsl:when>
      <xsl:when test="@codeListValue='browsing' or text()='browsing'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_browsing"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fileAccess' or text()='fileAccess'">
        <xsl:value-of select="$metadataTranslation/CI_OnLineFunctionCode_fileAccess"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='CI_PresentationFormCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='documentDigital' or text()='documentDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_documentDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='documentHardcopy' or text()='documentHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_documentHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='imageDigital' or text()='imageDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_imageDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='imageHardcopy' or text()='imageHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_imageHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mapDigital' or text()='mapDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_mapDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mapHardcopy' or text()='mapHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_mapHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='modelDigital' or text()='modelDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_modelDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='modelHardcopy' or text()='modelHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_modelHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='profileDigital' or text()='profileDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_profileDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='profileHardcopy' or text()='profileHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_profileHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tableDigital' or text()='tableDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_tableDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tableHardcopy' or text()='tableHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_tableHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='videoDigital' or text()='videoDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_videoDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='videoHardcopy' or text()='videoHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_videoHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='audioDigital' or text()='audioDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_audioDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='audioHardcopy' or text()='audioHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_audioHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='multimediaDigital' or text()='multimediaDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_multimediaDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='multimediaHardcopy' or text()='multimediaHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_multimediaHardcopy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='physicalSample' or text()='physicalSample'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_physicalSample"/>
      </xsl:when>
      <xsl:when test="@codeListValue='diagramDigital' or text()='diagramDigital'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_diagramDigital"/>
      </xsl:when>
      <xsl:when test="@codeListValue='diagramHardcopy' or text()='diagramHardcopy'">
        <xsl:value-of select="$metadataTranslation/CI_PresentationFormCode_diagramHardcopy"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='CI_RoleCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='resourceProvider' or text()='resourceProvider'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_resourceProvider"/>
      </xsl:when>
      <xsl:when test="@codeListValue='custodian' or text()='custodian'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_custodian"/>
      </xsl:when>
      <xsl:when test="@codeListValue='owner' or text()='owner'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_owner"/>
      </xsl:when>
      <xsl:when test="@codeListValue='user' or text()='user'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_user"/>
      </xsl:when>
      <xsl:when test="@codeListValue='distributor' or text()='distributor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_distributor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='originator' or text()='originator'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_originator"/>
      </xsl:when>
      <xsl:when test="@codeListValue='pointOfContact' or text()='pointOfContact'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_pointOfContact"/>
      </xsl:when>
      <xsl:when test="@codeListValue='principalInvestigator' or text()='principalInvestigator'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_principalInvestigator"/>
      </xsl:when>
      <xsl:when test="@codeListValue='processor' or text()='processor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_processor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='publisher' or text()='publisher'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_publisher"/>
      </xsl:when>
      <xsl:when test="@codeListValue='author' or text()='author'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_author"/>
      </xsl:when>
      <xsl:when test="@codeListValue='sponsor' or text()='sponsor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_sponsor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='coAuthor' or text()='coAuthor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_coAuthor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collaborator' or text()='collaborator'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_collaborator"/>
      </xsl:when>
      <xsl:when test="@codeListValue='editor' or text()='editor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_editor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mediator' or text()='mediator'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_mediator"/>
      </xsl:when>
      <xsl:when test="@codeListValue='rightsHolder' or text()='rightsHolder'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_rightsHolder"/>
      </xsl:when>
      <xsl:when test="@codeListValue='contributor' or text()='contributor'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_contributor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='funder' or text()='funder'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_funder"/>
      </xsl:when>
      <xsl:when test="@codeListValue='stakeholder' or text()='stakeholder'">
        <xsl:value-of select="$metadataTranslation/CI_RoleCode_stakeholder"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='CI_TelephoneTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='voice' or text()='voice'">
        <xsl:value-of select="$metadataTranslation/CI_TelephoneTypeCode_voice"/>
      </xsl:when>
      <xsl:when test="@codeListValue='facsimile' or text()='facsimile'">
        <xsl:value-of select="$metadataTranslation/CI_TelephoneTypeCode_facsimile"/>
      </xsl:when>
      <xsl:when test="@codeListValue='sms' or text()='sms'">
        <xsl:value-of select="$metadataTranslation/CI_TelephoneTypeCode_sms"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='LanguageCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='CountryCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_CharacterSetCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_ContextCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='acquisition' or text()='acquisition'">
        <xsl:value-of select="$metadataTranslation/MI_ContextCode_acquisition"/>
      </xsl:when>
      <xsl:when test="@codeListValue='pass' or text()='pass'">
        <xsl:value-of select="$metadataTranslation/MI_ContextCode_pass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='wayPoint' or text()='wayPoint'">
        <xsl:value-of select="$metadataTranslation/MI_ContextCode_wayPoint"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_GeometryTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='point' or text()='point'">
        <xsl:value-of select="$metadataTranslation/MI_GeometryTypeCode_point"/>
      </xsl:when>
      <xsl:when test="@codeListValue='linear' or text()='linear'">
        <xsl:value-of select="$metadataTranslation/MI_GeometryTypeCode_linear"/>
      </xsl:when>
      <xsl:when test="@codeListValue='areal' or text()='areal'">
        <xsl:value-of select="$metadataTranslation/MI_GeometryTypeCode_areal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='strip' or text()='strip'">
        <xsl:value-of select="$metadataTranslation/MI_GeometryTypeCode_strip"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_ObjectiveTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='instantaneousCollection' or text()='instantaneousCollection'">
        <xsl:value-of select="$metadataTranslation/MI_ObjectiveTypeCode_instantaneousCollection"/>
      </xsl:when>
      <xsl:when test="@codeListValue='persistentView' or text()='persistentView'">
        <xsl:value-of select="$metadataTranslation/MI_ObjectiveTypeCode_persistentView"/>
      </xsl:when>
      <xsl:when test="@codeListValue='survey' or text()='survey'">
        <xsl:value-of select="$metadataTranslation/MI_ObjectiveTypeCode_survey"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_OperationTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='real' or text()='real'">
        <xsl:value-of select="$metadataTranslation/MI_OperationTypeCode_real"/>
      </xsl:when>
      <xsl:when test="@codeListValue='simulated' or text()='simulated'">
        <xsl:value-of select="$metadataTranslation/MI_OperationTypeCode_simulated"/>
      </xsl:when>
      <xsl:when test="@codeListValue='synthesized' or text()='synthesized'">
        <xsl:value-of select="$metadataTranslation/MI_OperationTypeCode_synthesized"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_PriorityCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='critical' or text()='critical'">
        <xsl:value-of select="$metadataTranslation/MI_PriorityCode_critical"/>
      </xsl:when>
      <xsl:when test="@codeListValue='highImportance' or text()='highImportance'">
        <xsl:value-of select="$metadataTranslation/MI_PriorityCode_highImportance"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mediumImportance' or text()='mediumImportance'">
        <xsl:value-of select="$metadataTranslation/MI_PriorityCode_mediumImportance"/>
      </xsl:when>
      <xsl:when test="@codeListValue='lowImportance' or text()='lowImportance'">
        <xsl:value-of select="$metadataTranslation/MI_PriorityCode_lowImportance"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_SequenceCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='start' or text()='start'">
        <xsl:value-of select="$metadataTranslation/MI_SequenceCode_start"/>
      </xsl:when>
      <xsl:when test="@codeListValue='end' or text()='end'">
        <xsl:value-of select="$metadataTranslation/MI_SequenceCode_end"/>
      </xsl:when>
      <xsl:when test="@codeListValue='instantaneous' or text()='instantaneous'">
        <xsl:value-of select="$metadataTranslation/MI_SequenceCode_instantaneous"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_TriggerCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='automatic' or text()='automatic'">
        <xsl:value-of select="$metadataTranslation/MI_TriggerCode_automatic"/>
      </xsl:when>
      <xsl:when test="@codeListValue='manual' or text()='manual'">
        <xsl:value-of select="$metadataTranslation/MI_TriggerCode_manual"/>
      </xsl:when>
      <xsl:when test="@codeListValue='preProgrammed' or text()='preProgrammed'">
        <xsl:value-of select="$metadataTranslation/MI_TriggerCode_preProgrammed"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_SensorTypeCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ProgressCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='completed' or text()='completed'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_completed"/>
      </xsl:when>
      <xsl:when test="@codeListValue='historicalArchive' or text()='historicalArchive'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_historicalArchive"/>
      </xsl:when>
      <xsl:when test="@codeListValue='obsolete' or text()='obsolete'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_obsolete"/>
      </xsl:when>
      <xsl:when test="@codeListValue='onGoing' or text()='onGoing'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_onGoing"/>
      </xsl:when>
      <xsl:when test="@codeListValue='planned' or text()='planned'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_planned"/>
      </xsl:when>
      <xsl:when test="@codeListValue='required' or text()='required'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_required"/>
      </xsl:when>
      <xsl:when test="@codeListValue='underDevelopment' or text()='underDevelopment'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_underDevelopment"/>
      </xsl:when>
      <xsl:when test="@codeListValue='final' or text()='final'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_final"/>
      </xsl:when>
      <xsl:when test="@codeListValue='pending' or text()='pending'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_pending"/>
      </xsl:when>
      <xsl:when test="@codeListValue='retired' or text()='retired'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_retired"/>
      </xsl:when>
      <xsl:when test="@codeListValue='superseded' or text()='superseded'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_superseded"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tentative' or text()='tentative'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_tentative"/>
      </xsl:when>
      <xsl:when test="@codeListValue='valid' or text()='valid'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_valid"/>
      </xsl:when>
      <xsl:when test="@codeListValue='accepted' or text()='accepted'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_accepted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='notAccepted' or text()='notAccepted'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_notAccepted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='withdrawn' or text()='withdrawn'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_withdrawn"/>
      </xsl:when>
      <xsl:when test="@codeListValue='proposed' or text()='proposed'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_proposed"/>
      </xsl:when>
      <xsl:when test="@codeListValue='deprecated' or text()='deprecated'">
        <xsl:value-of select="$metadataTranslation/MD_ProgressCode_deprecated"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ScopeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='attribute' or text()='attribute'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attribute"/>
      </xsl:when>
      <xsl:when test="@codeListValue='attributeType' or text()='attributeType'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_attributeType"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collectionHardware' or text()='collectionHardware'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionHardware"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collectionSession' or text()='collectionSession'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collectionSession"/>
      </xsl:when>
      <xsl:when test="@codeListValue='dataset' or text()='dataset'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dataset"/>
      </xsl:when>
      <xsl:when test="@codeListValue='series' or text()='series'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_series"/>
      </xsl:when>
      <xsl:when test="@codeListValue='nonGeographicDataset' or text()='nonGeographicDataset'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_nonGeographicDataset"/>
      </xsl:when>
      <xsl:when test="@codeListValue='dimensionGroup' or text()='dimensionGroup'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_dimensionGroup"/>
      </xsl:when>
      <xsl:when test="@codeListValue='feature' or text()='feature'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_feature"/>
      </xsl:when>
      <xsl:when test="@codeListValue='featureType' or text()='featureType'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_featureType"/>
      </xsl:when>
      <xsl:when test="@codeListValue='propertyType' or text()='propertyType'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_propertyType"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fieldSession' or text()='fieldSession'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_fieldSession"/>
      </xsl:when>
      <xsl:when test="@codeListValue='software' or text()='software'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_software"/>
      </xsl:when>
      <xsl:when test="@codeListValue='service' or text()='service'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_service"/>
      </xsl:when>
      <xsl:when test="@codeListValue='model' or text()='model'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_model"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tile' or text()='tile'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_tile"/>
      </xsl:when>
      <xsl:when test="@codeListValue='metadata' or text()='metadata'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_metadata"/>
      </xsl:when>
      <xsl:when test="@codeListValue='initiative' or text()='initiative'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_initiative"/>
      </xsl:when>
      <xsl:when test="@codeListValue='sample' or text()='sample'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_sample"/>
      </xsl:when>
      <xsl:when test="@codeListValue='document' or text()='document'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_document"/>
      </xsl:when>
      <xsl:when test="@codeListValue='repository' or text()='repository'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_repository"/>
      </xsl:when>
      <xsl:when test="@codeListValue='aggregate' or text()='aggregate'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_aggregate"/>
      </xsl:when>
      <xsl:when test="@codeListValue='product' or text()='product'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_product"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collection' or text()='collection'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_collection"/>
      </xsl:when>
      <xsl:when test="@codeListValue='coverage' or text()='coverage'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_coverage"/>
      </xsl:when>
      <xsl:when test="@codeListValue='application' or text()='application'">
        <xsl:value-of select="$metadataTranslation/MD_ScopeCode_application"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_SpatialRepresentationTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='vector' or text()='vector'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_vector"/>
      </xsl:when>
      <xsl:when test="@codeListValue='grid' or text()='grid'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_grid"/>
      </xsl:when>
      <xsl:when test="@codeListValue='textTable' or text()='textTable'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_textTable"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tin' or text()='tin'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_tin"/>
      </xsl:when>
      <xsl:when test="@codeListValue='stereoModel' or text()='stereoModel'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_stereoModel"/>
      </xsl:when>
      <xsl:when test="@codeListValue='video' or text()='video'">
        <xsl:value-of select="$metadataTranslation/MD_SpatialRepresentationTypeCode_video"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ClassificationCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='unclassified' or text()='unclassified'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_unclassified"/>
      </xsl:when>
      <xsl:when test="@codeListValue='restricted' or text()='restricted'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_restricted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='confidential' or text()='confidential'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_confidential"/>
      </xsl:when>
      <xsl:when test="@codeListValue='secret' or text()='secret'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_secret"/>
      </xsl:when>
      <xsl:when test="@codeListValue='topSecret' or text()='topSecret'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_topSecret"/>
      </xsl:when>
      <xsl:when test="@codeListValue='SBU' or text()='SBU'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_SBU"/>
      </xsl:when>
      <xsl:when test="@codeListValue='forOfficialUseOnly' or text()='forOfficialUseOnly'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_forOfficialUseOnly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='protected' or text()='protected'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_protected"/>
      </xsl:when>
      <xsl:when test="@codeListValue='limitedDistribution' or text()='limitedDistribution'">
        <xsl:value-of select="$metadataTranslation/MD_ClassificationCode_limitedDistribution"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_RestrictionCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='copyright' or text()='copyright'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_copyright"/>
      </xsl:when>
      <xsl:when test="@codeListValue='patent' or text()='patent'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patent"/>
      </xsl:when>
      <xsl:when test="@codeListValue='patentPending' or text()='patentPending'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_patentPending"/>
      </xsl:when>
      <xsl:when test="@codeListValue='trademark' or text()='trademark'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_trademark"/>
      </xsl:when>
      <xsl:when test="@codeListValue='licence' or text()='licence'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_licence"/>
      </xsl:when>
      <xsl:when test="@codeListValue='intellectualPropertyRights' or text()='intellectualPropertyRights'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_intellectualPropertyRights"/>
      </xsl:when>
      <xsl:when test="@codeListValue='restricted' or text()='restricted'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_restricted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='otherRestrictions' or text()='otherRestrictions'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_otherRestrictions"/>
      </xsl:when>
      <xsl:when test="@codeListValue='unrestricted' or text()='unrestricted'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_unrestricted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='licenceUnrestricted' or text()='licenceUnrestricted'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_licenceUnrestricted"/>
      </xsl:when>
      <xsl:when test="@codeListValue='licenceEndUser' or text()='licenceEndUser'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_licenceEndUser"/>
      </xsl:when>
      <xsl:when test="@codeListValue='licenceDistributor' or text()='licenceDistributor'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_licenceDistributor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='private' or text()='private'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_private"/>
      </xsl:when>
      <xsl:when test="@codeListValue='statutory' or text()='statutory'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_statutory"/>
      </xsl:when>
      <xsl:when test="@codeListValue='confidential' or text()='confidential'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_confidential"/>
      </xsl:when>
      <xsl:when test="@codeListValue='SBU' or text()='SBU'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_SBU"/>
      </xsl:when>
      <xsl:when test="@codeListValue='in-confidence' or text()='in-confidence'">
        <xsl:value-of select="$metadataTranslation/MD_RestrictionCode_in-confidence"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_DatatypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='class' or text()='class'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_class"/>
      </xsl:when>
      <xsl:when test="@codeListValue='codelist' or text()='codelist'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_codelist"/>
      </xsl:when>
      <xsl:when test="@codeListValue='enumeration' or text()='enumeration'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_enumeration"/>
      </xsl:when>
      <xsl:when test="@codeListValue='codelistElement' or text()='codelistElement'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_codelistElement"/>
      </xsl:when>
      <xsl:when test="@codeListValue='abstractClass' or text()='abstractClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_abstractClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='aggregateClass' or text()='aggregateClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_aggregateClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='specifiedClass' or text()='specifiedClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_specifiedClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='datatypeClass' or text()='datatypeClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_datatypeClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='interfaceClass' or text()='interfaceClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_interfaceClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='unionClass' or text()='unionClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_unionClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='metaClass' or text()='metaClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_metaClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='typeClass' or text()='typeClass'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_typeClass"/>
      </xsl:when>
      <xsl:when test="@codeListValue='characterString' or text()='characterString'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_characterString"/>
      </xsl:when>
      <xsl:when test="@codeListValue='integer' or text()='integer'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_integer"/>
      </xsl:when>
      <xsl:when test="@codeListValue='association' or text()='association'">
        <xsl:value-of select="$metadataTranslation/MD_DatatypeCode_association"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ObligationCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='mandatory' or text()='mandatory'">
        <xsl:value-of select="$metadataTranslation/MD_ObligationCode_mandatory"/>
      </xsl:when>
      <xsl:when test="@codeListValue='optional' or text()='optional'">
        <xsl:value-of select="$metadataTranslation/MD_ObligationCode_optional"/>
      </xsl:when>
      <xsl:when test="@codeListValue='conditional' or text()='conditional'">
        <xsl:value-of select="$metadataTranslation/MD_ObligationCode_conditional"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_MaintenanceFrequencyCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='continual' or text()='continual'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_continual"/>
      </xsl:when>
      <xsl:when test="@codeListValue='daily' or text()='daily'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_daily"/>
      </xsl:when>
      <xsl:when test="@codeListValue='weekly' or text()='weekly'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_weekly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fortnightly' or text()='fortnightly'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_fortnightly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='monthly' or text()='monthly'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_monthly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='quarterly' or text()='quarterly'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_quarterly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='biannually' or text()='biannually'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_biannually"/>
      </xsl:when>
      <xsl:when test="@codeListValue='annually' or text()='annually'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_annually"/>
      </xsl:when>
      <xsl:when test="@codeListValue='asNeeded' or text()='asNeeded'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_asNeeded"/>
      </xsl:when>
      <xsl:when test="@codeListValue='irregular' or text()='irregular'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_irregular"/>
      </xsl:when>
      <xsl:when test="@codeListValue='notPlanned' or text()='notPlanned'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_notPlanned"/>
      </xsl:when>
      <xsl:when test="@codeListValue='unknown' or text()='unknown'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_unknown"/>
      </xsl:when>
      <xsl:when test="@codeListValue='periodic' or text()='periodic'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_periodic"/>
      </xsl:when>
      <xsl:when test="@codeListValue='semimonthly' or text()='semimonthly'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_semimonthly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='biennially' or text()='biennially'">
        <xsl:value-of select="$metadataTranslation/MD_MaintenanceFrequencyCode_biennially"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_CoverageContentTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='image' or text()='image'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_image"/>
      </xsl:when>
      <xsl:when test="@codeListValue='thematicClassification' or text()='thematicClassification'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_thematicClassification"/>
      </xsl:when>
      <xsl:when test="@codeListValue='physicalMeasurement' or text()='physicalMeasurement'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_physicalMeasurement"/>
      </xsl:when>
      <xsl:when test="@codeListValue='auxillaryInformation' or text()='auxillaryInformation'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_auxillaryInformation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='qualityInformation' or text()='qualityInformation'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_qualityInformation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='coordinate' or text()='coordinate'">
        <xsl:value-of select="$metadataTranslation/MD_CoverageContentTypeCode_coordinate"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ImagingConditionCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='blurredImage' or text()='blurredImage'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_blurredImage"/>
      </xsl:when>
      <xsl:when test="@codeListValue='cloud' or text()='cloud'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_cloud"/>
      </xsl:when>
      <xsl:when test="@codeListValue='degradingObliquity' or text()='degradingObliquity'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_degradingObliquity"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fog' or text()='fog'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_fog"/>
      </xsl:when>
      <xsl:when test="@codeListValue='heavySmokeOrDust' or text()='heavySmokeOrDust'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_heavySmokeOrDust"/>
      </xsl:when>
      <xsl:when test="@codeListValue='night' or text()='night'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_night"/>
      </xsl:when>
      <xsl:when test="@codeListValue='rain' or text()='rain'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_rain"/>
      </xsl:when>
      <xsl:when test="@codeListValue='semiDarkness' or text()='semiDarkness'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_semiDarkness"/>
      </xsl:when>
      <xsl:when test="@codeListValue='shadow' or text()='shadow'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_shadow"/>
      </xsl:when>
      <xsl:when test="@codeListValue='snow' or text()='snow'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_snow"/>
      </xsl:when>
      <xsl:when test="@codeListValue='terrainMasking' or text()='terrainMasking'">
        <xsl:value-of select="$metadataTranslation/MD_ImagingConditionCode_terrainMasking"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_BandDefinition']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_PolarisationOrientationCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MI_TransferFunctionTypeCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_MediumFormatCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='cpio' or text()='cpio'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_cpio"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tar' or text()='tar'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_tar"/>
      </xsl:when>
      <xsl:when test="@codeListValue='highSierra' or text()='highSierra'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_highSierra"/>
      </xsl:when>
      <xsl:when test="@codeListValue='iso9660' or text()='iso9660'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_iso9660"/>
      </xsl:when>
      <xsl:when test="@codeListValue='iso9660RockRidge' or text()='iso9660RockRidge'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_iso9660RockRidge"/>
      </xsl:when>
      <xsl:when test="@codeListValue='iso9660AppleHFS' or text()='iso9660AppleHFS'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_iso9660AppleHFS"/>
      </xsl:when>
      <xsl:when test="@codeListValue='udf' or text()='udf'">
        <xsl:value-of select="$metadataTranslation/MD_MediumFormatCode_udf"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_MediumNameCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='cdRom' or text()='cdRom'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_cdRom"/>
      </xsl:when>
      <xsl:when test="@codeListValue='dvdRom' or text()='dvdRom'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_dvdRom"/>
      </xsl:when>
      <xsl:when test="@codeListValue='3halfInchFloppy' or text()='3halfInchFloppy'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_3halfInchFloppy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='5quarterInchFloppy' or text()='5quarterInchFloppy'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_5quarterInchFloppy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='7trackTape' or text()='7trackTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_7trackTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='9trackTape' or text()='9trackTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_9trackTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='3480Cartridge' or text()='3480Cartridge'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_3480Cartridge"/>
      </xsl:when>
      <xsl:when test="@codeListValue='3490Cartridge' or text()='3490Cartridge'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_3490Cartridge"/>
      </xsl:when>
      <xsl:when test="@codeListValue='3580Cartridge' or text()='3580Cartridge'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_3580Cartridge"/>
      </xsl:when>
      <xsl:when test="@codeListValue='4mmCartridgeTape' or text()='4mmCartridgeTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_4mmCartridgeTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='8mmCartridgeTape' or text()='8mmCartridgeTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_8mmCartridgeTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='1quarterInchCartridgeTape' or text()='1quarterInchCartridgeTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_1quarterInchCartridgeTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='digitalLinearTape' or text()='digitalLinearTape'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_digitalLinearTape"/>
      </xsl:when>
      <xsl:when test="@codeListValue='onLine' or text()='onLine'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_onLine"/>
      </xsl:when>
      <xsl:when test="@codeListValue='telephoneLink' or text()='telephoneLink'">
        <xsl:value-of select="$metadataTranslation/MD_MediumNameCode_telephoneLink"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='DS_AssociationTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='crossReference' or text()='crossReference'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_crossReference"/>
      </xsl:when>
      <xsl:when test="@codeListValue='largerWorkCitation' or text()='largerWorkCitation'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_largerWorkCitation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='partOfSeamlessDatabase' or text()='partOfSeamlessDatabase'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_partOfSeamlessDatabase"/>
      </xsl:when>
      <xsl:when test="@codeListValue='stereoMate' or text()='stereoMate'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_stereoMate"/>
      </xsl:when>
      <xsl:when test="@codeListValue='isComposedOf' or text()='isComposedOf'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_isComposedOf"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collectiveTitle' or text()='collectiveTitle'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_collectiveTitle"/>
      </xsl:when>
      <xsl:when test="@codeListValue='series' or text()='series'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_series"/>
      </xsl:when>
      <xsl:when test="@codeListValue='dependency' or text()='dependency'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_dependency"/>
      </xsl:when>
      <xsl:when test="@codeListValue='revisionOf' or text()='revisionOf'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_revisionOf"/>
      </xsl:when>
      <xsl:when test="@codeListValue='source' or text()='source'">
        <xsl:value-of select="$metadataTranslation/DS_AssociationTypeCode_source"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='DS_InitiativeTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='campaign' or text()='campaign'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_campaign"/>
      </xsl:when>
      <xsl:when test="@codeListValue='collection' or text()='collection'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_collection"/>
      </xsl:when>
      <xsl:when test="@codeListValue='exercise' or text()='exercise'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_exercise"/>
      </xsl:when>
      <xsl:when test="@codeListValue='experiment' or text()='experiment'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_experiment"/>
      </xsl:when>
      <xsl:when test="@codeListValue='investigation' or text()='investigation'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_investigation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mission' or text()='mission'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_mission"/>
      </xsl:when>
      <xsl:when test="@codeListValue='sensor' or text()='sensor'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_sensor"/>
      </xsl:when>
      <xsl:when test="@codeListValue='operation' or text()='operation'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_operation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='platform' or text()='platform'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_platform"/>
      </xsl:when>
      <xsl:when test="@codeListValue='process' or text()='process'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_process"/>
      </xsl:when>
      <xsl:when test="@codeListValue='program' or text()='program'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_program"/>
      </xsl:when>
      <xsl:when test="@codeListValue='project' or text()='project'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_project"/>
      </xsl:when>
      <xsl:when test="@codeListValue='study' or text()='study'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_study"/>
      </xsl:when>
      <xsl:when test="@codeListValue='task' or text()='task'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_task"/>
      </xsl:when>
      <xsl:when test="@codeListValue='trial' or text()='trial'">
        <xsl:value-of select="$metadataTranslation/DS_InitiativeTypeCode_trial"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_KeywordTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='discipline' or text()='discipline'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_discipline"/>
      </xsl:when>
      <xsl:when test="@codeListValue='place' or text()='place'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_place"/>
      </xsl:when>
      <xsl:when test="@codeListValue='stratum' or text()='stratum'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_stratum"/>
      </xsl:when>
      <xsl:when test="@codeListValue='temporal' or text()='temporal'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_temporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='theme' or text()='theme'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_theme"/>
      </xsl:when>
      <xsl:when test="@codeListValue='dataCentre' or text()='dataCentre'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_dataCentre"/>
      </xsl:when>
      <xsl:when test="@codeListValue='featureType' or text()='featureType'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_featureType"/>
      </xsl:when>
      <xsl:when test="@codeListValue='instrument' or text()='instrument'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_instrument"/>
      </xsl:when>
      <xsl:when test="@codeListValue='platform' or text()='platform'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_platform"/>
      </xsl:when>
      <xsl:when test="@codeListValue='process' or text()='process'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_process"/>
      </xsl:when>
      <xsl:when test="@codeListValue='project' or text()='project'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_project"/>
      </xsl:when>
      <xsl:when test="@codeListValue='service' or text()='service'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_service"/>
      </xsl:when>
      <xsl:when test="@codeListValue='product' or text()='product'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_product"/>
      </xsl:when>
      <xsl:when test="@codeListValue='subTopicCategory' or text()='subTopicCategory'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_subTopicCategory"/>
      </xsl:when>
      <xsl:when test="@codeListValue='taxon' or text()='taxon'">
        <xsl:value-of select="$metadataTranslation/MD_KeywordTypeCode_taxon"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_TopicCategoryCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='farming' or text()='farming'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_farming"/>
      </xsl:when>
      <xsl:when test="@codeListValue='biota' or text()='biota'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_biota"/>
      </xsl:when>
      <xsl:when test="@codeListValue='boundaries' or text()='boundaries'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_boundaries"/>
      </xsl:when>
      <xsl:when test="@codeListValue='climatologyMeteorologyAtmosphere' or text()='climatologyMeteorologyAtmosphere'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_climatologyMeteorologyAtmosphere"/>
      </xsl:when>
      <xsl:when test="@codeListValue='economy' or text()='economy'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_economy"/>
      </xsl:when>
      <xsl:when test="@codeListValue='elevation' or text()='elevation'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_elevation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='environment' or text()='environment'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_environment"/>
      </xsl:when>
      <xsl:when test="@codeListValue='geoscientificInformation' or text()='geoscientificInformation'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_geoscientificInformation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='health' or text()='health'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_health"/>
      </xsl:when>
      <xsl:when test="@codeListValue='imageryBaseMapsEarthCover' or text()='imageryBaseMapsEarthCover'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_imageryBaseMapsEarthCover"/>
      </xsl:when>
      <xsl:when test="@codeListValue='intelligenceMilitary' or text()='intelligenceMilitary'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_intelligenceMilitary"/>
      </xsl:when>
      <xsl:when test="@codeListValue='inlandWaters' or text()='inlandWaters'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_inlandWaters"/>
      </xsl:when>
      <xsl:when test="@codeListValue='location' or text()='location'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_location"/>
      </xsl:when>
      <xsl:when test="@codeListValue='oceans' or text()='oceans'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_oceans"/>
      </xsl:when>
      <xsl:when test="@codeListValue='planningCadastre' or text()='planningCadastre'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_planningCadastre"/>
      </xsl:when>
      <xsl:when test="@codeListValue='society' or text()='society'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_society"/>
      </xsl:when>
      <xsl:when test="@codeListValue='structure' or text()='structure'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_structure"/>
      </xsl:when>
      <xsl:when test="@codeListValue='transportation' or text()='transportation'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_transportation"/>
      </xsl:when>
      <xsl:when test="@codeListValue='utilitiesCommunication' or text()='utilitiesCommunication'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_utilitiesCommunication"/>
      </xsl:when>
      <xsl:when test="@codeListValue='extraTerrestrial' or text()='extraTerrestrial'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_extraTerrestrial"/>
      </xsl:when>
      <xsl:when test="@codeListValue='disaster' or text()='disaster'">
        <xsl:value-of select="$metadataTranslation/MD_TopicCategoryCode_disaster"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_ReferenceSystemTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='compoundEngineeringParametric' or text()='compoundEngineeringParametric'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundEngineeringParametric"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundEngineeringParametricTemporal' or text()='compoundEngineeringParametricTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundEngineeringParametricTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundEngineeringTemporal' or text()='compoundEngineeringTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundEngineeringTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundEngineeringVertical' or text()='compoundEngineeringVertical'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundEngineeringVertical"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundEngineeringVerticalTemporal' or text()='compoundEngineeringVerticalTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundEngineeringVerticalTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeodeticParametric' or text()='compoundGeodeticParametric'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeodeticParametric"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeodeticParametricTemporal' or text()='compoundGeodeticParametricTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeodeticParametricTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeographic2DTemporal' or text()='compoundGeographic2DTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeographic2DTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeographic2DVertical' or text()='compoundGeographic2DVertical'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeographic2DVertical"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeographicVerticalTemporal' or text()='compoundGeographicVerticalTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeographicVerticalTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundGeographic3DTemporal' or text()='compoundGeographic3DTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundGeographic3DTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundProjected2DParametric' or text()='compoundProjected2DParametric'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundProjected2DParametric"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundProjected2DParametricTemporal' or text()='compoundProjected2DParametricTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundProjected2DParametricTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundProjectedTemporal' or text()='compoundProjectedTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundProjectedTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundProjectedVertical' or text()='compoundProjectedVertical'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundProjectedVertical"/>
      </xsl:when>
      <xsl:when test="@codeListValue='compoundProjectedVerticalTemporal' or text()='compoundProjectedVerticalTemporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_compoundProjectedVerticalTemporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='engineering' or text()='engineering'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_engineering"/>
      </xsl:when>
      <xsl:when test="@codeListValue='engineeringDesign' or text()='engineeringDesign'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_engineeringDesign"/>
      </xsl:when>
      <xsl:when test="@codeListValue='engineeringImage' or text()='engineeringImage'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_engineeringImage"/>
      </xsl:when>
      <xsl:when test="@codeListValue='geodeticGeocentric' or text()='geodeticGeocentric'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_geodeticGeocentric"/>
      </xsl:when>
      <xsl:when test="@codeListValue='geodeticGeographic2D' or text()='geodeticGeographic2D'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_geodeticGeographic2D"/>
      </xsl:when>
      <xsl:when test="@codeListValue='geodeticGeographic3D' or text()='geodeticGeographic3D'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_geodeticGeographic3D"/>
      </xsl:when>
      <xsl:when test="@codeListValue='geographicIdentifier' or text()='geographicIdentifier'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_geographicIdentifier"/>
      </xsl:when>
      <xsl:when test="@codeListValue='linear' or text()='linear'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_linear"/>
      </xsl:when>
      <xsl:when test="@codeListValue='parametric' or text()='parametric'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_parametric"/>
      </xsl:when>
      <xsl:when test="@codeListValue='projected' or text()='projected'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_projected"/>
      </xsl:when>
      <xsl:when test="@codeListValue='temporal' or text()='temporal'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_temporal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='vertical' or text()='vertical'">
        <xsl:value-of select="$metadataTranslation/MD_ReferenceSystemTypeCode_vertical"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_CellGeometryCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='point' or text()='point'">
        <xsl:value-of select="$metadataTranslation/MD_CellGeometryCode_point"/>
      </xsl:when>
      <xsl:when test="@codeListValue='area' or text()='area'">
        <xsl:value-of select="$metadataTranslation/MD_CellGeometryCode_area"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_DimensionNameTypeCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_GeometricObjectTypeCode']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_PixelOrientationCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='centre' or text()='centre'">
        <xsl:value-of select="$metadataTranslation/MD_PixelOrientationCode_centre"/>
      </xsl:when>
      <xsl:when test="@codeListValue='lowerLeft' or text()='lowerLeft'">
        <xsl:value-of select="$metadataTranslation/MD_PixelOrientationCode_lowerLeft"/>
      </xsl:when>
      <xsl:when test="@codeListValue='lowerRight' or text()='lowerRight'">
        <xsl:value-of select="$metadataTranslation/MD_PixelOrientationCode_lowerRight"/>
      </xsl:when>
      <xsl:when test="@codeListValue='upperRight' or text()='upperRight'">
        <xsl:value-of select="$metadataTranslation/MD_PixelOrientationCode_upperRight"/>
      </xsl:when>
      <xsl:when test="@codeListValue='upperLeft' or text()='upperLeft'">
        <xsl:value-of select="$metadataTranslation/MD_PixelOrientationCode_upperLeft"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='MD_TopologyLevelCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='geometryOnly' or text()='geometryOnly'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_geometryOnly"/>
      </xsl:when>
      <xsl:when test="@codeListValue='topology1D' or text()='topology1D'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_topology1D"/>
      </xsl:when>
      <xsl:when test="@codeListValue='planarGraph' or text()='planarGraph'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_planarGraph"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fullPlanarGraph' or text()='fullPlanarGraph'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_fullPlanarGraph"/>
      </xsl:when>
      <xsl:when test="@codeListValue='surfaceGraph' or text()='surfaceGraph'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_surfaceGraph"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fullSurfaceGraph' or text()='fullSurfaceGraph'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_fullSurfaceGraph"/>
      </xsl:when>
      <xsl:when test="@codeListValue='topology3D' or text()='topology3D'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_topology3D"/>
      </xsl:when>
      <xsl:when test="@codeListValue='fullTopology3D' or text()='fullTopology3D'">
        <xsl:value-of select="$metadataTranslation/MD_TopologyLevelCode_fullTopology3D"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='SV_CouplingType']">
    <xsl:choose>
      <xsl:when test="@codeListValue='loose' or text()='loose'">
        <xsl:value-of select="$metadataTranslation/SV_CouplingType_loose"/>
      </xsl:when>
      <xsl:when test="@codeListValue='mixed' or text()='mixed'">
        <xsl:value-of select="$metadataTranslation/SV_CouplingType_mixed"/>
      </xsl:when>
      <xsl:when test="@codeListValue='tight' or text()='tight'">
        <xsl:value-of select="$metadataTranslation/SV_CouplingType_tight"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='SV_ParameterDirection']">
    <xsl:choose>
      <xsl:when test="@codeListValue='in' or text()='in'">
        <xsl:value-of select="$metadataTranslation/SV_ParameterDirection_in"/>
      </xsl:when>
      <xsl:when test="@codeListValue='out' or text()='out'">
        <xsl:value-of select="$metadataTranslation/SV_ParameterDirection_out"/>
      </xsl:when>
      <xsl:when test="@codeListValue='inout' or text()='inout'">
        <xsl:value-of select="$metadataTranslation/SV_ParameterDirection_inout"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*[local-name()='DCPList']">
    <xsl:value-of select="@codeListValue"></xsl:value-of>
  </xsl:template>
  <xsl:template match="*[local-name()='DQ_EvaluationMethodTypeCode']">
    <xsl:choose>
      <xsl:when test="@codeListValue='directInternal' or text()='directInternal'">
        <xsl:value-of select="$metadataTranslation/DQ_EvaluationMethodTypeCode_directInternal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='directExternal' or text()='directExternal'">
        <xsl:value-of select="$metadataTranslation/DQ_EvaluationMethodTypeCode_directExternal"/>
      </xsl:when>
      <xsl:when test="@codeListValue='indirect' or text()='indirect'">
        <xsl:value-of select="$metadataTranslation/DQ_EvaluationMethodTypeCode_indirect"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="@codeListValue"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- DEFINE SUBSECTIONS -->
  <xsl:template match="*[local-name()='accessProperties']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AccessProperties"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="*[local-name()='processingLevel']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ProcessingLevel"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='accuracyReport']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_AccuracyOfATimeMeasurement']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_AccuracyOfATimeMeasurement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DomainConsistency']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_DomainConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalConsistency']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_TemporalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TopologicalConsistency']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_TopologicalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ThematicClassificationCorrectness']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_ThematicClassificationCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeCorrectness']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_NonQuantitativeAttributeCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_AbsoluteExternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_AbsoluteExternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ConceptualConsistency']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_ConceptualConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_QuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_QuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessOmission']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_CompletenessOmission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_FormatConsistency']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_FormatConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalValidity']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_TemporalValidity"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_RelativeInternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_RelativeInternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessCommission']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_CompletenessCommission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_GriddedDataPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_GriddedDataPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='LE_ProcessStepReport']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_ProcessStepReport"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_UsabilityElement']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_UsabilityElement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_NonQuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='QE_Usability']">
            <xsl:value-of select="$metadataTranslation/AccuracyReport_Usability"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/AccuracyReport"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='acquisitionInformation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AcquisitionInformation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='acquisitionPlan']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AcquisitionPlan"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='acquisitionRequirement']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AcquisitionRequirement"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='additionalDocumentation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AdditionalDocumentation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='address']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Address"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='addressee']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Addressee"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='aggregateDataSetIdentifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AggregateDataSetIdentifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='aggregateDataSetName']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AggregateDataSetName"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='aggregationInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AggregationInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='algorithm']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Algorithm"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='alternativeMetadataReference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AlternativeMetadataReference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='applicationSchemaInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ApplicationSchemaInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='associatedResource']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AssociatedResource"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='attribute']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_RangeDimension']">
            <xsl:value-of select="$metadataTranslation/RangeDimension"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MI_Band']">
            <xsl:value-of select="$metadataTranslation/Band"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_Band']">
            <xsl:value-of select="$metadataTranslation/Band"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_SampleDimension']">
            <xsl:value-of select="$metadataTranslation/SampleDimension"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/Attribute"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='attributeGroup']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AttributeGroup"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='authority']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Authority"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='axisDimensionProperties']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/AxisDimensionProperties"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='begin']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Begin"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='boundUnits']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/BoundUnits"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='centerPoint']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CenterPoint"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='checkPoint']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CheckPoint"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='childOperation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ChildOperation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='citation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Citation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='citedResponsibleParty']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CitedResponsibleParty"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='composedOf']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ComposedOf"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='conceptIdentifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ConceptIdentifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='connectPoint']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ConnectPoint"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='constraintApplicationScope']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ConstraintApplicationScope"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='contact']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Contact"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='contactInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ContactInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='containsChain']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ContainsChain"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='containsOperations']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ContainsOperations"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='contentInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MI_CoverageDescription']">
            <xsl:value-of select="$metadataTranslation/CoverageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_CoverageDescription']">
            <xsl:value-of select="$metadataTranslation/CoverageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MI_ImageDescription']">
            <xsl:value-of select="$metadataTranslation/ImageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_ImageDescription']">
            <xsl:value-of select="$metadataTranslation/ImageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_FeatureCatalogueDescription']">
            <xsl:value-of select="$metadataTranslation/FeatureCatalogueDescription"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/ContentInfo"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='coordinateReferenceSystem']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CoordinateReferenceSystem"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='cornerPoints']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CornerPoints"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='coupledResource']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/CoupledResource"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='dataQualityInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DataQualityInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='dateInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DateInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='defaultLocale']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DefaultLocale"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='dependsOn']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DependsOn"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='derivedElement']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_AccuracyOfATimeMeasurement']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_AccuracyOfATimeMeasurement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DomainConsistency']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_DomainConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalConsistency']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_TemporalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TopologicalConsistency']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_TopologicalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ThematicClassificationCorrectness']">
            <xsl:value-of select="$metadataTranslation/Report_ThematicClassificationCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeCorrectness']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_NonQuantitativeAttributeCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_AbsoluteExternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_AbsoluteExternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ConceptualConsistency']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_ConceptualConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_QuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_QuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessOmission']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_CompletenessOmission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_FormatConsistency']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_FormatConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalValidity']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_TemporalValidity"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_RelativeInternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_RelativeInternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessCommission']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_CompletenessCommission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_GriddedDataPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_GriddedDataPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='LE_ProcessStepReport']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_ProcessStepReport"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_UsabilityElement']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_UsabilityElement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_NonQuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='QE_Usability']">
            <xsl:value-of select="$metadataTranslation/DerivedElement_Usability"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/DerivedElement"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='describes']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Describes"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='descriptiveKeywords']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DescriptiveKeywords"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='dimension']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_RangeDimension']">
            <xsl:value-of select="$metadataTranslation/RangeDimension"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MI_Band']">
            <xsl:value-of select="$metadataTranslation/Band"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_Band']">
            <xsl:value-of select="$metadataTranslation/Band"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_SampleDimension']">
            <xsl:value-of select="$metadataTranslation/SampleDimension"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/Dimension"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributionFormat']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributionFormat"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributionInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributionInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributionOrderProcess']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributionOrderProcess"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Distributor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributorContact']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributorContact"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributorFormat']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributorFormat"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='distributorTransferOptions']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DistributorTransferOptions"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='documentation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Documentation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='domainOfValidity']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/DomainOfValidity"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='elementReport']">

    <div class="subSection">
      <div class="subSectionHeader">

        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_AccuracyOfATimeMeasurement']">
            <xsl:value-of select="$metadataTranslation/Report_AccuracyOfATimeMeasurement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DomainConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_DomainConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_TemporalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TopologicalConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_TopologicalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ThematicClassificationCorrectness']">
            <xsl:value-of select="$metadataTranslation/Report_ThematicClassificationCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeCorrectness']">
            <xsl:value-of select="$metadataTranslation/Report_NonQuantitativeAttributeCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_AbsoluteExternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_AbsoluteExternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ConceptualConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_ConceptualConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_QuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_QuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessOmission']">
            <xsl:value-of select="$metadataTranslation/Report_CompletenessOmission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_FormatConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_FormatConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalValidity']">
            <xsl:value-of select="$metadataTranslation/Report_TemporalValidity"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_RelativeInternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_RelativeInternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessCommission']">
            <xsl:value-of select="$metadataTranslation/Report_CompletenessCommission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_GriddedDataPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_GriddedDataPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='LE_ProcessStepReport']">
            <xsl:value-of select="$metadataTranslation/Report_ProcessStepReport"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_UsabilityElement']">
            <xsl:value-of select="$metadataTranslation/Report_UsabilityElement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_NonQuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='QE_Usability']">
            <xsl:value-of select="$metadataTranslation/Report_Usability"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/ElementReport"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='end']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/End"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='environmentalConditions']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/EnvironmentalConditions"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='equivalentScale']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/EquivalentScale"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='evaluationMethod']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_IndirectEvaluation']">
            <xsl:value-of select="$metadataTranslation/DQ_IndirectEvaluation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_FullInspection']">
            <xsl:value-of select="$metadataTranslation/DQ_FullInspection"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_AggregationDerivation']">
            <xsl:value-of select="$metadataTranslation/DQ_AggregationDerivation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_SampleBasedInspection']">
            <xsl:value-of select="$metadataTranslation/DQ_SampleBasedInspection"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DataInspection']">
            <xsl:value-of select="$metadataTranslation/DQ_DataInspection"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/EvaluationMethod"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='evaluationProcedure']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/EvaluationProcedure"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='expectedObjective']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ExpectedObjective"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='extendedElementInformation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ExtendedElementInformation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='extensionOnLineResource']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ExtensionOnLineResource"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='extent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Extent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='exterior']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Exterior"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='featureCatalogue']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FeatureCatalogue"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='featureCatalogueCitation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FeatureCatalogueCitation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='featureTypes']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FeatureTypes"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='fileFormat']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FileFormat"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='formatDistributor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FormatDistributor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='formatSpecificationCitation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/FormatSpecificationCitation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='gcp']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Gcp"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geographicCoordinates']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GeographicCoordinates"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geographicElement']">
    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='EX_BoundingPolygon']">
            <xsl:value-of select="$metadataTranslation/BoundingPolygon"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='EX_GeographicDescription']">
            <xsl:value-of select="$metadataTranslation/GeographicDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='EX_GeographicBoundingBox']">
            <xsl:value-of select="$metadataTranslation/GeographicBoundingBox"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/GeographicElement"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geographicIdentifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GeographicIdentifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geolocationIdentification']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GeolocationIdentification"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geolocationInformation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GeolocationInformation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='geometricObjects']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GeometricObjects"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='graphic']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Graphic"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='graphicOverview']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GraphicOverview"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='graphicsFile']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/GraphicsFile"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='has']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Has"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='hierarchyLevel']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/HierarchyLevel"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='identificationInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_DataIdentification']">
            <xsl:value-of select="$metadataTranslation/DataIdentification"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='SV_ServiceIdentification']">
            <xsl:value-of select="$metadataTranslation/ServiceIdentification"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/IdentificationInfo"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='identifiedIssues']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/IdentifiedIssues"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='identifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Identifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='imageConstraints']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_SecurityConstraints']">
            <xsl:value-of select="$metadataTranslation/ImageSecurityConstraints"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_LegalConstraints']">
            <xsl:value-of select="$metadataTranslation/ImageLegalConstraints"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/ImageConstraints"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='imageQualityCode']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ImageQualityCode"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='individual']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Individual"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='instrument']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Instrument"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='interior']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Interior"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='keywordClass']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/KeywordClass"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='levelDescription']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/LevelDescription"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='lineage']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Lineage"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='locale']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Locale"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='localisedString']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/LocalisedString"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='logo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Logo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='maintenanceDate']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MaintenanceDate"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='maintenanceScope']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MaintenanceScope"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='measure']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Measure"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='measureIdentification']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MeasureIdentification"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='medium']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Medium"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataConstraints']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_SecurityConstraints']">
            <xsl:value-of select="$metadataTranslation/MetadataSecurityConstraints"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_LegalConstraints']">
            <xsl:value-of select="$metadataTranslation/MetadataLegalConstraints"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/MetadataConstraints"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataExtensionInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataExtensionInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataIdentifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataIdentifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataLinkage']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataLinkage"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataMaintenance']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataMaintenance"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataProfile']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataProfile"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataReference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataReference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataScope']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataScope"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataStandard']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MetadataStandard"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='mountedOn']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/MountedOn"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='objective']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Objective"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='objectiveOccurrence']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ObjectiveOccurrence"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='offLine']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OffLine"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='onLine']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OnLine"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='onlineResource']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OnlineResource"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='ontology']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Ontology"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='operatedDataset']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OperatedDataset"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='operatesOn']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OperatesOn"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='operation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Operation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='otherLocale']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/OtherLocale"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='output']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Output"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='parameter']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Parameter"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='parameterCitation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ParameterCitation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='parentMetadata']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ParentMetadata"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='parentOperation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ParentOperation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='partOf']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/PartOf"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='party']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='CI_Individual']">
            <xsl:value-of select="$metadataTranslation/Party_Individual"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='CI_Organisation']">
            <xsl:value-of select="$metadataTranslation/Party_Organisation"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/Party"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='patches']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Patches"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='phone']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Phone"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='plan']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Plan"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='platform']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Platform"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='platformParameters']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/PlatformParameters"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='pointOfContact']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/PointOfContact"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='polygon']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Polygon"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='portrayalCatalogueCitation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/PortrayalCatalogueCitation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='portrayalCatalogueInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/PortrayalCatalogueInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='processedLevel']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ProcessedLevel"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='processingInformation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ProcessingInformation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='processingLevelCode']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ProcessingLevelCode"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='processor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Processor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='processStep']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ProcessStep"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='profile']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Profile"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='qualityInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/QualityInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='rangeElementDescription']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RangeElementDescription"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='recipient']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Recipient"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='reference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Reference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='referenceDoc']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ReferenceDoc"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='referenceSystemIdentifier']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ReferenceSystemIdentifier"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='referenceSystemInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ReferenceSystemInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='relatedElement']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RelatedElement"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='relatedEvent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RelatedEvent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='relatedPass']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RelatedPass"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='relatedSensor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RelatedSensor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='releasability']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Releasability"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='report']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_AccuracyOfATimeMeasurement']">
            <xsl:value-of select="$metadataTranslation/Report_AccuracyOfATimeMeasurement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DomainConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_DomainConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_TemporalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TopologicalConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_TopologicalConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ThematicClassificationCorrectness']">
            <xsl:value-of select="$metadataTranslation/Report_ThematicClassificationCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeCorrectness']">
            <xsl:value-of select="$metadataTranslation/Report_NonQuantitativeAttributeCorrectness"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_AbsoluteExternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_AbsoluteExternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_ConceptualConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_ConceptualConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_QuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_QuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessOmission']">
            <xsl:value-of select="$metadataTranslation/Report_CompletenessOmission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_FormatConsistency']">
            <xsl:value-of select="$metadataTranslation/Report_FormatConsistency"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_TemporalValidity']">
            <xsl:value-of select="$metadataTranslation/Report_TemporalValidity"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_RelativeInternalPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_RelativeInternalPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_CompletenessCommission']">
            <xsl:value-of select="$metadataTranslation/Report_CompletenessCommission"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_GriddedDataPositionalAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_GriddedDataPositionalAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='LE_ProcessStepReport']">
            <xsl:value-of select="$metadataTranslation/Report_ProcessStepReport"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_UsabilityElement']">
            <xsl:value-of select="$metadataTranslation/Report_UsabilityElement"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_NonQuantitativeAttributeAccuracy']">
            <xsl:value-of select="$metadataTranslation/Report_NonQuantitativeAttributeAccuracy"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='QE_Usability']">
            <xsl:value-of select="$metadataTranslation/Report_Usability"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/Report"/>
          </xsl:otherwise>
        </xsl:choose>

      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='reportReference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ReportReference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='requestedDate']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/RequestedDate"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='requestor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Requestor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resource']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Resource"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceConstraints']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MD_SecurityConstraints']">
            <xsl:value-of select="$metadataTranslation/ResourceSecurityConstraints"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_LegalConstraints']">
            <xsl:value-of select="$metadataTranslation/ResourceLegalConstraints"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/ResourceConstraints"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceFormat']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResourceFormat"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceLineage']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResourceLineage"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceMaintenance']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResourceMaintenance"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceReference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResourceReference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceSpecificUsage']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResourceSpecificUsage"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='responsibleParty']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResponsibleParty"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='result']">
    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='DQ_ConformanceResult']">
            <xsl:value-of select="$metadataTranslation/ConformanceResult"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DomainConsistency']">
            <xsl:value-of select="$metadataTranslation/DomainConsistencyResult"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_DescriptiveResult']">
            <xsl:value-of select="$metadataTranslation/DescriptiveResult"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='DQ_QuantitativeResult']">
            <xsl:value-of select="$metadataTranslation/QuantitativeResult"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='QE_CoverageResult']">
            <xsl:value-of select="$metadataTranslation/CoverageResult"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/Result"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resultContentDescription']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MI_CoverageDescription']">
            <xsl:value-of select="$metadataTranslation/ResultCoverageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_CoverageDescription']">
            <xsl:value-of select="$metadataTranslation/ResultCoverageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MI_ImageDescription']">
            <xsl:value-of select="$metadataTranslation/ResultImageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_ImageDescription']">
            <xsl:value-of select="$metadataTranslation/ResultImageDescription"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_FeatureCatalogueDescription']">
            <xsl:value-of select="$metadataTranslation/ResultFeatureCatalogueDescription"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/ResultContentDescription"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resultFile']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResultFile"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resultFormat']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResultFormat"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resultScope']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResultScope"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='resultSpatialRepresentation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ResultSpatialRepresentation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='satisfiedPlan']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SatisfiedPlan"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='satisfiedRequirement']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SatisfiedRequirement"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='satisifiedPlan']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SatisifiedPlan"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='scaleDenominator']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ScaleDenominator"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='scope']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Scope"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sensingInstrument']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SensingInstrument"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='series']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Series"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='seriesMetadata']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SeriesMetadata"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='serviceStandard']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ServiceStandard"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='significantEvent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SignificantEvent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='softwareDevelopmentFile']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SoftwareDevelopmentFile"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='softwareReference']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SoftwareReference"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='source']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Source"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceCitation']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceCitation"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceExtent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceExtent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceMetadata']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceMetadata"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceReferenceSystem']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceReferenceSystem"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceSpatialResolution']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceSpatialResolution"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sourceStep']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SourceStep"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='spatialExtent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SpatialExtent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='spatialRepresentationInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='MI_Georeferenceable']">
            <xsl:value-of select="$metadataTranslation/GeoreferenceableSpatialRepresentation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_Georeferenceable']">
            <xsl:value-of select="$metadataTranslation/GeoreferenceableSpatialRepresentation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MI_Georectified']">
            <xsl:value-of select="$metadataTranslation/GeorectifiedSpatialRepresentation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_Georectified']">
            <xsl:value-of select="$metadataTranslation/GeorectifiedSpatialRepresentation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_VectorSpatialRepresentation']">
            <xsl:value-of select="$metadataTranslation/VectorSpatialRepresentation"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='MD_GridSpatialRepresentation']">
            <xsl:value-of select="$metadataTranslation/GridSpatialRepresentation"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/SpatialRepresentationInfo"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='spatialResolution']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/SpatialResolution"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='sponsor']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Sponsor"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='standaloneQualityReport']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/StandaloneQualityReport"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='stepDateTime']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/StepDateTime"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='subset']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Subset"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='superset']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Superset"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='temporalElement']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:choose>
          <xsl:when test="child::node()[local-name()='EX_TemporalExtent']">
            <xsl:value-of select="$metadataTranslation/TemporalExtent"/>
          </xsl:when>
          <xsl:when test="child::node()[local-name()='EX_SpatialTemporalExtent']">
            <xsl:value-of select="$metadataTranslation/SpatialTemporalExtent"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/TemporalElement"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='textGroup']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/TextGroup"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='thesaurusName']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ThesaurusName"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='TimePeriod']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/TimePeriod"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='transferOptions']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/TransferOptions"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='units']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/Units"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='updateScopeDescription']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/UpdateScopeDescription"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='usageDateTime']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/UsageDateTime"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='userContactInfo']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/UserContactInfo"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='valueUnit']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/ValueUnit"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='verticalCRSId']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/VerticalCRSId"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='verticalElement']">

    <div class="subSection">
      <div class="subSectionHeader">

        <xsl:choose>
          <xsl:when test="child::node()[local-name()='EX_VerticalExtent']">
            <xsl:value-of select="$metadataTranslation/VerticalExtent"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$metadataTranslation/VerticalElement"/>
          </xsl:otherwise>
        </xsl:choose>

      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="*[local-name()='verticalExtent']">

    <div class="subSection">
      <div class="subSectionHeader">
        <xsl:value-of select="$metadataTranslation/VerticalExtent"/>
      </div>
      <div class="subSectionBody">
        <xsl:apply-templates></xsl:apply-templates>
      </div>
    </div>
  </xsl:template>


  <!-- DEFINE PROPERTIES -->
  <xsl:template match="*[local-name()='abstract']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Abstract"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='accessConstraints']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AccessConstraints"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='administrativeArea']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AdministrativeArea"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='alternateTitle']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AlternateTitle"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='amendmentNumber']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AmendmentNumber"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='angularDistance']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AngularDistance"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='applicationProfile']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ApplicationProfile"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='associationType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AssociationType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='attributeDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AttributeDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='attributeInstances']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AttributeInstances"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='attributes']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Attributes"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='averageAirTemperature']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/AverageAirTemperature"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='bandBoundaryDefinition']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/BandBoundaryDefinition"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='bitsPerValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/BitsPerValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='boundMax']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/BoundMax"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='boundMin']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/BoundMin"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='cameraCalibrationInformationAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CameraCalibrationInformationAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='catalogSymbol']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CatalogSymbol"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='cellGeometry']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CellGeometry"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='characterEncoding']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CharacterEncoding"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='characterSet']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CharacterSet"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='checkPointAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CheckPointAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='checkPointDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CheckPointDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='city']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/City"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='classification']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Classification"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='classificationSystem']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ClassificationSystem"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='className']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ClassName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='cloudCoverPercentage']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CloudCoverPercentage"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='code']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Code"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='codeSpace']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CodeSpace"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='collectionIdentification']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CollectionIdentification"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='collectionName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CollectionName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='collectiveTitle']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CollectiveTitle"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='complianceCode']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ComplianceCode"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='compressionGenerationQuantity']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CompressionGenerationQuantity"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='conceptName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ConceptName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='condition']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Condition"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='constraintLanguage']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ConstraintLanguage"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='contactInstructions']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ContactInstructions"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='contactType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ContactType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='contentType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ContentType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='context']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Context"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='controlPointAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ControlPointAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='country']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Country"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='couplingType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/CouplingType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='credit']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Credit"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dataset']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Dataset"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dataSetURI']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DataSetURI"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dataType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DataType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dateOfNextUpdate']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DateOfNextUpdate"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dateStamp']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DateStamp"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dateTime']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DateTime"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dateType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DateType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='deductiveSource']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DeductiveSource"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='definition']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Definition"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='deliveryPoint']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DeliveryPoint"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='denominator']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Denominator"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='density']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Density"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='densityUnits']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DensityUnits"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='description']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Description"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='descriptor']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Descriptor"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='detectedPolarisation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DetectedPolarisation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dimensionDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DimensionDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dimensionName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DimensionName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dimensionSize']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DimensionSize"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='dimensionTitle']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DimensionTitle"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='direction']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Direction"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='disseminationConstraints']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DisseminationConstraints"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='distance']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Distance"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='distributedComputingPlatform']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DistributedComputingPlatform"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='domainCode']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DomainCode"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='domainValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/DomainValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='eastBoundLongitude']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/EastBoundLongitude"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='edition']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Edition"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='editionDate']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/EditionDate"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='electronicMailAddress']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ElectronicMailAddress"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='environmentDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/EnvironmentDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='errorStatistic']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ErrorStatistic"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='evaluationMethodDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/EvaluationMethodDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='evaluationMethodType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/EvaluationMethodType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='expiryDate']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ExpiryDate"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='explanation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Explanation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='extentTypeCode']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ExtentTypeCode"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='facsimile']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Facsimile"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='featureAttribute']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FeatureAttribute"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='featureInstanceCount']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FeatureInstanceCount"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='featureInstances']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FeatureInstances"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='features']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Features"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='featureType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FeatureType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='fees']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Fees"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='fileDecompressionTechnique']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FileDecompressionTechnique"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='fileDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FileDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='fileIdentifier']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FileIdentifier"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='filmDistortionInformationAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/FilmDistortionInformationAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='function']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Function"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='geometricObjectCount']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/GeometricObjectCount"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='geometricObjectType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/GeometricObjectType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='georeferencedParameters']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/GeoreferencedParameters"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='groundResolution']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/GroundResolution"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='handlingDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/HandlingDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='hierarchyLevelName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/HierarchyLevelName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='hoursOfService']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/HoursOfService"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='id']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Id"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='illuminationAzimuthAngle']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/IlluminationAzimuthAngle"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='illuminationElevationAngle']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/IlluminationElevationAngle"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='imagingCondition']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ImagingCondition"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='includedWithDataset']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/IncludedWithDataset"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='individualName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/IndividualName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='initiativeType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/InitiativeType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='invocationName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/InvocationName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='ISBN']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ISBN"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='ISSN']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ISSN"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='issueIdentification']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/IssueIdentification"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='keyword']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Keyword"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='language']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Language"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='languageCode']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/LanguageCode"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='latestAcceptableDate']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/LatestAcceptableDate"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='lensDistortionInformationAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/LensDistortionInformationAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='level']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Level"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='levelOfDetail']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/LevelOfDetail"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='lotDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/LotDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maintenanceAndUpdateFrequency']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaintenanceAndUpdateFrequency"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maintenanceNote']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaintenanceNote"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maxAltitude']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaxAltitude"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maximumOccurrence']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaximumOccurrence"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maximumValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaximumValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maxRelativeHumidity']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaxRelativeHumidity"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='maxValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MaxValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='meanValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MeanValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='measureDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MeasureDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='mediumFormat']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MediumFormat"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='mediumNote']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MediumNote"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataStandardName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MetadataStandardName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='metadataStandardVersion']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MetadataStandardVersion"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='meterologicalConditions']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MeterologicalConditions"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='minimumValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MinimumValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='minValue']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/MinValue"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='nameOfMeasure']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NameOfMeasure"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='nominalSpatialResolution']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NominalSpatialResolution"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='northBoundLatitude']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NorthBoundLatitude"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='number']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Number"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='numberOfDimensions']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NumberOfDimensions"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='numberOfValues']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NumberOfValues"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='numberType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/NumberType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='obligation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Obligation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='offset']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Offset"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='operationDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OperationDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='operationName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OperationName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='optionality']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Optionality"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='orderingInstructions']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrderingInstructions"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='orderOptions']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrderOptions"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='orderOptionsType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrderOptionsType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='organisationName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrganisationName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='orientationParameterAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrientationParameterAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='orientationParameterDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OrientationParameterDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='other']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Other"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='otherCitationDetails']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OtherCitationDetails"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='otherConstraints']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OtherConstraints"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='otherProperty']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OtherProperty"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='otherPropertyType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/OtherPropertyType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='page']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Page"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='parentEntity']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ParentEntity"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='parentIdentifier']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ParentIdentifier"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='peakResponse']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PeakResponse"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='plannedAvailableDateTime']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PlannedAvailableDateTime"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='pointInPixel']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PointInPixel"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='pos']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Pos"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='positionName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PositionName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='postalCode']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PostalCode"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='presentationForm']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PresentationForm"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='priority']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Priority"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='procedureDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ProcedureDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='propertyType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/PropertyType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='protocol']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Protocol"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='protocolRequest']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ProtocolRequest"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='purpose']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Purpose"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='radiometricCalibrationDataAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/RadiometricCalibrationDataAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='rangeElement']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/RangeElement"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='rationale']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Rationale"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='referenceSystemType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ReferenceSystemType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='repeatability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Repeatability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='requestedDateOfCollection']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/RequestedDateOfCollection"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='resourceScope']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ResourceScope"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='response']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Response"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='role']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Role"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='rule']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Rule"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='runTimeParameters']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/RunTimeParameters"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='samplingRatio']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SamplingRatio"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='samplingScheme']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SamplingScheme"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='scaleFactor']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ScaleFactor"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='scanningResolution']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ScanningResolution"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='schemaAscii']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SchemaAscii"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='schemaLanguage']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SchemaLanguage"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='scopedName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ScopedName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='sequence']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Sequence"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='sequenceIdentifier']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SequenceIdentifier"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='serviceType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ServiceType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='serviceTypeVersion']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ServiceTypeVersion"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='shortName']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ShortName"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='softwareDevelopmentFileFormat']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SoftwareDevelopmentFileFormat"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='southBoundLatitude']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SouthBoundLatitude"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='spatialRepresentationType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SpatialRepresentationType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='specificUsage']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SpecificUsage"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='standaloneQualityReportDetails']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/StandaloneQualityReportDetails"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='standardDeviation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/StandardDeviation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='statement']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Statement"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='status']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Status"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='supplementalInformation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/SupplementalInformation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='temporalResolution']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TemporalResolution"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='time']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Time"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='TimeInstant']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TimeInstant"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='title']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Title"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='toneGradation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ToneGradation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='topicCategory']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TopicCategory"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='topologyLevel']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TopologyLevel"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transferFrequency']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransferFrequency"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transferFunctionType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransferFunctionType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transferSize']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransferSize"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transformationDimensionDescription']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransformationDimensionDescription"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transformationDimensionMapping']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransformationDimensionMapping"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transformationParameterAvailability']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransformationParameterAvailability"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='transmittedPolarisation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TransmittedPolarisation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='triangulationIndicator']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/TriangulationIndicator"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='trigger']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Trigger"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='turnaround']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Turnaround"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='type']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Type"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='unitsOfDistribution']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UnitsOfDistribution"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='updateScope']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UpdateScope"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='URI']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/URI"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='useConstraints']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UseConstraints"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='useLimitation']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UseLimitation"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='userDefinedMaintenanceFrequency']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UserDefinedMaintenanceFrequency"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='userDeterminedLimitations']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UserDeterminedLimitations"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='userNote']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/UserNote"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='value']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Value"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='valueRecordType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ValueRecordType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='valueType']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/ValueType"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='version']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Version"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='vertical']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Vertical"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='verticalCRS']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/VerticalCRS"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='voice']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Voice"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='volumes']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/Volumes"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[local-name()='westBoundLongitude']">
    <xsl:if test="not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or text()='Unknown' or (count(*)=1 and ( child::node()='unknown' or child::node()='Unknown' )  )  or not(node()))">
      <div class="property">
        <div class="propertyLabel">
          <span class="propertyLabelSpan">
            <xsl:value-of select="$metadataTranslation/WestBoundLongitude"/>
          </span>
        </div>
        <div class="propertyValue">
          <xsl:apply-templates></xsl:apply-templates>
        </div>
      </div>
    </xsl:if>
  </xsl:template>


  <!-- DEFINE EXCEPTIONS -->
  <xsl:template match="*[local-name()='date']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='CI_Date']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Date"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Date"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='linkage']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='CI_OnlineResource']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Linkage"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Linkage"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='resolution']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='MD_Dimension']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Resolution"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Resolution"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='fileName']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='MD_BrowseGraphic']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/FileName"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/FileName"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='fileType']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='MD_BrowseGraphic']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/FileType"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='LE_ProcessStepReport']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/FileType"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/FileType"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='pass']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='DQ_ConformanceResult']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Pass"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Pass"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='specification']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='MD_Format']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Specification"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Specification"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[local-name()='name']">
    <xsl:choose>
      <xsl:when test="parent::*[local-name()='CI_Organisation']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='CI_Individual']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='MD_Format']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='LE_ProcessStepReport']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='CI_Series']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='CI_OnlineResource']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='AbstractCI_Party']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='MD_MetadataScope']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='MD_ExtendedElementInformation']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='MI_RangeElementDescription']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='SV_OperationChainMetadata']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='MD_Medium']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>
      <xsl:when test="parent::*[local-name()='SV_Parameter']">
        <xsl:if test="(not(@nilReason='unknown' or text()='' or text()=null or text()='unknown' or (count(*)=1 and child::node()='unknown'  )  or not(node())))">
          <div class="property">
            <div class="propertyLabel">
              <span class="propertyLabelSpan">
                <xsl:value-of select="$metadataTranslation/Name"/>
              </span>
            </div>
            <div class="propertyValue">
              <xsl:apply-templates/>
            </div>
          </div>
        </xsl:if>
      </xsl:when>

      <xsl:otherwise>
        <div class="subSection">
          <div class="subSectionHeader">
            <xsl:value-of select="$metadataTranslation/Name"/>
          </div>
          <div class="subSectionBody">
            <xsl:apply-templates/>
          </div>
        </div>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


</xsl:stylesheet>

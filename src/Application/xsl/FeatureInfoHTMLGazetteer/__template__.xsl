<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gml="http://www.opengis.net/gml" xmlns:ows="http://www.opengis.net/ows" xmlns:gmgml="http://www.intergraph.com/geomedia/gml" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wfs="http://www.opengis.net/wfs" xmlns:iso19112="http://www.opengis.net/iso19112">
	<!-- xmlns="urn:x-inspire:specification:CAFE:0.1"  -->
	<!--xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/-->
	<xsl:template match="/gmgml:FeatureCollection">
		<html>
			<head>
				<title>Gazetteer</title>
        <style type="text/css">
          <![CDATA[*
          
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
          
            .HEADER
            {
              font-family: verdana,arial,sans-serif; 
              font-weight: bold; 
              font-size: 20px; 
              color: #ffffff; 
              background:#25587E;
              text-align: center;
            }

            .SUBHEADER
            {
              font-family: verdana,arial,sans-serif; 
              font-weight: bold; 
              font-size: 11px; 
              color: #000; 
              text-align:left;
            }

            .CELLTEXT
            {
              font-family: verdana,arial,sans-serif; 
              font-weight: normal; 
              font-size: 11px; 
              color: #0064A3; 
              text-align:left;
            }

            .CELLHEADER
            {
              font-family: verdana,arial,sans-serif; 
              font-weight: bold; 
              font-size: 11px; 
              color: #000000; 
              text-align:left;
              padding-left: 10px;
              width: auto;
            }
          ]]></style>
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
			<xsl:variable name="gazetteerFeatureTranslation" select="document($translationPath)/lang"/>
			      

			<body>
        <table id="main_table">
        
                <tr >
          <td colspan="2">
                <span class="maintitle">
								<xsl:value-of select="./gml:featureMember//iso19112:geographicIdentifier" />
                </span>
          </td>
          </tr>
          
          <tr>
          <td colspan="2" class="bline">
          </td>
          </tr>
        
        

          <tr class="SUBHEADER">
            <th><xsl:value-of select="$gazetteerFeatureTranslation/Details"/></th>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/FeatureId"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//@gml:id" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/AlternativeIdentifier"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//iso19112:alternativeGeographicIdentifier" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/GeographicExtent"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//iso19112:geographicExtent" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/LocationType"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//iso19112:locationType//iso19112:name" />
              </span>
            </td>
          </tr>
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$gazetteerFeatureTranslation/Geometry"/></th>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/SrsName"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//iso19112:position/gml:Point/@srsName" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$gazetteerFeatureTranslation/Coordinates"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember//iso19112:position/gml:Point/gml:pos" />
              </span>
            </td>
          </tr>
        </table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

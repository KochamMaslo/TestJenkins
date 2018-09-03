<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gml="http://www.opengis.net/gml" xmlns:ows="http://www.opengis.net/ows" xmlns:mne="http://www.idee.es/mne" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wfs="http://www.opengis.net/wfs">
	<!-- xmlns="urn:x-inspire:specification:CAFE:0.1"  -->
	<!--xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/-->
	<xsl:template match="/wfs:FeatureCollection">
		<html>
			<head>
				<title>Nomenclator</title>
        <style type="text/css">
          <![CDATA[*
          
            * { font-family: verdana,arial,sans-serif; font-size: 11px; line-height:150%; }
  	h1 { font-size:16px; }
  	.header { background-color: #1C9495; color:#ffffff; font-weight: bold; }
  	.body { background-color: #FFFFFFF; margin: 30px; }
  	.title { text-align: right; width:100px; }
  	.envelope { border-width: 0px; border-collapse: collapse; margin:0px; padding:0px; width:700px; }
  	.envelope td { border:1px solid #126363; padding: 2px 7px 2px 7px; vertical-align:top; }
  	.fontss {font-color:white; font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold; position:relative;}
  	a:link {color: #000000; text-decoration: underline;}
	a:active {color: #0000ff; text-decoration: underline;}
	a:visited {color: #008000; text-decoration: underline;}
	a:hover {color: #ff0000; text-decoration: none;}
	.textTitleHead {color:white; font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold;}
	.textTitle {color:white; font-family:verdana,arial,sans-serif; font-size:11px;}
	.spanBold {color:black; font-family:verdana,arial,sans-serif; font-size:11px;}
	.text8 {color:black; font-family:verdana,arial,sans-serif; font-size:11px;}
	.textSekcji {font-family:verdana,arial,sans-serif; font-size:11px; font-weight:bold; text-decoration:underline;}
	.columnStyle{font-family:verdana,arial,sans-serif; font-size:11px; clolor:black; font-weight:bold}
    #main_table {margin-left:10px; width:95%;} 
    th {background:#DDD;}
          
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
			<xsl:variable name="nomenclatorFeatureTranslation" select="document($translationPath)/lang"/>
			
			<body >
        <table id="main_table">
        
                <tr >
          <td colspan="2">
                <span class="maintitle">
								<xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:nombre" />
                </span>
          </td>
          </tr>
          
          <tr>
          <td colspan="2" class="bline">
          </td>
          </tr>
        
        
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$nomenclatorFeatureTranslation/Locality"/></th>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Name"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:nombre" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Language"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:idioma" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Class"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:claseNombre" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Status"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:estatus" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Source"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:nombreEntidad/mne:NombreEntidad/mne:fuente" />
              </span>
            </td>
          </tr>
          <xsl:for-each select="./gml:featureMember/mne:Entidad/mne:tipoEntidad">
          <tr class="SUBHEADER">
            <td><xsl:value-of select="$nomenclatorFeatureTranslation/Classification"/></td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Type"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./mne:TipoEntidad/mne:tipo" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Catalogue"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./mne:TipoEntidad/mne:catalogoEntidades" />
              </span>
            </td>
          </tr>
          </xsl:for-each>
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$nomenclatorFeatureTranslation/SpatialPosition"/></th>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Geometry"/>: </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLTEXT" style="margin-left: 30px;">
                <xsl:text disable-output-escaping="yes">gml:pos:&#160;&#160;</xsl:text><xsl:value-of select="./gml:featureMember/mne:Entidad/mne:posicionEspacial/mne:PosicionEspacial/mne:geometria/gml:Point" />
              </span>
            </td>
          </tr>
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$nomenclatorFeatureTranslation/AdministrativeLocation"/></th>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/AutonomousRegion"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:entidadLocal/mne:EntidadLocal/mne:comunidadAutonoma" />
              </span>
            </td>
          </tr>
          <tr>
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Province"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:entidadLocal/mne:EntidadLocal/mne:provincia" />
              </span>
            </td>
          </tr>
          <xsl:for-each select="./gml:featureMember/mne:Entidad/mne:codificacion">
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$nomenclatorFeatureTranslation/IdentificationViaCode"/></th>
          </tr>
          <tr class="CELL">
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/Code"/>: </span>
              <span class="CELLTEXT"><xsl:value-of select="./mne:Codificacion/mne:codigo" /></span>
            </td>
          </tr>
          <tr class="CELL">
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/CodingSystem"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./mne:Codificacion/mne:sistemaCodificacion" />
              </span>
            </td>
          </tr>
          </xsl:for-each>
          <tr class="SUBHEADER">
            <th><xsl:value-of select="$nomenclatorFeatureTranslation/LocationByMap"/></th>
          </tr>
          <tr class="CELL">
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/MapSeries"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:mapa/mne:Mapa/mne:serie" />
              </span>
            </td>
          </tr>
          <tr class="CELL">
            <td>
              <span class="CELLHEADER"><xsl:value-of select="$nomenclatorFeatureTranslation/MapSheet"/>: </span>
              <span class="CELLTEXT">
                <xsl:value-of select="./gml:featureMember/mne:Entidad/mne:mapa/mne:Mapa/mne:hoja" />
              </span>
            </td>
          </tr>
        </table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

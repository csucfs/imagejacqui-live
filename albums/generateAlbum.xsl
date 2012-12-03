<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="album" />
    <xsl:template match="photos">
        <xsl:processing-instruction name="xml-stylesheet">
            type="text/xsl" href="albumView.xsl"
        </xsl:processing-instruction>
        <album>
            <xsl:attribute name="name">
                <xsl:value-of select="$album" />
            </xsl:attribute>
            <xsl:apply-templates />
        </album>
    </xsl:template>
    <xsl:template match="photo"><xsl:if test="albums/album[@name = $album]">
            <photo>
                <xsl:attribute name="id">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
                <caption><xsl:value-of select="caption" /></caption>
            </photo>
        </xsl:if></xsl:template>
</xsl:stylesheet>


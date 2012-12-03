<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="photos">
        <html><head></head><body><table>
        <xsl:apply-templates>
            <xsl:sort select="@id" data-type="number" />
        </xsl:apply-templates>
        </table></body></html>
    </xsl:template>
    <xsl:template match="photo">
        <tr>
            <td><xsl:value-of select="@id" /></td>
            <td><img>
            <xsl:attribute name="src">
                ../images/small/<xsl:value-of select="@id" />.jpg
            </xsl:attribute>
            </img></td>
            <td><xsl:value-of select="caption" /></td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>


<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="2.0">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:template match="xs:schema">
        <xsl:variable name="preserve-space" select="descendant::xs:complexType[@mixed eq 'true'][descendant::xs:element | descendant::xs:group]/@name"/>
        <xsl:variable name="all-elements" select="descendant::xs:element[not(@name=following::xs:element/@name)]/@name"/>
        <results>
            <preserve>
                <xsl:apply-templates select="$preserve-space">
                    <xsl:sort select="."/>
                </xsl:apply-templates>
            </preserve>
            <safe-to-strip-space>
                <xsl:apply-templates select="$all-elements[not(. = $preserve-space)]">
                    <xsl:sort select="."/>
                </xsl:apply-templates>
            </safe-to-strip-space>
            <all-elements>
                <xsl:apply-templates select="$all-elements">
                    <xsl:sort select="."/>
                </xsl:apply-templates>
            </all-elements>
        </results>
    </xsl:template>

    <xsl:template match="@name">
        <element>
            <xsl:value-of select="."/>
        </element>
    </xsl:template>

</xsl:stylesheet>

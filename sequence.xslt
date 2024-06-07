<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:sequence="http://kookerella.com/xsl:sequence">
    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="sequence:map" as="item()*">
        <xsl:param name="mapper" as="function(item()*) as item()*"/>
        <xsl:param name="sequence" as="item()*"/>
        <xsl:sequence select="$sequence ! $mapper(.)"/>
    </xsl:function>
</xsl:stylesheet>
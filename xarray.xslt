<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                xmlns:xarray="http://kookerella.com/xarray">
    <xsl:output method="xml" indent="yes"/>

    <!-- array:map as function(function(A) as B,array(A)) as array(B) -->
    <!-- array:map :: ((A -> B),array A) -> array B -->
    <xsl:function name="xarray:map" as="array(*)">
        <xsl:param name="mapper" as="function(item()*) as item()*"/>
        <xsl:param name="array" as="array(item()*)"/>
        <xsl:sequence select="array:for-each($array,function($a) { $mapper($a) })"/>
    </xsl:function>
</xsl:stylesheet>
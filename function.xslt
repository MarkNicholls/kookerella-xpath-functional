<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                xmlns:function="www.kookerella.com/function"
                version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- A -> A -->
    <xsl:function name="function:id" as="item()*">
        <xsl:param name="value" as="item()*"/>
        <xsl:sequence select="$value"/>
    </xsl:function>

    <!-- (B -> C) -> (A -> B) -> (A -> C) -->
    <xsl:function name="function:compose" as="function(item()*) as item()*">
        <xsl:param name="f" as="function(item()*) as item()*"/>
        <xsl:param name="g" as="function(item()*) as item()*"/>
        <xsl:sequence select="function($value) { $f($g($value)) }"/>
    </xsl:function>

    <!-- (A -> B) -> (B -> C) -> (A -> C) -->
    <xsl:function name="function:then" as="function(item()*) as item()*">
        <xsl:param name="f" as="function(item()*) as item()*"/>
        <xsl:param name="g" as="function(item()*) as item()*"/>
        <xsl:sequence select="function($value) { $g($f($value)) }"/>
    </xsl:function>

    <!-- (B -> C) -> (A -> B) -> (A -> C) -->
    <!-- function(function(B) as C,function(A) as B) as function(A) as C -->
    <xsl:function name="function:map" as="function(item()*) as item()*">
        <xsl:param name="mapper" as="function(item()*) as item()*"/>
        <xsl:param name="func" as="function(item()*) as item()*"/>
        <xsl:sequence select="function:compose($mapper,$func)"/>
    </xsl:function>
</xsl:stylesheet>
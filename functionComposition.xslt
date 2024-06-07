<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:function="http://kookerella.com/xsl:function">

    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="function:compose" as="function(item()*) as item()*">
        <xsl:param name="f" as="function(item()*) as item()*"/>
        <xsl:param name="g" as="function(item()*) as item()*"/>
        <xsl:sequence select="function($value) { $f($g($value)) }"/>
    </xsl:function>

    <xsl:variable name="function:compose" select="function($f,$g) { function($value) { $f($g($value)) } }" as="function(function(item()*) as item()*,function(item()*) as item()*) as function(item()*) as item()*"/>


    <xsl:template match="/">
        <output>
            <xsl:variable name="birthday" as="xs:date" select="xs:date('2020-01-01')"/>
            <xsl:sequence select="$function:compose(xs:string#1,day-from-date#1)($birthday)"/>
        </output>
    </xsl:template>
</xsl:stylesheet>
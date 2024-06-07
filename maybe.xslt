<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                xmlns:maybe="http://www.kookerella.com/maybe">
    <xsl:function name="maybe:some" as="array(*)">
        <xsl:param name="value" as="item()*"/>
        <xsl:sequence select="array { $value }"/>
    </xsl:function>

    <xsl:function name="maybe:none" as="array(*)">
        <xsl:sequence select="array {}"/>
    </xsl:function>

    <xsl:function name="maybe:map" as="array(*)">
        <xsl:param name="mapper" as="function(item()*) as item()*"/>
        <xsl:param name="maybe" as="array(*)"/>
        <xsl:sequence select="array:for-each($maybe,function($a) { $mapper($a) })"/>        
    </xsl:function>

    <!-- maybe:match as function(function() as B,function(A) as B, Maybe A) as B -->
    <!-- maybe:match :: ((() -> B),(A -> B),Maybe A) -> B -->
    <xsl:function name="maybe:match" as="item()*">
        <xsl:param name="visitNone" as="function() as item()*"/>
        <xsl:param name="visitSome" as="function(item()*) as item()*"/>
        <xsl:param name="maybe" as="array(*)"/>
        <xsl:choose>
            <xsl:when test="array:size($maybe) = 0">
                <xsl:sequence select="$visitNone()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$visitSome(array:get($maybe,1))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="maybe:pprint" as="xs:string">
        <xsl:param name="maybe" as="array(*)"/>
        <xsl:sequence select="
            maybe:match(
                function() { 'None' },
                function($value) { 'Some(' || $value || ')' },
                $maybe)"/>
    </xsl:function>
</xsl:stylesheet>
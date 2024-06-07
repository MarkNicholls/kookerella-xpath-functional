<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                xmlns:maybe="http://www.kookerella.com/maybe"
                xmlns:sequence="http://kookerella.com/xsl:sequence"
                xmlns:kooks="http://www.kookerella.com">
    <xsl:output method="xml" indent="yes"/>

    <xsl:function name="kooks:safeDivision" as="array(xs:numeric)">
        <xsl:param name="numerator" as="xs:numeric"/>        
        <xsl:param name="denominator" as="xs:numeric"/>
        <xsl:choose> 
            <xsl:when test="not($denominator eq 0)">
                <xsl:sequence select="maybe:some($numerator div $denominator)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="maybe:none()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="sequence:map" as="item()*">
        <xsl:param name="mapper" as="function(item()*) as item()*"/>
        <xsl:param name="sequence" as="item()*"/>
        <xsl:sequence select="$sequence ! $mapper(.)"/>
    </xsl:function>

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

    <xsl:template match="/">
        <output>
            <!-- calculations as maybe(xs:numeric)* -->
            <xsl:variable name="calculations" as="array(xs:numeric)*" 
                select="(
                    kooks:safeDivision(1,1),
                    kooks:safeDivision(1,2),
                    kooks:safeDivision(2,0))"/>
            <xsl:sequence select="sequence:map(maybe:pprint#1, $calculations)"/>
        </output>    
    </xsl:template>
</xsl:stylesheet>
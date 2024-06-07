<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0"
                xmlns:function="www.kookerella.com/function"
                xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                xmlns:xmap="http://kookerella.com/xmap">
    <xsl:include href="function.xslt"/>
    <xsl:output method="xml" indent="yes"/>

    <!-- xmap:bimap as function(function(KeyA) as KeyB,function(ValueA) as ValueB,map(KeyA,ValueA)) as map(KeyB,ValueB) -->
    <!-- xmap:bimap :: ((KeyA -> KeyB),(ValueA -> ValueB),map KeyA ValueA) -> map KeyB ValueB -->
    <xsl:function name="xmap:bimap" as="map(*)">
        <xsl:param name="mapKey" as="function(item()*) as item()*"/>
        <xsl:param name="mapValue" as="function(item()*) as item()*"/>
        <xsl:param name="map" as="map(*)"/>
        <xsl:sequence select="map:merge(map:for-each($map,function($key,$value) { map { $mapKey($key) : $mapValue($value) } }))"/>
    </xsl:function>

    <!-- xmap:mapValue as function(function(A) as B,map(Key,A)) as map(Key,B) -->
    <!-- xmap:mapValue :: ((A -> B),map Key A) -> map Key B -->
    <xsl:function name="xmap:mapValue" as="map(*)">
        <xsl:param name="mapValue" as="function(item()*) as item()*"/>
        <xsl:param name="map" as="map(*)"/>
        <xsl:sequence select="xmap:bimap(function:id#1,$mapValue,$map)"/>
    </xsl:function>

    <!-- xmap:mapKey as function(function(A) as B,map(A,Value)) as map(B,Value) -->
    <!-- xmap:mapKey :: ((A -> B),map A Value) -> map B Value -->
    <xsl:function name="xmap:mapKey" as="map(*)">
        <xsl:param name="mapKey" as="function(item()*) as item()*"/>
        <xsl:param name="map" as="map(*)"/>
        <xsl:sequence select="xmap:bimap($mapKey,function:id#1,$map)"/>
    </xsl:function>

    <xsl:function name="xmap:toArray" as="array(*)">
        <xsl:param name="map" as="map(*)"/>
        <xsl:sequence select="array { map:for-each($map,function($key,$value) { array { $key,$value } }) }"/>
    </xsl:function>        
</xsl:stylesheet>


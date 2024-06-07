<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                xmlns:xsequence="www.kookerella.com/xsequence"
                version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- empty as sequence A -->
    <!-- empty : Sequence A -->
    <xsl:function name="xsequence:empty" as="item()*">
        <xsl:sequence select="()"/>
    </xsl:function>

    <!-- append as function(sequence A, sequence A) as sequence A -->
    <!-- append : (Sequence A,Sequence A) -> Sequence A -->
    <xsl:function name="xsequence:append" as="item()*">
        <xsl:param name="sequence1" as="item()*"/>
        <xsl:param name="sequence2" as="item()*"/>
        <xsl:sequence select="$sequence1,$sequence2"/>
    </xsl:function>

    <xsl:template match="/">
        <xsl:variable name="doc" as="document-node()">
            <xsl:document>
                <root>
                    <foo/>
                    <bar/>
                    <wibble/>
                </root>
            </xsl:document>
        </xsl:variable>
        <output>
            <associative>
                <expression1>
                    <xsl:sequence select="xsequence:append(($doc/root/wibble),($doc/root/bar,$doc/root/foo))"/>
                </expression1>
                <expression2>
                    <xsl:sequence select="xsequence:append(($doc/root/wibble,$doc/root/bar),($doc/root/foo))"/>
                </expression2>
            </associative>
            <identity>
                <expression1>
                    <xsl:sequence select="xsequence:append(xsequence:empty(),($doc/root/wibble,$doc/root/bar))"/>
                </expression1>
                <expression2>
                    <xsl:sequence select="xsequence:append(($doc/root/wibble,$doc/root/bar),xsequence:empty())"/>
                </expression2>
            </identity>
        </output>    
    </xsl:template>
</xsl:stylesheet>
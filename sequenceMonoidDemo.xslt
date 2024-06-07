<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
    <xsl:output method="xml" indent="yes"/>

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
                    <xsl:sequence select="(($doc/root/wibble),($doc/root/bar,$doc/root/foo))"/>
                </expression1>
                <expression2>
                    <xsl:sequence select="(($doc/root/wibble,$doc/root/bar),($doc/root/foo))"/>
                </expression2>
            </associative>
            <identity>
                <expression1>
                    <xsl:sequence select="((),($doc/root/wibble,$doc/root/bar))"/>
                </expression1>
                <expression2>
                    <xsl:sequence select="(($doc/root/wibble,$doc/root/bar),())"/>
                </expression2>
            </identity>
        </output>    
    </xsl:template>
</xsl:stylesheet>
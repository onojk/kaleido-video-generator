<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

   <xsl:import href="/builds/multimedia/kdenlive/linux-64-gcc/share/xml/docbook/xsl-stylesheets/html/autoidx.xsl"/>
   <xsl:import href="/builds/multimedia/kdenlive/linux-64-gcc/share/xml/docbook/xsl-stylesheets/html/chunk.xsl"/>

   <xsl:param name="l10n.xml" select="document('xsl/all-l10n.xml')"/>
   <xsl:param name="local.l10n.xml" select="document(concat('xsl/',/*/@lang,'.xml'))"/>

   <xsl:template name="generate.html.title"/>
</xsl:stylesheet>

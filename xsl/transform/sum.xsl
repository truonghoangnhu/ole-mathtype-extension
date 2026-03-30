<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1998/Math/MathML"
    version="1.0">

  <!-- Summations -->

  <!--
    Some MathType equations get color information wrapped around operands after the
    color-range preprocessing step. In that case, a logical operand may appear as a
    color_range element containing a slot/pile/char instead of as a direct child.

    The original tmSUM templates only counted direct slot|pile|char children, which
    shifts operand positions and can drop lower/upper limits or the summed expression.

    Treat color_range as an operand container when it wraps one of the expected node
    types so operand indexing stays stable after color preprocessing.
  -->
  <xsl:template name="sum-operand">
    <xsl:param name="index"/>
    <xsl:variable name="operands"
      select="*[self::slot or self::pile or self::char or self::color_range[*[self::slot or self::pile or self::char]]]"/>
    <xsl:apply-templates select="$operands[$index]"/>
  </xsl:template>

  <xsl:template match="tmpl[selector = 'tmSUM'][variation = 'tvBO_SUM']">
    <mstyle displaystyle="true">
      <munderover>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="4"/>
        </xsl:call-template>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="2"/>
        </xsl:call-template>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="3"/>
        </xsl:call-template>
      </munderover>
      <xsl:call-template name="sum-operand">
        <xsl:with-param name="index" select="1"/>
      </xsl:call-template>
    </mstyle>
  </xsl:template>

  <xsl:template match="tmpl[selector = 'tmSUM' and not(variation = 'tvBO_SUM')]">
    <mstyle displaystyle="true">
      <msubsup>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="4"/>
        </xsl:call-template>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="2"/>
        </xsl:call-template>
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="3"/>
        </xsl:call-template>
      </msubsup>
      <xsl:call-template name="sum-operand">
        <xsl:with-param name="index" select="1"/>
      </xsl:call-template>
    </mstyle>
  </xsl:template>

  <!-- Sum operator -->
  <xsl:template match="tmpl[selector = 'tmSUMOP']">
    <munderover>
      <mstyle displaystyle="true" mathsize="140%">
        <xsl:call-template name="sum-operand">
          <xsl:with-param name="index" select="4"/>
        </xsl:call-template>
      </mstyle>
      <xsl:call-template name="sum-operand">
        <xsl:with-param name="index" select="2"/>
      </xsl:call-template>
      <xsl:call-template name="sum-operand">
        <xsl:with-param name="index" select="3"/>
      </xsl:call-template>
    </munderover>
  </xsl:template>

</xsl:stylesheet>

<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet
	version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns='http://www.w3.org/1999/xhtml'
>
<xsl:import href='/menubar.xsl'/>
<xsl:output method='xml' version='1.0' encoding='UTF-8' indent='yes'/>
<xsl:template match='/subject'>
	<html>
		<head>
			<title>Station - Subject</title>
			<link rel="stylesheet" type="text/css" href="/base.css"/>
			<xsl:call-template name='header-head'/>
			<xsl:call-template name='slide-head'/>
			<link rel='stylesheet' type='text/css' href='/content.css'/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<xsl:call-template name='slide'/>
			<div class='container-content'>
				<div class='title'>
					<span><xsl:value-of select='title'/></span>
				</div>
				<pre><xsl:value-of select='description'/></pre>
				<div class='content'>
					<xsl:for-each select='courses/course'>
						<div class='card-course'>
							<div class='title'>
								<xsl:value-of select='title'/>
							</div>
							<div class='description'>
								<pre><xsl:value-of select='description'/></pre>
							</div>
							<div class='tail'>
								<div class='enroll'>
									<a>
										<xsl:attribute name='href'>../course/<xsl:value-of select='identifier'/></xsl:attribute>
										Enroll Now
									</a>
								</div>
								<div class='point'></div>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

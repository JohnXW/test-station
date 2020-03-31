<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet
	version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns='http://www.w3.org/1999/xhtml'
>
<xsl:import href='/menubar.xsl'/>
<xsl:output method='xml' version='1.0' encoding='UTF-8' indent='yes'/>
<xsl:template match='/home'>
	<html>
		<head>
			<title>Station</title>
			<xsl:call-template name='header-head'/>
			<xsl:call-template name='slide-head'/>
			<link rel='stylesheet' type='text/css' href='/content.css'/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<xsl:call-template name='slide'/>
			<div class='container-content'>
				<div class='title'>
					<span>
						Subject<xsl:if test='count(subjects/subject)!=1'>s</xsl:if>
					</span>
				</div>
				<div class='content'>
					<xsl:for-each select='subjects/subject'>
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
										<xsl:attribute name='href'>learn/subject/<xsl:value-of select='identifier'/></xsl:attribute>
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

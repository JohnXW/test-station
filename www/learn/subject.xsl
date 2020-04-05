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
			<xsl:call-template name='header-head'/>
			<xsl:call-template name='slide-head'/>
			<link rel="stylesheet" href="../subject.css"/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<xsl:call-template name='slide'/>
			<div class="container-content">
				<div class="container-subject">
					<div class="title">
						<xsl:value-of select='title'/>
					</div>
					<div class="btn">
						<a href="#all_course">
							View All Course<xsl:if test='count(courses/course)!=1'>s</xsl:if>
						</a>
					</div>
				</div>
				<div class="container-description">
					<span><xsl:value-of select='description'/></span>
				</div>
				<div class="title" id="all_course">
					All Course<xsl:if test='count(courses/course)!=1'>s</xsl:if>
				</div>
				<div class="page">
					<div class="page-title">
						<a href=""><span>Page 1</span></a>
					</div>
				</div>
				<div class="content">
					<xsl:for-each select='courses/course'>
						<div class="card-course">
							<div class="title">
								<xsl:value-of select='title'/>
							</div>
							<div class="description">
								<span><xsl:value-of select='description'/></span>
							</div>
							<div class="tail">
								<div class="enroll">
									<a>
										<xsl:attribute name='href'>../course/<xsl:value-of select='identifier'/></xsl:attribute>
										Enroll Now
									</a>
								</div>
								<div class="point"></div>
							</div>
						</div>
					</xsl:for-each>
				</div>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

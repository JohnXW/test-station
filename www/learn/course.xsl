<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet
	version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns='http://www.w3.org/1999/xhtml'
>
<xsl:import href='/menubar.xsl'/>
<xsl:output method='xml' version='1.0' encoding='UTF-8' indent='yes'/>
<xsl:template match='/course'>
	<html>
		<head>
			<title>Station - Course</title>
			<xsl:call-template name='header-head'/>
			<link rel="stylesheet" href="../course.css"/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<div class="container-content">
				<div class="container-title">
					<div class="btn-back">
						<a>
							<xsl:attribute name='href'>../subject/<xsl:value-of select='subject'/></xsl:attribute>
							<span>X</span>
						</a>
					</div>
					<div class="course-title">
						<span>XML</span>
					</div>
				</div>
				<div class="content">
					<div class="container-lesson">
						<div class="session-title">
							<span>Lessons</span>
						</div>
						<div class="lesson-list">
							<xsl:for-each select='lessons/lesson'>
								<a>
									<xsl:attribute name='href'>../lesson/<xsl:value-of select='identifier'/></xsl:attribute>
									<div class="lesson">
										<div class="lesson-order">
											<span><xsl:value-of select='number'/></span>
										</div>
										<div class="lesson-title">
											<span><xsl:value-of select='title'/></span>
										</div>
									</div>
								</a>
							</xsl:for-each>
						</div>
						<div class="report">
							<a href="">
								<span>Report a mistake</span>
							</a>
						</div>
					</div>
					<div class="container-intro">
						<div class="session-title">
							<span>Introduction</span>
						</div>
						<div class="content">
							<span><xsl:value-of select='description'/></span>
						</div>
					</div>
				</div>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

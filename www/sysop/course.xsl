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
			<title>SysOp: Course</title>
			<link rel="stylesheet" type="text/css" href="../base.css"/>
			<link rel="stylesheet" type="text/css" href="/base.css"/>
			<script type='application/ecmascript' src='../delete_disable.js' async=''/>
		</head>
		<body>
			<xsl:call-template name='menubar'/>
			<a>
				<xsl:attribute name='href'>../subject/<xsl:value-of select='subject'/></xsl:attribute>
				Back
			</a>
			<section>
				<h1>Course</h1>
				<h2><xsl:value-of select='title'/></h2>
				<form method='POST'>
					<input type='hidden' name='subject'>
						<xsl:attribute name='value'><xsl:value-of select='subject'/></xsl:attribute>
					</input>
					<label>
						Title
						<div class='flex'>
							<input type='text' name='title'>
								<xsl:attribute name='value'><xsl:value-of select='title'/></xsl:attribute>
							</input>
						</div>
					</label>
					<label>
						Description
						<div class='flex'>
							<textarea name='description'><xsl:value-of select='description'/></textarea>
						</div>
					</label>
					<label>Delete<input type='checkbox' name='delete'/></label>
					<br/>
					<button type='submit'>Modify</button>
				</form>
			</section>
			<section>
				<h1>Create lesson</h1>
				<form method='POST'>
					<xsl:attribute name='action'>../lesson/new/<xsl:value-of select='identifier'/></xsl:attribute>
					<label>
						Title
						<div class='flex'>
							<input type='text' name='title'/>
						</div>
					</label>
					<label>
						Content
						<div class='flex'>
							<textarea name='content'/>
						</div>
					</label>
					<button type='submit'>Create</button>
				</form>
			</section>
			<section>
				<h1>Modify lesson</h1>
				<table>
					<xsl:for-each select='lessons/lesson'>
						<tbody>
							<tr>
								<td>
									<a>
										<xsl:attribute name='href'>../lesson/<xsl:value-of select='identifier'/></xsl:attribute>
										<xsl:value-of select='number'/>
									</a>.
								</td>
								<td>
									<xsl:if test='number>1'>
										<form method='POST'>
											<xsl:attribute name='action'>
												../lesson/exchange/<xsl:value-of select='../../identifier'/>
											</xsl:attribute>
											<input type='hidden' name='0'>
												<xsl:attribute name='value'>
													<xsl:value-of select='identifier'/>
												</xsl:attribute>
											</input>
											<input type='hidden' name='1'>
												<xsl:attribute name='value'>
													<xsl:value-of select='preceding-sibling::*[1]/identifier'/>
												</xsl:attribute>
											</input>
											<button type='submit'>↑</button>
										</form>
									</xsl:if>
								</td>
								<td>
									<xsl:if test='count(../lesson)>number'>
										<form method='POST'>
											<xsl:attribute name='action'>
												../lesson/exchange/<xsl:value-of select='../../identifier'/>
											</xsl:attribute>
											<input type='hidden' name='0'>
												<xsl:attribute name='value'>
													<xsl:value-of select='identifier'/>
												</xsl:attribute>
											</input>
											<input type='hidden' name='1'>
												<xsl:attribute name='value'>
													<xsl:value-of select='following-sibling::*[1]/identifier'/>
												</xsl:attribute>
											</input>
											<button type='submit'>↓</button>
										</form>
									</xsl:if>
								</td>
								<td>
									<xsl:value-of select='title'/>
								</td>
							</tr>
						</tbody>
					</xsl:for-each>
				</table>
			</section>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet
	version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns='http://www.w3.org/1999/xhtml'
>
<xsl:import href='/menubar.xsl'/>
<xsl:output method='xml' version='1.0' encoding='UTF-8' indent='yes'/>
<xsl:template match='/account'>
	<html>
		<head>
			<title>Account</title>
			<xsl:call-template name='header-head'/>
			<link rel="stylesheet" href="../account.css"/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<div class="container-content">
				<div class="account-function">
					<div class="title">
						<span>Modify Account</span>
					</div>
					<div class="account-setting">
						
						<form method="POST">
							<div class="container-attributes">
								<div class="account-attribute attribute">
									<div class="attribute-name">
										<span>Name</span>
									</div>
									<div class="attribute-value">
										<input class="value" type="text" name='user' readonly='' >
											<xsl:attribute name='value'>
												<xsl:value-of select='session/name'/>
											</xsl:attribute>
										</input>
									</div>
								</div>
								<div class="account-attribute attribute final-attribute">
									<div class="attribute-name">
										<span>New Password</span>
									</div>
									<div class="attribute-value">
										<input class="value final-value" type="password" name='password' />
									</div>
								</div>
								<div class="attribute">
									<div class="attribute-name"></div>
									<div class="btn-submit">
										<input class="btn-add" type="submit" value="Change" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

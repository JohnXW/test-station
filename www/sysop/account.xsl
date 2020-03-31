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
			<title>SysOp: Account</title>
			<script type='application/ecmascript' src='delete_disable.js' async=''/>
			<xsl:call-template name='header-head'/>
			<link rel='stylesheet' type='text/css' href='account.css'/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<div class='container-content'>
				<div class='account-function'>
					<div class='title'>
						<span>Create New Account</span>
					</div>
					<form method='POST'>
						<div class='account-setting'>
							<div class='container-attributes'>
								<div class='account-attribute attribute'>
									<div class='attribute-name'>
										<span>Name</span>
									</div>
									<div class='attribute-value'>
										<input type='text' class='value' name='name'/>
									</div>
								</div>
								<div class='account-attribute attribute'>
									<div class='attribute-name'>
										<span>Role</span>
									</div>
									<div class='attribute-value select'>
										<select id='role' class='value' name='role'>
											<option value='User'>Basic User</option>
											<option value='SysOp'>System Operator</option>
										</select>
									</div>
								</div>
								<div class='account-attribute attribute final-attribute'>
									<div class='attribute-name'>
										<span>New Password</span>
									</div>
									<div class='attribute-value'>
										<input type='password' class='value final-value' name='password'/>
									</div>
								</div>
								<div class='attribute'>
									<div class='attribute-name'></div>
									<div class='btn-submit'>
										<input class='btn-add' type='submit' value='Add'/>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<pre></pre>
				<div class='account-function'>
					<div class='title'>
						<span>Modify Existing Accounts</span>
					</div>
					<xsl:for-each select='user'>
						<form method='POST'>
							<div class='account-setting'>
								<div class='container-attributes'>
									<div class='account-attribute attribute'>
										<div class='attribute-name'>
											<span>Name</span>
										</div>
										<div class='attribute-value'>
											<input type='text' class='value' name='user' readonly=''>
												<xsl:attribute name='value'><xsl:value-of select='.'/></xsl:attribute>
											</input>
										</div>
									</div>
									<div class='account-attribute attribute'>
										<div class='attribute-name'>
											<span>Mark</span>
										</div>
										<div class='attribute-value'>
											<input type='text' class='value' name='mark'>
												<xsl:attribute name='value'><xsl:value-of select='@mark'/></xsl:attribute>
											</input>
										</div>
									</div>
									<div class='attribute'>
										<div class='attribute-name'>Lock</div>
										<div class='btn-attribute'>
											<input type='checkbox' name='lock'>
												<xsl:if test='@lock'>
													<xsl:attribute name='checked'/>
												</xsl:if>
											</input>
										</div>
									</div>
									<div class='attribute'>
										<div class='attribute-name'>Delete</div>
										<div class='btn-attribute'>
											<input type='checkbox' name='delete'/>
										</div>
									</div>
								</div>
								<div class='container-attributes'>
									<div class='account-attribute attribute'>
										<div class='attribute-name'>
											<span>New Name</span>
										</div>
										<div class='attribute-value'>
											<input type='text' class='value' name='name'>
												<xsl:attribute name='value'><xsl:value-of select='.'/></xsl:attribute>
											</input>
										</div>
									</div>
									<div class='account-attribute attribute'>
										<div class='attribute-name'>
											<span>Role</span>
										</div>
										<div class='attribute-value select'>
											<select id='role' class='value' name='role'>
												<option value='User'>
													<xsl:if test='@role="User"'>
														<xsl:attribute name='selected'/>
													</xsl:if>
													Basic User
												</option>
												<option value='SysOp'>
													<xsl:if test='@role="SysOp"'>
														<xsl:attribute name='selected'/>
													</xsl:if>
													System Operator
												</option>
											</select>
										</div>
									</div>
									<div class='account-attribute attribute final-attribute'>
										<div class='attribute-name'>
											<span>New Password</span>
										</div>
										<div class='attribute-value'>
											<input type='text' class='value final-value' name='password'/>
										</div>
									</div>
									<div class='attribute'>
										<div class='attribute-name'></div>
										<div class='btn-submit'>
											<input class='btn-save' type='submit' value='Save'/>
										</div>
									</div>
								</div>
							</div>
						</form>
					</xsl:for-each>
				</div>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

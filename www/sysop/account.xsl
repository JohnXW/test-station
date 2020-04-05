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
			<xsl:call-template name='header-head'/>
			<link rel='stylesheet' type='text/css' href='account.css'/>
			<script type='application/ecmascript' src='./delete_disable.js' async=''/>
		</head>
		<body>
			<xsl:call-template name='header'/>
			<div class="container-content">
				<div class="account-function">
					<div class="title">
						<span>Create New Account</span>
					</div>
					<div class="account-setting">
						
						<form method="POST">
							<div class="container-attributes">
								<div class="account-attribute attribute">
									<div class="attribute-name">
										<span>Name</span>
									</div>
									<div class="attribute-value">
										<input class="value" type="text" />
									</div>
								</div>
								<div class="account-attribute attribute">
									<div class="attribute-name">
										<span>Select Role</span>
									</div>
									<div class="attribute-value select">
										<select class="value" id="role" name='role'>
											<option value="User">Basic User</option>
											<option value="SysOp">System Operator</option>
										</select>
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
										<input class="btn-add" type="submit" value="Add" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="account-function">
					<div class="title">
						<span>Modify Existing Accounts</span>
					</div>
					<xsl:for-each select='user'>
						<form method='POST'>
							<div class="account-setting">
								<div class="container-attributes">
									<div class="account-attribute attribute">
										<div class="attribute-name">
											<span>Name</span>
										</div>
										<div class="attribute-value">
											<input class="value" type="text" name='user' readonly='' >
												<xsl:attribute name='value'>
													<xsl:value-of select='.'/>
												</xsl:attribute>
											</input>
										</div>
									</div>
									<div class="account-attribute attribute">
										<div class="attribute-name">
											<span>Mark</span>
										</div>
										<div class="attribute-value">
											<input class="value" type="number">
												<xsl:attribute name='value'>
													<xsl:value-of select='@mark'/>
												</xsl:attribute>
											</input>
										</div>
									</div>
									<div class="attribute">
										<div class="attribute-name"></div>
										<div class="btn-attribute">
											<input class="btn-image btn-lock" type='checkbox' name='lock' >
												<xsl:if test='@lock'>
													<xsl:attribute name='checked'/>
												</xsl:if>
												<xsl:attribute name='id'><xsl:value-of select='position()'/>_lock</xsl:attribute>
											</input>
											<label for="lock" class="btn-image btn-lock">
												<xsl:attribute name='for'><xsl:value-of select='position()'/>_lock</xsl:attribute>
											</label>
										</div>
									</div>
									<div class="attribute">
										<div class="attribute-name"></div>
										<div class="btn-attribute">
											<input class="btn-image btn-remove" type='checkbox' name='delete' >
												<xsl:attribute name='id'><xsl:value-of select='position()'/>_remove</xsl:attribute>
											</input>
											<label for="lock" class="btn-image btn-remove">
												<xsl:attribute name='for'><xsl:value-of select='position()'/>_remove</xsl:attribute>
											</label>
										</div>
									</div>
								</div>
								<div class="container-attributes">
									<div class="account-attribute attribute">
										<div class="attribute-name">
											<span>New Name</span>
										</div>
										<div class="attribute-value">
											<input class="value" type="text" name='name' >
												<xsl:attribute name='value'>
													<xsl:value-of select='.'/>
												</xsl:attribute>
											</input>
										</div>
									</div>
									<div class="account-attribute attribute">
										<div class="attribute-name">
											<span>Role</span>
										</div>
										<div class="attribute-value select">
											<select class="value" id="role" name="role">
												<option value="User">
													<xsl:if test='@role="User"'>
														<xsl:attribute name='selected'/>
													</xsl:if>
													Basic User
												</option>
												<option value="SysOp">
													<xsl:if test='@role="SysOp"'>
														<xsl:attribute name='selected'/>
													</xsl:if>
													System Operator
												</option>
											</select>
										</div>
									</div>
									<div class="account-attribute attribute final-attribute">
										<div class="attribute-name">
											<span>New Password</span>
										</div>
										<div class="attribute-value">
											<input class="value final-value" type="password" name='password'/>
										</div>
									</div>
									<div class="attribute">
										<div class="attribute-name"></div>
										<div class="btn-submit">
											<input class="btn-save" type="submit" value="Save" />
										</div>
									</div>
								</div>
								<pre></pre>
							</div>
						</form>
					</xsl:for-each>
				</div>
			</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>

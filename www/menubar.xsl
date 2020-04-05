<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet
	version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns='http://www.w3.org/1999/xhtml'
>
<xsl:output method='xml' version='1.0' encoding='UTF-8' indent='yes'/>
<xsl:template name='menubar'>
	<div>
		<strong><xsl:value-of select='session/name'/></strong>:
		<em><xsl:value-of select='session/mark'/> point<xsl:if test='session/mark!=1'>s</xsl:if></em>
		| <a href='/home'>Home</a>
		| <a href='/public/logout'>Log out</a>
	</div>
	<hr/>
</xsl:template>
<xsl:template name='header-head'>
	<link rel='stylesheet' type='text/css' href='/public/global.css'/>
	<link rel='stylesheet' type='text/css' href='/public/font-family.css'/>
	<link rel='stylesheet' type='text/css' href='/public/header.css'/>
	<link rel='stylesheet' type='text/css' href='/public/slide-show.css'/>
	<script type='application/ecmascript' src='/public/menu.js'></script>
</xsl:template>
<xsl:template name='header'>
	<header>
		<div class='header'>
			<div class='container-basic-info'>
				<div class='logo align-bot'>
					<div class='sponsor'>
						<a href='https://www.collaction.hk/s/station/'>
							<img src='/public/station_logo_black.png'/>
						</a>
					</div>
					<div class='sponsor'>
						<a href='https://www.eatonworkshop.com/hotel/hong-kong'>
							<img class='vice-sponsor' src='/public/eaton_logo_black.png'/>
						</a>
					</div>
				</div>
				<div class='user align-bot'>
					<div class='user-info'>
						<div class='welcome-msg basic-info-font'>
							<span>Welcome Back!</span>
						</div>
						<div class='user-data'>
							<div class='user-name align-bot basic-info-font'>
								<span class='first-name'><xsl:value-of select='session/name'/></span>
							</div>
							<div class='user-score align-bot basic-info-font'>
								<span>Point: <xsl:value-of select='session/mark'/></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class='container-menu'>
				<div class='menu-icon' onclick='toggNavBar(this)'>
					<div></div>
					<div></div>
					<div></div>
				</div>
			</div>
		</div>
		<div class='menu-content'>
			<ul>
				<li><a href='/home'>Home</a></li>
				<li><a href='https://www.collaction.hk/s/station/'>Station for Open Cultures</a></li>
				<li><a href='https://www.eatonworkshop.com/hotel/hong-kong'>EatonHK</a></li>
				<li><a href='https://g0vhk.io/'>g0vhk</a></li>
				<li><a href='/account'>My Account</a></li>
				<xsl:if test='session/role="SysOp"'>
					<li><a href='/sysop/account'>Account Management</a></li>
					<li><a href='/sysop/subjects'>Lesson Management</a></li>
				</xsl:if>
				<li><a href='/public/logout'>Log Out</a></li>
			</ul>
		</div>
	</header>
</xsl:template>
<xsl:template name='slide-head'>
	<script type='application/ecmascript' src='/public/slider.js'></script>
</xsl:template>
<xsl:template name='slide'>
	<div class='container-slide-show' onmouseover='stopAutoSlide()' onmouseout='contineSlide()'>
		<div class='slide'>
			<a href=''><img src='/public/slide/1.jpg'/></a>
		</div>
		<div class='slide'>
			<a href=''><img src='/public/slide/2.jpg'/></a>
		</div>
		<div class='slide'>
			<a href=''><img src='/public/slide/1.jpg'/></a>
		</div>
		<div class='slide'>
			<a href=''><img src='/public/slide/2.jpg'/></a>
		</div>
		<div class='slide'>
			<a href=''><img src='/public/slide/1.jpg'/></a>
		</div>
		<div class='container-btn-slide'>
			<span class='btn-slide' onclick='setShowImgIndex(0)'></span>
			<span class='btn-slide' onclick='setShowImgIndex(1)'></span>
			<span class='btn-slide' onclick='setShowImgIndex(2)'></span>
			<span class='btn-slide' onclick='setShowImgIndex(3)'></span>
			<span class='btn-slide' onclick='setShowImgIndex(4)'></span>
		</div>
	</div>
</xsl:template>
</xsl:stylesheet>

<!DOCTYPE html>

<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<title>登录-极课教育云</title>

		<spring:theme code="iconfont.css.file" var="iconfontCssFile" />
		<spring:theme code="public.css.file" var="publicCssFile" />
		<spring:theme code="footer.css.file" var="footerCssFile" />
		<spring:theme code="login.css.file" var="loginCssFile" />
		<link rel="stylesheet" href="<c:url value="${iconfontCssFile}" />" />
		<link rel="stylesheet" href="<c:url value="${publicCssFile}" />" />
		<link rel="stylesheet" href="<c:url value="${footerCssFile}" />" />
		<link rel="stylesheet" href="<c:url value="${loginCssFile}" />" />
        
		<link rel="icon" href="<c:url value="/icon.png" />" type="image/x-icon" />
		<link rel="shortcut icon" href="<c:url value="themes/gclass/images/icon.png" />" type="image/x-icon" />

		<spring:theme code="html5.javascript.file" var="html5shivJsFile" />
		<!--[if lt IE 9]>
		    <script type="text/javascript" src="<c:url value="${html5shivJsFile}" />"></script>
	  	<![endif]-->
	</head>
	<body id="cas">
		<header class="g_hd">
	        <div class="g_hd_top">
	            <div class="g_hd_top_mn">
	                <div class="g_hd_top_logo">
	                    <img class="g_hd_top_logo_img" src="themes/gclass/images/knowledge_base_list_top_logo.png" />
	                </div>
	            </div>
	        </div>
	        <div class="g_hd_bot">
	            <div class="g_hd_bot_mn">
	                <div class="g_hd_bot_logo">
	                    <img class="g_hd_bot_logo_img" src="themes/gclass/images/logo_b.png" />
	                </div>
	                <p class="g_hd_bot_tt">极课教育云</p>
	            </div>
	        </div>
	    </header>
	    
		<div class="g_mn">
			<div class="m_box">
				<form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">
					<!-- 用户名 -->
					<c:choose>
						<c:when test="${not empty sessionScope.openIdLocalId}">
							<strong><c:out value="${sessionScope.openIdLocalId}" /></strong>
							<input class="m_input" type="hidden" id="username" name="username" value="<c:out value="${sessionScope.openIdLocalId}" />" />
						</c:when>
						<c:otherwise>
							<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
							<form:input placeholder="用户名" cssClass="required m_input" cssErrorClass="required m_input" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="off" htmlEscape="true" />
						</c:otherwise>
					</c:choose>
					<!-- 密码 -->
					<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
					<form:password placeholder="密码" cssClass="required m_input" cssErrorClass="required m_input" id="password" size="25" tabindex="2" path="password" accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
					<!-- <div id="capslock-on" style="display: none;" class="target">
						<div class="out"></div>
						<div class="in"></div>
						<p><spring:message code="screen.capslock.on" /></p>
					</div> -->
	
					<p class="m_box_p" ><form:errors path="*" element="span" htmlEscape="false" /></p>
	
					<input type="hidden" name="lt" value="${loginTicket}" /> 
					<input type="hidden" name="execution" value="${flowExecutionKey}" /> 
					<input type="hidden" name="_eventId" value="submit" /> 
					<input class="m_input m_submit" type="submit" value="登录" />
				</form:form>
			</div>
		</div>
		
		<footer class="g_ft g_ft_login">
	        <div class="g_ft_mn">
	            <div class="g_ft_box">
	                <div class="g_ft_edition">
	                    <p class="g_ft_edition_p">Copyright © 2016 GCLASS. All Rights Reserved.</p>
	                </div>
	                <div class="g_ft_company">
	                    <p class="g_ft_company_p">技术支持：上海极课信息技术有限公司</p>
	                    <p class="g_ft_p">沪ICP备16019448号-1</p>
	                </div>
	            </div>
	            <div class="g_ft_box">
	                <div class="g_ft_rwm">
	                    <div class="g_ft_img_mn">
	                        <img class="g_ft_img" src="themes/gclass/images/close_bg_01.png" />
	                    </div>
	                    <span class="g_ft_img_span">安卓APP下载</span>
	                </div>
	            </div>
	        </div>
	    </footer>
	</body>
	
</html>
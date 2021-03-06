<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE HTML>
<!--
Striped 2.0 by HTML5 UP
html5up.net | @n33co
Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
    <title>java.daba.doo</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <link rel="stylesheet" type="text/css" href="http://xoxco.com/projects/code/tagsinput/jquery.tagsinput.css" />
    <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/themes/start/jquery-ui.css" />
    <%--<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:400,400italic,700|Open+Sans+Condensed:300,700" rel="stylesheet" />--%>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.22/jquery-ui.min.js"></script>
    <script type="text/javascript" src="http://xoxco.com/projects/code/tagsinput/jquery.tagsinput.js"></script>
    <script src="${pageContext.request.contextPath}/js/config.js"></script>
    <script src="${pageContext.request.contextPath}/js/skel.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/skel-panels.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/skel-panels.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/principal.js"></script>
    <script src="${pageContext.request.contextPath}/js/calendar.js"></script>
    <noscript>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css__skel_noscript" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style-desktop.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style-wide.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skel-noscript.css" />
    </noscript>
    <!--[if lte IE 9]><link rel="stylesheet" href="${pageContext.request.contextPath}/css/ie9.css" /><![endif]-->
    <!--[if lte IE 8]><script src="https://raw.github.com/aFarkas/html5shiv/master/dist/html5shiv.js"></script><link rel="stylesheet" href="${pageContext.request.contextPath}/css/ie8.css" /><![endif]-->
    <!--[if lte IE 7]><link rel="stylesheet" href="${pageContext.request.contextPath}/css/ie7.css" /><![endif]-->
</head>
<!--
    Note: Set the body element's class to "left-sidebar" to position the sidebar on the left.
    Set it to "right-sidebar" to, you guessed it, position it on the right.
-->
<body class="left-sidebar">

<!-- Wrapper -->
<div id="wrapper">
    <div id="header">java.daba.doo</div>


    <!-- Content -->
    <div id="content">
        <div id="content-inner">

            <c:choose>
                <c:when test="${view eq 'user-post-detail'}">
                    <jsp:include page="dynamic-template/user-post-detail.jsp" />
                </c:when>
                <c:when test="${view eq 'user-post-editor'}">
                    <jsp:include page="dynamic-template/user-post-editor.jsp" />
                </c:when>
                <c:otherwise>
                    <jsp:include page="dynamic-template/user-posts-list.jsp" />
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <!-- Sidebar -->
    <div id="sidebar">

        <!-- Logo -->
        <div id="logo">
            <h1><sec:authentication property="principal" /></h1>
        </div>

        <!-- Nav -->
        <nav id="nav">
            <ul>
                <li class="current_page_item"><a href="${pageContext.request.contextPath}/post/page/0">Latest Post</a></li>
                <li><a href="#">Archives</a></li>
                <li><a href="#">About Me</a></li>
                <li><a href="#">Contact Me</a></li>

                <sec:authorize access="hasRole('ROLE_USER')">
                    <li><a href="${pageContext.request.contextPath}/post/editor/new">Write a Post</a></li>
                    <li><a href="${pageContext.request.contextPath}/j_spring_security_logout">Sign out</a></li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <div id="login-area">
                        <form id="form-login" action='${pageContext.request.contextPath}/j_spring_security_check' method='POST'>
                            <input type="text" class="text" name="j_username" placeholder="User alias" />
                            <input type="password" class="text" name="j_password" placeholder="User password" />
                            <input type="submit" class="button" value="Sign in"/>
                        </form>
                    </div>
                </sec:authorize>
            </ul>
        </nav>
        <!-- Search -->
        <section class="is-search">
            <form method="post" action="#">
                <input type="text" class="text" name="search" placeholder="Search" />
            </form>
        </section>

        <!-- Text -->
        <section class="is-text-style1">
            <div class="inner">
                <p>
                    <strong>Striped:</strong> A free and fully responsive HTML5 site
                    template designed by <a href="http://n33.co/">AJ</a> for <a href="http://html5up.net/">HTML5 up!</a>
                </p>
            </div>
        </section>

        <!-- Recent Posts -->
        <jsp:include page="dynamic-template/recent-posts.jsp" />

        <!-- Recent Comments -->
        <jsp:include page="dynamic-template/recent-comments.jsp" />

        <!-- Posts Calendar -->
        <jsp:include page="dynamic-template/calendar.jsp" />

        <!-- Copyright -->
        <div id="copyright">
            <p>
                &copy; 2013 An Untitled Site.<br />
                Images: <a href="http://n33.co">n33</a>, <a href="http://fotogrph.com">fotogrph</a>, <a href="http://iconify.it">Iconify.it</a>
                Design: <a href="http://html5up.net/">HTML5 UP</a>
            </p>
        </div>

    </div>

</div>

</body>
</html>
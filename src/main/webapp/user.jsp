<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>高校毕业生就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="common/jquery/jquery-3.2.1.js"></script>
</head>
<body>
<form id="jump" method="post" action=""></form>
<script>
    $(function () {
        <c:if test="${empty sessionScope.user}">
        $("#jump").attr("action","checkUser.do");
        $("#jump").submit();
        </c:if>
        <c:if test="${not empty sessionScope.user}">
        $("#jump").attr("action","jumpUser.do");
        $("#jump").submit();
        </c:if>
    });
</script>
</body>
</html>

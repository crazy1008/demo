<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="common/jquery/jquery-3.2.1.js"></script>
</head>
<body>
<form id="jump" method="post" action=""></form>
<script>
    $(function () {
        <c:if test="${empty sessionScope.admin}">
        $("#jump").attr("action","checkAdmin.do");
        $("#jump").submit();
        </c:if>
        <c:if test="${not empty sessionScope.admin}">
        $("#jump").attr("action","jumpAdmin.do");
        $("#jump").submit();
        </c:if>
    });
</script>
</body>
</html>

<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>投递信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=basePath%>common/js/loadFile.js" type="text/javascript"></script>
    <link rel='icon' href='<%=basePath%>common/image/school.ico' type='image/x-icon'>
    <link rel="stylesheet" href="<%=basePath%>common/project/school/css/school.css" type="text/css"/>
</head>
<body>
<div class="container-fluid">
    <!--导航条-->
    <nav class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#demo-nav"
                        aria-expanded="false">
                    <span class="sr-only">qc</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                    class="icon-bar"></span>
                </button>
                <a class="navbar-brand pull-left" href="#">投递信息</a>
            </div>
            <div class="collapse navbar-collapse" id="demo-nav">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" onclick="fnBack()" style="color: #337ab7">返回</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="row">
        <div class="col-sm-12">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>公司名称</th>
                    <th>招聘专业</th>
                    <th>招聘岗位</th>
                    <th>招聘人数</th>
                    <th>工作经验</th>
                    <th>工作方向</th>
                    <th>工作性质</th>
                    <th>教育</th>
                    <th>工作方向</th>
                    <th>状态</th>
                </thead>
                <tbody>
                <c:if test="${empty lists.list}">
                <tr>
                    <td colspan="11" class="text-center">没有符合的数据</td>
                <tr>
                    </c:if>
                    <c:if test="${not empty lists.list}">
                    <c:forEach items="${lists.list}" var="employers" varStatus="st">
                <tr>
                    <td>${employers.jobPositionId}</td>
                    <td>${employers.companyName}</td>
                    <td>${employers.jobPositionMajor}</td>
                    <td>${employers.jobPositionName}</td>
                    <td>${employers.jobPositionNumber}</td>
                    <td>${employers.jobPositionExperience}</td>
                    <td>${employers.jobPositionDirection}</td>
                    <td>${employers.jobPositionLocal}</td>
                    <td>${employers.jobPositionEducation}</td>
                    <td>${employers.jobPositionBusiness}</td>
                    <td style="color: #5be624">
                        <c:if test="${not empty employers.openF}">
                        ${employers.openF}
                        </c:if>
                        <c:if test="${empty employers.openF}">
                            待定
                        </c:if>
                    </td>
                </tr>
                </c:forEach>
                </c:if>
                </tbody>
            </table>
            <c:if test="${not empty lists.list}">
                <div class="pull-right" style="margin-top: -20px;">
                    <ul class="pagination" id="pagination1"></ul>
                </div>
            </c:if>
        </div>
    </div>
</div>
<form id="searchForm" action="" method="post">
    <c:if test="${empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="1"/>
        <input type="hidden" id="totalPages" name="totalPages" value="1"/>
    </c:if>
    <c:if test="${not empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="${lists.pageNum }"/>
        <input type="hidden" id="totalPages" name="totalPages" value="${lists.pages}"/>
    </c:if>
</form>
<script>
    $(function () {
        $("#pagination1").jqPaginator({
            totalPages: Number($("#totalPages").val()),
            visiblePages: 4,
            currentPage: Number($("#pageNum").val()),
            prev: '<li class="prev"><a href="javascript:;">previous</a></li>',
            next: '<li class="next"><a href="javascript:;">next</a></li>',
            page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
            onPageChange: function (num, type) {
                if (type == "change") {
                    $("#pageNum").val(num);
                    $("#searchForm").attr("action", "seJobPositionEr.do");
                    $("#searchForm").submit();
                }
            }
        });
    });
    function fnBack() {
        window.history.back();
    }
</script>
</body>
</html>

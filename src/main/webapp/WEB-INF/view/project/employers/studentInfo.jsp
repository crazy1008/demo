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
    <title>用人管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel='icon' href='<%=basePath%>common/image/employers.ico' type='image/x-icon'>
    <script src="<%=basePath%>common/js/loadFile.js" type="text/javascript"></script>
    <link rel="stylesheet" href="<%=basePath%>common/project/employers/css/employers.css" type="text/css"/>
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
                <a class="navbar-brand pull-left" href="#">用人管理</a>
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
                    <th>学校</th>
                    <th>学院</th>
                    <th>专业</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>班级</th>
                    <th>入学时间</th>
                    <th>毕业时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty lists.list}">
                <tr>
                    <td colspan="11" class="text-center">没有符合的数据</td>
                <tr>
                    </c:if>
                    <c:if test="${not empty lists.list}">
                    <c:forEach items="${lists.list}" var="student" varStatus="st">
                <tr>
                    <td>${student.studentId}</td>
                    <td>${student.schoolName}</td>
                    <td>${student.departmentName}</td>
                    <td>${student.majorName}</td>
                    <td>${student.studentNo}</td>
                    <td>${student.studentName}</td>
                    <td>${student.studentSex}</td>
                    <td>${student.studentClass}</td>
                    <td>${student.studentOpenDate}</td>
                    <td>${student.studentExpireDate}</td>
                    <td><c:if test="${empty student.judgeId}">
                        <button type="button" class="btn btn-default" onclick="fnJudge(this)" id="judgeA">合适</button>
                        <button type="button" class="btn btn-default" onclick="fnJudge(this)" id="judgeB">不合适</button>
                    </c:if>
                        <c:if test="${not empty student.judgeId}">
                            <button type="button" class="btn btn-default" id="judgeA" disabled>合适</button>
                            <button type="button" class="btn btn-default" id="judgeB" disabled>不合适</button>
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
        <input type="hidden" id="jobId" value="${jobId}" name="jobId"/>
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
    function fnJudge(obj) {
        var data = {studentId:$(obj).parent().parent().find("td").eq(0).text(),
                    jobPositionId:$("#jobId").val(),
                    judgeAppropriate:$(obj).text()};
        $.post("judgeAppropriate.do",data,function (response) {
                if(response.tip=="success"){
                  window.location.reload();
                }
        },'json');
    }
</script>
</body>
</html>

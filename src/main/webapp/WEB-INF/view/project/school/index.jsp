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
    <title>学校就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=basePath%>common/js/loadFile.js" type="text/javascript"></script>
    <link rel='icon' href='<%=basePath%>common/image/school.ico' type='image/x-icon'>
    <link rel="stylesheet" href="<%=basePath%>common/project/school/css/school.css" type="text/css"/>
    <script type="text/javascript">
        function fnquit() {
            $.post("layout.do", function (response) {
                if (response.tip == "success") {
                    window.location.href = "common.jsp"
                }
            });
        };
        $(function () {
            $("#clear").click(function () {
                $("#searchForm").find("input[type='text']").each(function () {
                    $(this).val('');
                });
            });
            $("#search").click(function () {
                $("#searchForm").attr("action", "search.do");
                $("#searchForm").submit();
            });
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
                        $("#searchForm").attr("action", "searcher.do");
                        $("#searchForm").submit();
                    }
                }
            });
        });

        function fngo(obj) {
            var value = $(obj).text();
            if ("考研" === value) {
                var stateId = $(obj).parent().parent().next().val();
                $("#stateId").val(stateId);
                console.log($("#stateId").val());
                $("#state").attr("action", "postgraduate.do");
                $("#state").submit();
            }
            else if ("就业" === value) {
//                var stateId = $(obj).parent().parent().next().val();
//                $("#stateId").val(stateId);
                $("#studentId").val($(obj).parent().parent().find("td").eq(0).text());
                $("#state").attr("action", "obtainEmployment.do");
                $("#state").submit();
            }
            else if ("创业" == value) {
                var stateId = $(obj).parent().parent().next().val();
                $("#stateId").val(stateId);
                console.log($("#stateId").val());
                $("#state").attr("action", "entrepreneurship.do");
                $("#state").submit();
            }
            else if ("公务员" == value) {
                var stateId = $(obj).parent().parent().next().val();
                $("#stateId").val(stateId);
                console.log($("#stateId").val());
                $("#state").attr("action", "civilServant.do");
                $("#state").submit();
            }
            else if ("参军" == value) {
                var stateId = $(obj).parent().parent().next().val();
                $("#stateId").val(stateId);
                console.log($("#stateId").val());
                $("#state").attr("action", "joinArmy.do");
                $("#state").submit();
            }
        };
        function fnJobInformationById(obj) {
            $("#studentId").val($(obj).text());
            $("#state").attr("action","jobInformationById.do");
            $("#state").submit();
        }
    </script>
</head>

<body style="background-color: #ececdb;">
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
                <a class="navbar-brand pull-left" href="#">学校就业去向管理系统</a>
            </div>
            <div class="collapse navbar-collapse" id="demo-nav">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" onclick="fnquit()" style="color: #337ab7">退出</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="row" style="margin-bottom: 15px;">
        <form class="form-horizontal" action="" method="post" id="searchForm">
            <c:if test="${empty lists.list}">
                <input type="hidden" id="pageNum" name="pageNum" value="1"/>
                <input type="hidden" id="totalPages" name="totalPages" value="1"/>
            </c:if>
            <c:if test="${not empty lists.list}">
                <input type="hidden" id="pageNum" name="pageNum" value="${lists.pageNum }"/>
                <input type="hidden" id="totalPages" name="totalPages" value="${lists.pages }"/>
            </c:if>
            <div class="col-sm-12" style="margin-bottom: 15px;">
                <div class="col-sm-1">
                    <label class="control-label" for="schoolName">用户学校</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="schoolName" type="text" name="schoolName" value="${st.schoolName }"/>
                    </div>
                </div>
                <div class="col-sm-1">
                    <label class="control-label" for="studentNo">用户学号</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="studentNo" type="text" name="studentNo" value="${st.studentNo }"/>
                    </div>
                </div>
                <div class="col-sm-1">
                    <label class="control-label" for="majorName">用户专业</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="majorName" type="text" name="majorName" value="${st.majorName }"/>
                    </div>
                </div>
                <div class="col-sm-1">
                    <label class="control-label" for="departmentName">用户学院</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="departmentName" type="text" name="departmentName" value="${st.departmentName }"/>
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="col-sm-1">
                    <label class="control-label" for="employmentStatusName">用户方向</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="employmentStatusName" type="text" name="employmentStatusName"
                               value="${st.employmentStatusName }"/>
                    </div>
                </div>
                <div class="col-sm-1">
                    <label class="control-label" for="studentName">用户姓名</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="studentName" type="text" name="studentName"
                               value="${st.studentName }"/>
                    </div>
                </div>
                <div class="col-sm-1">
                    <label class="control-label" for="studentSex">用户性别</label>
                </div>
                <div class="col-sm-2">
                    <div class="controls">
                        <input id="studentSex" type="text" name="studentSex"
                               value="${st.studentSex }"/>
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="controls pull-right">
                    <button type="button" class="btn btn-primary" id="clear">清空</button>
                    <button type="button" class="btn btn-primary" id="search">查询</button>
                </div>
            </div>
        </form>
    </div>
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
                    <th>方向</th>
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
                    <td><a href="javascript:void(0)" onclick="fnJobInformationById(this)">${student.studentId}</a></td>
                    <td>${student.schoolName}</td>
                    <td>${student.departmentName}</td>
                    <td>${student.majorName}</td>
                    <td>${student.studentNo}</td>
                    <td>${student.studentName}</td>
                    <td>${student.studentSex}</td>
                    <td>${student.studentClass}</td>
                    <td>${student.studentOpenDate}</td>
                    <td>${student.studentExpireDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${student.employmentStatusId<=5}">
                                <a href="#" onclick="fngo(this)">${student.employmentStatusName}</a>
                            </c:when>
                            <c:when test="${student.employmentStatusId>5}">
                                ${student.employmentStatusName}
                            </c:when>
                        </c:choose>
                    </td>
                </tr>
                <input type="hidden" value="${student.stateId }"/>
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
<form id="state" action="" method="post">
    <input id="stateId" name="stateId" type="hidden" value=""/>
    <input id="studentId" name="studentId" type="hidden" value=""/>
</form>
<form id="lout" action="" method="post">
</form>
</body>
</html>
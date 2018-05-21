<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>学校就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel='icon' href='<%=basePath%>common/image/school.ico' type='image/x-icon'>
    <link rel="stylesheet" href="<%=basePath%>common/project/school/css/school.css" type="text/css"/>
    <script src="<%=basePath%>common/js/loadFile.js" type="text/javascript"></script>
    <style>
        table>thead>tr>th{
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        function back() {
            window.history.back();
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="col-sm-9">
            <button class="btn btn-warning btn-large" type="button" style="margin-bottom: 20px;margin-top: 20px;"
                    onclick="back()">返回
            </button>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>毕业年份</th>
                    <th>公司简介</th>
                    <th>公司名称</th>
                    <th>公司董事长</th>
                    <th>公司环境</th>
                    <th>公司职务</th>
                    <th>公司薪水</th>
                    <th>从事工作</th>
                </tr>
                </thead>
                <tbody>
                     <c:if test="${empty companyList}">
                    <tr>
                        <td colspan="7" class="text-center">没有符合的数据</td>
                    <tr>
                    </c:if>
                    <c:if test="${not empty companyList}">
                    <c:forEach items="${companyList}" var="company">
                <tr class="text-center">
                         <td>
                                 ${company.term }
                         </td>
                    <td>
                            ${company.companyProfile }
                    </td>
                    <td>
                            ${company.companyName }
                    </td>
                    <td>
                            ${company.chairmanCompany }
                    </td>
                    <td>
                            ${company.companyEnvironment }
                    </td>
                    <td>
                            ${company.companyPosition }
                    </td>
                    <td>
                            ${company.companySalary }
                    </td>
                    <td>
                            ${company.engageWork }
                    </td>
                </tr>
                </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: qiaochuang
  Date: 2018/4/23
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>学校就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel='icon' href='<%=basePath%>common/image/school.ico' type='image/x-icon'>
    <style type="text/css">
        .table-bordered>tbody>tr>td {
            border: 1px solid #0c0b0b;
        }
    </style>
    <script src="<%=basePath%>common/js/loadFile.js" type="text/javascript"></script>
    <script type="text/javascript">
        function back(){
            window.history.back();
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="col-sm-6">
            <button class="btn btn-warning btn-large" type="button" style="margin-bottom: 20px;margin-top: 20px;" onclick="back()">返回</button>
            <table class="table table-bordered">
                <thead>
                <tr>
                </tr>
                </thead>
                <tbody>
                <c:if test="${not empty joinArmy }">
                    <tr class="text-center">
                        <td>
                            参军的兵种
                        </td>
                        <td>
                                ${joinArmy.joinArmyMilitaryRegion }
                        </td>

                    </tr>
                    <tr class="text-center">
                        <td>
                            参军的军区
                        </td>
                        <td>
                                ${joinArmy.joinArmyArms }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            参军的直接领导
                        </td>
                        <td>
                                ${joinArmy.joinArmyLeadership }
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>

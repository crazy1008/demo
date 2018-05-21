<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>高校毕业生就业去向管理系统</title>
    <link rel='icon' href='<%=basePath%>common/image/graduate.ico' type='image/x-icon'>
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
                <tbody>
                <c:if test="${not empty student }">
                    <tr class="text-center">
                        <td>
                            学校
                        </td>
                        <td>
                                ${student.schoolName }
                        </td>

                    </tr>
                    <tr class="text-center">
                        <td>
                            学院
                        </td>
                        <td>
                                ${student.departmentName }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            专业
                        </td>
                        <td>
                                ${student.majorName }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            学号
                        </td>
                        <td>
                                ${student.studentNo }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            姓名
                        </td>
                        <td>
                                ${student.studentName }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            性别
                        </td>
                        <td>
                                ${student.studentSex }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            班级
                        </td>
                        <td>
                                ${student.studentClass }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            入学时间
                        </td>
                        <td>
                                ${student.studentOpenDate }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            毕业时间
                        </td>
                        <td>
                                ${student.studentExpireDate }
                        </td>
                    </tr>
                    <tr class="text-center">
                        <td>
                            方向
                        </td>
                        <td>
                                ${student.employmentStatusName }
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

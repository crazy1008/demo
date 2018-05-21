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
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <script src="<%=basePath %>common/js/loadFile.js" type="text/javascript"></script>
    <link href="<%=basePath%>common/project/backstage/iconfont/style.css" type="text/css" rel="stylesheet">
    <link href="<%=basePath%>common/project/backstage/css/backstage.css" type="text/css" rel="stylesheet">
    <link rel='icon' href='<%=basePath%>common/image/panda.ico' type='image/x-icon'>
    <script>
        $(function () {
            $("input").on("input", function () {
                if ($("input").val() == "") {
                    $("#errorUsername").css("display", "none");
                    $("#errorPassword").css("display", "none");
                }
            });
            $("#login").validate({
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入账号",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    $("#errorUsername").css("display", "none");
                    $("#errorPassword").css("display", "none");
                    var data = {
                        username: $("#username").val(),
                        password: $("#password").val()
                    };
                    $.post("admin.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#critical").attr("action", "jumpAdmin.do");
                            $("#critical").submit();
                        }
                        if (response.tip == "error") {
                            $("#errorUsername").css("display", "block");
                            clean();
                        }
                        if (response.tip == "notPassword") {
                            $("#errorPassword").css("display", "block");
                            $("#password").val("");
                        }
                    }, "json");
                }
            });

            function clean() {
                $("#username").val("");
                $("#password").val("");
            }
        });
    </script>
</head>
<body>
<div class="container wrap1" style="height:450px;">
    <div class="col-sm-8 col-md-5 center-auto pd-sm-50 pd-xs-20 main_content">
        <p class="text-center font16">后台管理</p>
        <form id="login" action="" method="post">
            <div class="form-group mg-t20" style="margin-bottom: 10px;">
                <label for="username" class="control-label">用户</label>
                <div>
                    <%--<i class="icon-user icon_font"></i>--%>
                    <%--<i class="fa fa-user fa-lg"></i>--%>
                    <input type="text" class="login_input" id="username" placeholder="请输入用户名" name="username"/>
                        <lable for="username" class="error" style="display: none" id="errorUsername">账户不存在</lable>
                </div>
            </div>
            <div class="form-group mg-t20">
                <label for="password" class="control-label">密码</label>
                <div>
                    <%--<i class="icon-lock icon_font"></i>--%>
                    <%--<i class="fa fa-lock fa-lg"></i>--%>
                    <input type="password" class="login_input" id="password" name="password" placeholder="请输入密码" />
                        <lable for="addPassword" class="error" style="display: none" id="errorPassword">密码不正确</lable>
                </div>
            </div>
            <button type="submit" class="login_btn">登 录</button>
        </form>
    </div><!--row end-->
</div><!--container end-->
<form id="critical" action="" method="post"></form>
</body>
</html>

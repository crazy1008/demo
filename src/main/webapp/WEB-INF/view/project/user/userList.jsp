<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
    <meta charset="utf-8">
    <title>高校毕业生就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=basePath %>common/js/loadFile.js" type="text/javascript"></script>
    <link rel='icon' href='<%=basePath%>common/image/graduate.ico' type='image/x-icon'>
    <link rel="stylesheet" href="<%=basePath %>common/project/user/css/user.css" type="text/css"/>
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
                        username: $("#addUsername").val(),
                        password: $("#addPassword").val()
                    };
                    $.post("user.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#critical").attr("action", "jumpUser.do");
                            $("#critical").submit();
                        }
                        if (response.tip == "error") {
                            $("#errorUsername").css("display", "block");
                            clean();
                        }
                        if (response.tip == "notPassword") {
                            $("#errorPassword").css("display", "block");
                            $("#addPassword").val("");
                        }
                    }, "json");
                }
            });

            function clean() {
                $("#addUsername").val("");
                $("#addPassword").val("");
            }
        });
    </script>
</head>

<body>
<div id="box">
    <h2>高校毕业生就业去向管理系统</h2>
    <form class="form-horizontal" role="form" id="login" action="" method="post">
        <div class="form-group">
            <label for="addUsername" class="control-label">用户</label>
            <div style="width: 200px; margin-left: 31%;">
                <input type="text" class="form-control" id="addUsername" name="username"
                       placeholder="账户" value="">
                <lable for="addUsername" class="error" style="display: none" id="errorUsername">账户不存在</lable>
            </div>
        </div>
        <div class="form-group">
            <label for="addPassword" class="control-label">密码</label>
            <div style="width: 200px; margin-left: 31%;">
                <input type="password" class="form-control" id="addPassword" name="password"
                       placeholder="密码" value="">
                <lable for="addPassword" class="error" style="display: none" id="errorPassword">密码不正确</lable>
            </div>
        </div>
        <div class="form-group text-center">
            <div class="text-center">
                <button type="submit" class="btn btn-default text-center">登录</button>
            </div>
        </div>
    </form>
</div>
<form id="critical" action="" method="post"></form>
</body>
</html>
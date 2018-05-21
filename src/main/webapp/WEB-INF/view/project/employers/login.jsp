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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用人单位</title>
    <link rel='icon' href='<%=basePath%>common/image/employers.ico' type='image/x-icon'>
    <link href="<%=basePath%>common/project/employers/css/default.css" rel="stylesheet" type="text/css" />
    <!--必要样式-->
    <link href="<%=basePath%>common/project/employers/css/styles.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>common/project/employers/css/demo.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>common/project/employers/css/loaders.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class='login' style="padding-bottom: 0px;">
    <div class='login_title'>
        <span>用人登录</span>
    </div>
    <div class='login_fields'>
        <div class='login_fields__user'>
            <div class='icon'>
                <img alt="" src='<%=basePath%>common/project/employers/img/user_icon_copy.png'>
            </div>
            <input name="login" placeholder='用户名' maxlength="16" type='text' autocomplete="off" value=""/>
            <div class='validation'>
                <img alt="" src='<%=basePath%>common/project/employers/img/tick.png'>
            </div>
        </div>
        <div class='login_fields__password'>
            <div class='icon'>
                <img alt="" src='<%=basePath%>common/project/employers/img/lock_icon_copy.png'>
            </div>
            <input name="pwd" placeholder='密码' maxlength="16" type='text' autocomplete="off">
            <div class='validation'>
                <img alt="" src='<%=basePath%>common/project/employers/img/tick.png'>
            </div>
        </div>
        <div class='login_fields__submit'>
            <input type='button' value='登录'>
        </div>
    </div>
</div>
<form id="critical" action="" method="post"></form>
<link href="<%=basePath%>common/project/employers/layui/css/layui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>common/project/employers/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/project/employers/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>common/project/employers/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>common/project/employers/js/Particleground.js"></script>
<script type="text/javascript" src="<%=basePath%>common/project/employers/js/Treatment.js"></script>
<script type="text/javascript" src="<%=basePath%>common/project/employers/js/jquery.mockjax.js"></script>
<script type="text/javascript">
    $('input[name="pwd"]').focus(function () {
        $(this).attr('type', 'password');
    });
    $('input[type="text"]').focus(function () {
        $(this).prev().animate({ 'opacity': '1' }, 200);
    });
    $('input[type="text"],input[type="password"]').blur(function () {
        $(this).prev().animate({ 'opacity': '.5' }, 200);
    });
    $('input[name="login"],input[name="pwd"]').keyup(function () {
        var Len = $(this).val().length;
        if (!$(this).val() == '' && Len >= 5) {
            $(this).next().animate({
                'opacity': '1',
                'right': '30'
            }, 200);
        } else {
            $(this).next().animate({
                'opacity': '0',
                'right': '20'
            }, 200);
        }
    });
    $(document).keypress(function (e) {
        // 回车键事件
        if (e.which == 13) {
            $('input[type="button"]').click();
        }
    });
    layui.use('layer', function () {
        //非空验证
        $('input[type="button"]').click(function () {
            var login = $('input[name="login"]').val();
            var pwd = $('input[name="pwd"]').val();
            var data ={username:$('input[name="login"]').val(),
                password:$('input[name="pwd"]').val()};
            if (login == '') {
                ErroAlert('请输入您的账号');
            } else if (pwd == '') {
                ErroAlert('请输入密码');
            } else {
                $.post("employers.do",data,function (response) {
                    if(response.tip == "success"){
                        $("#critical").attr("action","jumpEmployers.do");
                        $("#critical").submit();
                    }if(response.tip == "error"){
                        ErroAlert("账号不正确");
                    }if(response.tip == "notPassword"){
                        ErroAlert("密码不正确");
                    }
                })
            }
        })
    })
</script>
</body>
</html>


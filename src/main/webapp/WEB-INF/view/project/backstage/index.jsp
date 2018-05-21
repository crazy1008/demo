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
    <link href="<%=basePath%>common/project/backstage/css/index.css" type="text/css" rel="stylesheet">
    <link rel='icon' href='<%=basePath%>common/image/panda.ico' type='image/x-icon'>
    <script>
        $(function () {
//            onLoad();
            $("#close").click(function () {
                clean();
                $("#error").css("display","none");
                validatorAddGraduateForm.resetForm();
                $("#addGraduate").modal('hide');
            });
            $("#addUserClose").click(function () {
                clean();
                $("#user_error").css("display","none");
                validatorAddUserForm.resetForm();
                $("#addUser").modal('hide');
            });
            $("#addEmployersClose").click(function () {
                clean();
                $("#employers_error").css("display","none");
                validatorAddEmployersForm.resetForm();
                $("#addEmployers").modal('hide');
            });
            $("#schoolNameClose").click(function () {
                clean();
                $("#schoolName_error").css("display","none");
                validatorAddSchoolNameForm.resetForm();
                $("#addSchoolName").modal('hide');
            });
            $("#departmentNameClose").click(function () {
                clean();
                $("#departmentName_error").css("display","none");
                validatorAddDepartmentForm.resetForm();
                $("#addDepartment").modal('hide');
            });
            $("#majorNameClose").click(function () {
                clean();
                $("#majorName_error").css("display","none");
                validatorAddMajorForm.resetForm();
                $("#addMajor").modal('hide');
            });
            $("#update_close").click(function () {
                clean();
                validatorAddMajorForm.resetForm();
                $("#updateGraduate").modal('hide');
            });
            $("#updateUser_close").click(function () {
                clean();
                validatorUpdateUserForm.resetForm();
                $("#updateUser").modal('hide');
            });
            $("#updateEmployers_close").click(function () {
                clean();
                validatorUpdateEmployersForm.resetForm();
                $("#updateEmployers").modal('hide');
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
                        var index = $("#openFlg").val();
                        if(Number(index) == 1){
                            $("#excessive").attr("action", "jumpAdmin.do");
                        }
                        if(Number(index) == 2){
                            $("#excessive").attr("action", "seeUser.do");
                        }
                        if(Number(index) == 3){
                            $("#excessive").attr("action", "seeEmployers.do");
                        }
                        $("#excessive").submit();
                    }
                }
            });
            var validatorAddGraduateForm = $("#addGraduateForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#username").val(),
                        password: $("#password").val(),
                    };
                    $.post("checkExists.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#error").css("display","block");
                            $("#password").val("");
                        }
                        if (response.tip == "success") {
                            $.post("addGraduate.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addGraduate").modal("hide");
                                    $("#error").css("display","none");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
            var validatorUpdateGraduateForm = $("#updateGraduateForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#update_username").val(),
                        password: $("#update_password").val(),
                    };
                    $.post("updateGraduate.do", data, function (response) {
                        if(response.tip == "success"){
                            clean();
                            $("updateGraduate").modal('hide');
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorUpdateUserForm = $("#updateUserForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#updateUser_username").val(),
                        password: $("#updateUser_password").val(),
                    };
                    $.post("updateUserPassword.do", data, function (response) {
                        if(response.tip == "success"){
                            clean();
                            $("updateUser").modal('hide');
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorUpdateEmployersForm = $("#updateEmployersForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#updateEmployers_username").val(),
                        password: $("#updateEmployers_password").val(),
                    };
                    $.post("updateEmployers.do", data, function (response) {
                        if(response.tip == "success"){
                            clean();
                            $("updateEmployers").modal('hide');
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorAddUserForm = $("#addUserForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#user_username").val(),
                        password: $("#user_password").val(),
                    };
                    $.post("checkExistsUser.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#user_error").css("display","block");
                            $("#user_password").val("");
                        }
                        if (response.tip == "success") {
                            $.post("add.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addUser").modal("hide");
                                    $("#user_error").css("display","none");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
            var validatorAddEmployersForm = $("#addEmployersForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    username: "required",
                    password: {
                        required: true,
                        minlength: 5
                    },
                },
                messages: {
                    username: "请输入用户",
                    password: {
                        required: "请输入密码",
                        minlength: jQuery.format("密码不能小于{0}个字符")
                    },
                },
                submitHandler: function () {
                    var data = {
                        username: $("#employers_username").val(),
                        password: $("#employers_password").val(),
                    };
                    $.post("checkExistsEmployers.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#employers_error").css("display","block");
                            $("#employers_password").val("");
                        }
                        if (response.tip == "success") {
                            $.post("addEmployers.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addEmployers").modal("hide");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
            var validatorAddSchoolNameForm = $("#addSchoolNameForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    schoolName: "required",
                },
                messages: {
                    schoolName: "请输入学校",
                },
                submitHandler: function () {
                    var data = {
                        schoolName: $("#schoolName").val(),
                    };
                    $.post("checkExistsSchoolName.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#schoolName_error").css("display","block");
                        }
                        if (response.tip == "success") {
                            $.post("addSchoolName.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addSchoolName").modal("hide");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
            var validatorAddDepartmentForm = $("#addDepartmentForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    departmentName: "required",
                },
                messages: {
                    departmentName: "请输入学院",
                },
                submitHandler: function () {
                    var data = {
                        departmentName: $("#departmentName").val(),
                    };
                    $.post("checkExistsDepartment.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#departmentName_error").css("display","block");
                        }
                        if (response.tip == "success") {
                            $.post("addDepartment.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addDepartment").modal("hide");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
            var validatorAddMajorForm = $("#addMajorForm").validate({
                errorPlacement: function(error, element) {
                    $( element )
                        .closest( "form" )
                        .find( "label[for='" + element.attr( "id" ) + "']" )
                        .append( error );
                },
                rules: {
                    majorName: "required",
                },
                messages: {
                    majorName: "请输入专业",
                },
                submitHandler: function () {
                    var data = {
                        majorName: $("#majorName").val(),
                    };
                    $.post("checkExistsMajor.do", data, function (response) {
                        if(response.tip == "error"){
                            $("#majorName_error").css("display","block");
                        }
                        if (response.tip == "success") {
                            $.post("addMajor.do",data,function (response) {
                                if(response.tip == "success"){
                                    $("#addMajor").modal("hide");
                                    clean();
                                    window.location.reload();
                                }
                            },'json');
                        }
                    }, "json");
                }
            });
        });

        function onLoad() {
            $("#excessive").attr("backstage.do");
            $("#excessive").submit();
        }
        function fnAddGraduate() {
            $("#addGraduate").modal({backdrop: "static", keyboard: false});
            $('#addGraduate').modal('show');
        }
        function fnSeeGraduate() {
            $("#excessive").attr("action","jumpAdmin.do");
            $("#excessive").submit();
        }
        function fnAddUser() {
            $("#addUser").modal({backdrop: "static", keyboard: false});
            $('#addUser').modal('show');
        }
        function fnSeeUser() {
            $("#excessive").attr("action","seeUser.do");
            $("#excessive").submit();
        }
        function fnAddEmployers() {
            $("#addEmployers").modal({backdrop: "static", keyboard: false});
            $('#addEmployers').modal('show');
        }
        function fnSeeEmployers() {
            $("#excessive").attr("action","seeEmployers.do");
            $("#excessive").submit();
        }
        function fnAddSchool() {
            $("#addSchoolName").modal({backdrop: "static", keyboard: false});
            $('#addSchoolName').modal('show');
        }

        function fnAddDepartment() {
            $("#addDepartment").modal({backdrop: "static", keyboard: false});
            $('#addDepartment').modal('show');
        }
        function fnAddMajor() {
            $("#addMajor").modal({backdrop: "static", keyboard: false});
            $('#addMajor').modal('show');
        }
        function  fnQuit() {
            $("#quit").attr("action","quitAdmin.do");
            $("#quit").submit();
        }
       function clean() {
           $("#username").val("");
           $("#password").val("");
           $("#user_username").val("");
           $("#user_password").val("");
           $("#employers_username").val("");
           $("#employers_password").val("");
           $("#schoolName").val("");
           $("#departmentName").val("");
           $("#majorName").val("");
           $("#update_username").val("");
           $("#update_password").val("");
       }
       function fnDelete(obj) {
           var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
           console.log(data);
           $.post("delete.do",data,function (response) {
               if(response.tip == "success"){
                   window.location.reload();
               }
           });
       }
       function fnDeleteUser(obj) {
           var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
           $.post("deleteUser.do",data,function(response){
              window.location.reload();
           });
       }
       function fnDeleteEmployers(obj) {
           var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
           $.post("deleteEmployers.do",data,function(response){
               window.location.reload();
           });
       }
       function fnUpdate(obj) {
           var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
           console.log(data);
            $.post("selectById.do",data,function (response) {
                var student = response.tip;
                $("#updateGraduate").each(function () {
                    var input = $(this).find("input[type='text']");
                    $(input).each(function () {
                        var inputValue = $(this);
                        $.each(student,function (index,value) {
                            if(index == $(inputValue).attr("name")){
                                $(inputValue).val(value);
                            }
                        });
                    });
                });
                $("#updateGraduate").modal({backdrop: "static", keyboard: false});
                $('#updateGraduate').modal('show');
            },'json')
       }
        function fnUpdateUese(obj) {
            var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
            console.log(data);
            $.post("selectByUserId.do",data,function (response) {
                var student = response.tip;
                $("#updateUser").each(function () {
                    var input = $(this).find("input[type='text']");
                    $(input).each(function () {
                        var inputValue = $(this);
                        $.each(student,function (index,value) {
                            if(index == $(inputValue).attr("name")){
                                $(inputValue).val(value);
                            }
                        });
                    });
                });
                $("#updateUser").modal({backdrop: "static", keyboard: false});
                $('#updateUser').modal('show');
            },'json')
        }
        function fnUpdateEmployers(obj) {
            var data = {id:$(obj).parent().parent().find("td").eq(0).text()};
            console.log(data);
            $.post("selectByEmployersId.do",data,function (response) {
                var student = response.tip;
                $("#updateEmployers").each(function () {
                    var input = $(this).find("input[type='text']");
                    $(input).each(function () {
                        var inputValue = $(this);
                        $.each(student,function (index,value) {
                            if(index == $(inputValue).attr("name")){
                                $(inputValue).val(value);
                            }
                        });
                    });
                });
                $("#updateEmployers").modal({backdrop: "static", keyboard: false});
                $('#updateEmployers').modal('show');
            },'json')
        }
    </script>
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
            <a class="navbar-brand pull-left" href="#">后台管理系统</a>
        </div>
        <div class="collapse navbar-collapse" id="demo-nav">
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">毕业生<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddGraduate()">添加用户</a></li>
                        <li><a href="#" onclick="fnSeeGraduate()">查看用户</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">学校用户<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddUser()">添加用户</a></li>
                        <li><a href="#" onclick="fnSeeUser()">查看用户</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">用人<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddEmployers()">添加用户</a></li>
                        <li><a href="#" onclick="fnSeeEmployers()">查看用户</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">学校<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddSchool()">添加学校</a></li>
                        <%--<li><a href="#" onclick="fnSeeSchool()">查看学校</a></li>--%>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">学院<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddDepartment()">添加学院</a></li>
                        <%--<li><a href="#" onclick="fnSeeDepartment()">查看学院</a></li>--%>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                       aria-expanded="false">专业<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#" onclick="fnAddMajor()">添加专业</a></li>
                        <%--<li><a href="#" onclick="fnSeeMajor()">查看专业</a></li>--%>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#" onclick="fnQuit()" style="color: #337ab7">退出</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="row">
    <div class="col-sm-8">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>编号</th>
                <th>用户</th>
                <th>密码</th>
                <th>操作</th>
            </thead>
            <tbody>
            <c:if test="${empty lists.list}">
            <tr>
                <td colspan="4" class="text-center">没有符合的数据</td>
            <tr>
                </c:if>
                <c:if test="${not empty lists.list}">
                <c:forEach items="${lists.list}" var="graduate" varStatus="st">
            <tr>
                <td>${graduate.id}</td>
                <td>${graduate.username}</td>
                <td>${graduate.password}</td>
                <td><c:if test="${openFlg == 1}">
                    <button type="button" class="btn btn-default" onclick="fnUpdate(this)">修改</button>
                    <button type="button" class="btn btn-default" onclick="fnDelete(this)">删除</button>
                </c:if>
                    <c:if test="${openFlg == 2}">
                        <button type="button" class="btn btn-default" onclick="fnUpdateUese(this)">修改</button>
                        <button type="button" class="btn btn-default" onclick="fnDeleteUser(this)">删除</button>
                    </c:if>
                    <c:if test="${openFlg == 3}">
                        <button type="button" class="btn btn-default" onclick="fnUpdateEmployers(this)">修改</button>
                        <button type="button" class="btn btn-default" onclick="fnDeleteEmployers(this)">删除</button>
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
<form id="excessive" action="" method="post">
    <c:if test="${empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="1"/>
        <input type="hidden" id="totalPages" name="totalPages" value="1"/>
    </c:if>
    <c:if test="${not empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="${lists.pageNum }"/>
        <input type="hidden" id="totalPages" name="totalPages" value="${lists.pages }"/>
    </c:if>
</form>
<form id="quit" method="post" action=""></form>
<div class="modal fade" id="addGraduate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    添加用户
                </h4>
            </div>
                <div class="modal-body" style="height:200px;">
                    <form id="addGraduateForm" action="" method="post">
                    <div class="form-group col-sm-12">
                    <label for="username" class="control-label col-sm-3">用户</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="username" name="username" value="">
                        <label for="username" id="error" style="display: none;font-size: 12px;">用户已存在</label>
                        <label for="username" class="error"></label>
                    </div>
                    <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                </div>
                    <div class="form-group col-sm-12">
                        <label for="password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="password" name="password" value="">
                            <label for="password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="close">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                    </form>
                </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="updateGraduate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="updateGraduateModalLabel">
                    修改用户
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="updateGraduateForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="update_username" class="control-label col-sm-3">用户</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="update_username" name="username" value="" readonly>
                            <label for="update_username" class="error"></label>
                        </div>
                        <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="update_password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="update_password" name="password" value="">
                            <label for="update_password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="update_close">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            修改
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="updateUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="updateUserModalLabel">
                    修改用户
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="updateUserForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="updateUser_username" class="control-label col-sm-3">用户</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="updateUser_username" name="username" value="" readonly>
                            <label for="updateUser_username" class="error"></label>
                        </div>
                        <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="updateUser_password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="updateUser_password" name="password" value="">
                            <label for="updateUser_password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="updateUser_close">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            修改
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="updateEmployers" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="updateEmployersModalLabel">
                    修改用户
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="updateEmployersForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="updateEmployers_username" class="control-label col-sm-3">用户</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="updateEmployers_username" name="username" value="" readonly>
                            <label for="updateEmployers_username" class="error"></label>
                        </div>
                        <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="updateEmployers_password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="updateEmployers_password" name="password" value="">
                            <label for="updateEmployers_password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="updateEmployers_close">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            修改
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="addUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="addUserModalLabel">
                    添加用户
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="addUserForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="user_username" class="control-label col-sm-3">用户</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="user_username" name="username" value="">
                            <label for="username" id="user_error" style="display: none;font-size: 12px;">用户已存在</label>
                            <label for="user_username" class="error"></label>
                        </div>
                        <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="user_password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="user_password" name="password" value="">
                            <label for="user_password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="addUserClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="addEmployers" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="addEmployersModalLabel">
                    添加用户
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="addEmployersForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="employers_username" class="control-label col-sm-3">用户</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="employers_username" name="username" value="">
                            <label for="username" id="employers_error" style="display: none;font-size: 12px;">用户已存在</label>
                            <label for="employers_username" class="error"></label>
                        </div>
                        <%--<label for="username" class="error" class="col-sm-3"></label>--%>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="employers_password" class="control-label col-sm-3">密码</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="employers_password" name="password" value="">
                            <label for="employers_password" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="addEmployersClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="addSchoolName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="addSchoolNameModalLabel">
                    添加学校
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="addSchoolNameForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="schoolName" class="control-label col-sm-3">学校名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="schoolName" name="schoolName" value="">
                            <label for="schoolName" id="schoolName_error" style="display: none;font-size: 12px;">学校已存在</label>
                            <label for="schoolName" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="schoolNameClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="addDepartment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="addDepartmentModalLabel">
                    添加学院
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="addDepartmentForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="departmentName" class="control-label col-sm-3">学院名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="departmentName" name="departmentName" value="">
                            <label for="departmentName" id="departmentName_error" style="display: none;font-size: 12px;">学院已存在</label>
                            <label for="departmentName" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="departmentNameClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="addMajor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 70%">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title" id="addMajorModalLabel">
                    添加专业
                </h4>
            </div>
            <div class="modal-body" style="height:200px;">
                <form id="addMajorForm" action="" method="post">
                    <div class="form-group col-sm-12">
                        <label for="majorName" class="control-label col-sm-3">专业名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="majorName" name="majorName" value="">
                            <label for="majorName" id="majorName_error" style="display: none;font-size: 12px;">专业已存在</label>
                            <label for="majorName" class="error"></label>
                        </div>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="majorNameClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            添加
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<input type="hidden" id="openFlg" value="${openFlg}">
</body>
</html>

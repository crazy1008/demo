<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>高校毕业生就业去向管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=basePath %>common/js/loadFile.js" type="text/javascript"></script>
    <link rel='icon' href='<%=basePath%>common/image/graduate.ico' type='image/x-icon'>
    <link rel="stylesheet" href="<%=basePath%>common/project/user/css/index.css" type="text/css"/>
    <style>
        #box {
            border: 1px solid #eeeeee;
            height: 210px;
            margin: 10px;
            padding: 10px;
        }

        .title {
            margin-bottom: 50px;
        }

        .bottom-height {
            margin-bottom: 10px;
        }

        a:hover {
            text-decoration: none;
            color: #09c084;
        }
    </style>
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
                        $("#searchForm").attr("action", "jumpUser.do");
                        $("#searchForm").submit();
                    }
                }
            });
            $("#studentOpenDate").on("change", function () {
                var obj = $("#studentOpenDate");
                if ($(obj).value != "") {
                    $(obj).parent().next(".error").css("display", "none");
                }
            });
            $("#studentExpireDate").on("change", function (obj) {
                var obj = $("#studentExpireDate");
                if ($(obj).value != "") {
                    $(obj).parent().next(".error").css("display", "none");
                }
            });
            $('#studentOpenDate').datepicker({format: 'yyyy-mm-dd', language: 'zh-CN', "autoclose": true,});
            $('#studentExpireDate').datepicker({format: 'yyyy-mm-dd', language: 'zh-CN', "autoclose": true,});
            $('#upStudentOpenDate').datepicker({format: 'yyyy-mm-dd', language: 'zh-CN', "autoclose": true,});
            $('#upStudentExpireDate').datepicker({format: 'yyyy-mm-dd', language: 'zh-CN', "autoclose": true,});
            var validator = $("#addForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    schoolName: "required",
                    departmentName: "required",
                    majorName: "required",
                    studentNo: {
                        required: true,
                        number: true
                    },
                    studentName: "required",
                    studentClass: "required",
                    studentSex: "required",
                    studentOpenDate: "required",
                    studentExpireDate: {
                        required: true,
                        compareDate: "#studentOpenDate"
                    },
                    employmentStatusName: "required"


                },
                messages: {
                    schoolName: "请输入学校",
                    departmentName: "请输入学院",
                    majorName: "请输入专业",
                    studentNo: {
                        required: "请输入学号",
                        number: "请输入数字"
                    },
                    studentName: "请输入名字",
                    studentClass: "请输入班级",
                    studentSex: "请输入性别",
                    studentOpenDate: "请输入入学时间",
                    studentExpireDate: {
                        required: "请输入毕业时间",
                        compareDate: "毕业时间必须大于入学时间"
                    },
                    employmentStatusName: "请输入毕业方向",


                },
                submitHandler: function () {
                    var data = {
                        schoolName: $("#schoolName").val(),
                        departmentName: $("#departmentName").val(),
                        majorName: $("#majorName").val(),
                        studentNo: $("#studentNo").val(),
                        studentName: $("#studentName").val(),
                        studentClass: $("#studentClass").val(),
                        studentSex: $("#studentSex").val(),
                        studentOpenDate: $("#studentOpenDate").val(),
                        studentExpireDate: $("#studentExpireDate").val(),
                        employmentStatusName: $("#employmentStatusName").val()
                    };
                    $.post("addUser.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#myModal").modal("hide");
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorUpdateForm = $("#updateForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    schoolName: "required",
                    departmentName: "required",
                    majorName: "required",
                    studentNo: {
                        required: true,
                        number: true
                    },
                    studentName: "required",
                    studentClass: "required",
                    studentSex: "required",
                    studentOpenDate: "required",
                    studentExpireDate: {
                        required: true,
                        compareDate: "#upStudentOpenDate"
                    },
                    employmentStatusName: "required"


                },
                messages: {
                    schoolName: "请输入学校",
                    departmentName: "请输入学院",
                    majorName: "请输入专业",
                    studentNo: {
                        required: "请输入学号",
                        number: "请输入数字"
                    },
                    studentName: "请输入名字",
                    studentClass: "请输入班级",
                    studentSex: "请输入性别",
                    studentOpenDate: "请输入入学时间",
                    studentExpireDate: {
                        required: "请输入毕业时间",
                        compareDate: "毕业时间大小入学时间"
                    },
                    employmentStatusName: "请输入毕业方向",
                },
                submitHandler: function () {
                    var data = {
                        schoolName: $("#upSchoolName").val(),
                        departmentName: $("#upDepartmentName").val(),
                        majorName: $("#upMajorName").val(),
                        studentNo: $("#upStudentNo").val(),
                        studentName: $("#upStudentName").val(),
                        studentClass: $("#upStudentClass").val(),
                        studentSex: $("#upStudentSex").val(),
                        studentOpenDate: $("#upStudentOpenDate").val(),
                        studentExpireDate: $("#upStudentExpireDate").val(),
                        employmentStatusName: $("#upEmploymentStatusName").val()
                    };
                    $.post("updateUser.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#updateModal").modal("hide");
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorEntrepreneurshipForm = $("#entrepreneurshipForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    entrepreneurshipName: "required",
                    entrepreneurshipChairman: "required",
                    entrepreneurshipCeo: "required",
                    entrepreneurshipCto: "required",
                    entrepreneurshipCfo: "required",
                    entrepreneurshipNumber: {
                        required: true,
                        number: true
                    },
                    entrepreneurshipRegisteredCapital: {
                        required: true,
                        number: true
                    },
                    entrepreneurshipDirection: "required"
                },
                messages: {
                    entrepreneurshipName: "请输入公司名称",
                    entrepreneurshipChairman: "请输入公司董事长",
                    entrepreneurshipCeo: "请输入公司ceo",
                    entrepreneurshipCto: "请输入公司cto",
                    entrepreneurshipCfo: "请输入公司cfo",
                    entrepreneurshipNumber: {
                        required: "请输入公司人数",
                        number: "请输入数字"
                    },
                    entrepreneurshipRegisteredCapital: {
                        required: "请输入公司注册金",
                        number: "请输入数字"
                    },
                    entrepreneurshipDirection: "请输入公司从事方向",
                },
                submitHandler: function () {
                    var data = {
                        entrepreneurshipName: $("#entrepreneurshipName").val(),
                        chairmanCompany: $("#entrepreneurshipChairman").val(),
                        entrepreneurshipCeo: $("#entrepreneurshipCeo").val(),
                        entrepreneurshipCto: $("#entrepreneurshipCto").val(),
                        entrepreneurshipCfo: $("#entrepreneurshipCfo").val(),
                        entrepreneurshipNumber: $("#entrepreneurshipNumber").val(),
                        entrepreneurshipRegisteredCapital: $("#entrepreneurshipRegisteredCapital").val(),
                        entrepreneurshipDirection: $("#entrepreneurshipDirection").val(),
                        studentId: $("#studentId").val()
                    };
                    $.post("addEntrepreneurship.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#entrepreneurshipModel").modal('hide');
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            $.validator.addMethod("compareDate", function (value, element, param) {
                var startDate = $(param).val();
                var date1 = new Date(Date.parse(startDate.replace("-", "/")));
                var date2 = new Date(Date.parse(value.replace("-", "/")));
                if (date1 < date2) {
                    return true;
                } else {
                    return false;
                }
            });
            var validatorEmployersForm = $("#employersForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    companyName: "required",
                    chairmanCompany: "required",
                    companyEnvironment: "required",
                    companyPosition: "required",
                    companySalary: {
                        required: true,
                        number: true
                    },
                    engageWork: "required",
                    companyProfile: "required",
                },
                messages: {
                    companyName: "请输入公司名称",
                    chairmanCompany: "请输入公司董事长",
                    companyEnvironment: "请输入公司环境",
                    companyPosition: "请输入公司职位",
                    companySalary: {
                        required: "请输入公司薪水",
                        number: "请输入数字"
                    },
                    engageWork: "请输入从事工作",
                    companyProfile: "请输入公司简介",
                },
                submitHandler: function () {
                    var data = {
                        companyName: $("#companyName").val(),
                        chairmanCompany: $("#chairmanCompany").val(),
                        companyEnvironment: $("#companyEnvironment").val(),
                        companyPosition: $("#companyPosition").val(),
                        companySalary: $("#companySalary").val(),
                        engageWork: $("#engageWork").val(),
                        companyProfile: $("#companyProfile").val(),
                        studentId: $("#studentId").val()
                    };
                    console.log($("#company").val());
                    if ($("#company").val() == "1") {
                        $.post("addCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    } else if ($("#company").val() == "2") {
                        $.post("addTwoCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    } else if ($("#company").val() == "3") {
                        $.post("addThreeCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    } else if ($("#company").val() == "4") {
                        $.post("addFourCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    } else if ($("#company").val() == "5") {
                        $.post("addFiveCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    } else {
                        $.post("addSixCompany.do", data, function (response) {
                            if (response.tip == "success") {
                                $("#employersModel").modal('hide');
                                clean();
                                window.location.reload();
                            }
                        }, "json");
                    }
                }
            });
            var validatorJoinArmyForm = $("#joinArmyForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    joinArmyMilitaryRegion: "required",
                    joinArmyArms: "required",
                    joinArmyLeadership: "required",
                },
                messages: {
                    joinArmyMilitaryRegion: "请输入军种",
                    joinArmyArms: "请输入军区",
                    joinArmyLeadership: "请输入领导",
                },
                submitHandler: function () {
                    var data = {
                        joinArmyMilitaryRegion: $("#joinArmyMilitaryRegion").val(),
                        joinArmyArms: $("#joinArmyArms").val(),
                        joinArmyLeadership: $("#joinArmyLeadership").val(),
                        studentId: $("#studentId").val()
                    };
                    $.post("addJoinArmy.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#joinArmyModel").modal('hide');
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorCivilServantForm = $("#civilServantForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    civilServantLocal: "required",
                    civilServantPosition: "required",
                    civilServantSalary: {
                        required: true,
                        number: true
                    },
                },
                messages: {
                    civilServantLocal: "请输入地区",
                    civilServantPosition: "请输入职业",
                    civilServantSalary: {
                        required: "请输入薪水",
                        number: "请输入数字"
                    },
                },
                submitHandler: function () {
                    var data = {
                        civilServantLocal: $("#civilServantLocal").val(),
                        civilServantPosition: $("#civilServantPosition").val(),
                        civilServantSalary: $("#civilServantSalary").val(),
                        studentId: $("#studentId").val()
                    };
                    $.post("addCivilServant.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#civilServantModel").modal('hide');
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            var validatorPostGraduateForm = $("#postgraduateForm").validate({
                errorPlacement: function (error, element) {
                    $(element)
                        .closest("form")
                        .find("label[for='" + element.attr("id") + "']")
                        .append(error);
                },
                rules: {
                    postgraduateSchool: "required",
                    postgraduateMajor: "required",
                    postgraduateTutor: "required",
                },
                messages: {
                    postgraduateSchool: "请输入学院",
                    postgraduateMajor: "请输入专业",
                    postgraduateTutor: "请输入导师",
                },
                submitHandler: function () {
                    var data = {
                        postgraduateSchool: $("#postgraduateSchool").val(),
                        postgraduateMajor: $("#postgraduateMajor").val(),
                        postgraduateTutor: $("#postgraduateTutor").val(),
                        studentId: $("#studentId").val()
                    };
                    $.post("addPostGraduate.do", data, function (response) {
                        if (response.tip == "success") {
                            $("#postgraduateModel").modal("hide");
                            clean();
                            window.location.reload();
                        }
                    }, "json");
                }
            });
            $("#close").click(function () {
                clean();
                validator.resetForm();
                $("#myModal").modal('hide');
            });
            $("#upClose").click(function () {
                clean();
                validatorUpdateForm.resetForm();
                $("#updateModal").modal('hide');
            });
            $("#employersClose").click(function () {
                clean();
                validatorEmployersForm.resetForm();
                $("#employersModel").modal('hide');
            });
            $("#postgraduateClose").click(function () {
                clean();
                validatorPostGraduateForm.resetForm();
                $("#postgraduateModel").modal('hide');
            });
            $("#joinArmyClose").click(function () {
                clean();
                validatorJoinArmyForm.resetForm();
                $("#joinArmyModel").modal('hide');
            });
            $("#civilServantClose").click(function () {
                clean();
                validatorCivilServantForm.resetForm();
                $("#civilServantModel").modal('hide');
            });
            $("#entrepreneurshipClose").click(function () {
                clean();
                validatorEntrepreneurshipForm.resetForm();
                $("#entrepreneurshipModel").modal('hide');
            });
        });

        function fnAdd() {
            $("#myModal").modal({backdrop: "static", keyboard: false});
            $('#myModal').modal('show');
        };

        function fnTransformation() {
            $("#userForm").attr("action", "updateStudent.do");
            $("#userForm").submit();
        }

        function fnUpdate() {
            $.post("updateStudent.do", {studentId: $("#studentId").val()}, function (response) {
                var student = response.tip;
                $("#updateModal").each(function () {
                    var input = $(this).find("input[type='text']");
                    $(input).each(function () {
                        var inputValue = $(this);
                        $.each(student, function (index, value) {
                            if (index == $(inputValue).attr("name")) {
                                $(inputValue).val(value);
                            }
                        });
                    });
                });
                $("#updateModal").modal({backdrop: "static", keyboard: false});
                $('#updateModal').modal('show');
            }, 'json')
        };

        function fnSee() {
            $("#userForm").attr("action", "seeInformation.do");
            $("#userForm").submit();
        }

        function fnQuit() {
            $("#userForm").attr("action", "userQuit.do");
            $("#userForm").submit();
        }

        function clean() {
            $("#schoolName").val("");
            $("#departmentName").val("");
            $("#majorName").val("");
            $("#studentNo").val("");
            $("#studentName").val("");
            $("#studentClass").val("");
            $("#studentSex").val("");
            $("#studentOpenDate").val("");
            $("#studentExpireDate").val("");
            $("#companySalary").val("");
            $("#companyPosition").val("");
            $("#companyProfile").val("");
            $("#companyName").val("");
            $("#companyEnvironment").val("");
            $("#chairmanCompany").val("");
            $("#engageWork").val("");
            $("#joinArmyMilitaryRegion").val("");
            $("#joinArmyArms").val("");
            $("#joinArmyLeadership").val("");
            $("#civilServantLocal").val("");
            $("#civilServantPosition").val("");
            $("#civilServantSalary").val("");
            $("#postgraduateSchool").val("");
            $("#postgraduateMajor").val("");
            $("#postgraduateTutor").val("");
            $("#entrepreneurshipName").val("");
            $("#entrepreneurshipChairman").val("");
            $("#entrepreneurshipCeo").val("");
            $("#entrepreneurshipCto").val("");
            $("#entrepreneurshipCfo").val("");
            $("#entrepreneurshipNumber").val("");
            $("#entrepreneurshipRegisteredCapital").val("");
            $("#entrepreneurshipDirection").val("");
        }

        function fnEmployers(obj) {
            $("#company").val($(obj).next().val());
            $("#employersModel").modal({backdrop: "static", keyboard: false});
            $("#employersModel").modal('show');
        }

        function fnPostgraduate() {
            $("#postgraduateModel").modal({backdrop: "static", keyboard: false});
            $("#postgraduateModel").modal('show');
        }

        function fnJoinArmy() {
            $("#joinArmyModel").modal({backdrop: "static", keyboard: false});
            $("#joinArmyModel").modal('show');
        }

        function fnCivilServant() {
            $("#civilServantModel").modal({backdrop: "static", keyboard: false});
            $("#civilServantModel").modal('show');
        }

        function fnEntrepreneurship() {
            $("#entrepreneurshipModel").modal({backdrop: "static", keyboard: false});
            $("#entrepreneurshipModel").modal('show');
        }

        function fnCheckDate() {
            var studentOpenDate = $("#studentOpenDate").val();
            var studentExpireDate = $("#studentExpireDate").val();
            var date1 = new Date(Date.parse(studentOpenDate.replace("-", "/")));
            var date2 = new Date(Date.parse(studentExpireDate.replace("-", "/")));
            if (date1 < date2) {
                $("#check").css("display", "none");
            } else {
                $("#check").css("display", "block");
            }
        }

        /*function fnUpCheckDate() {
            var studentOpenDate = $("#upStudentOpenDate").val();
            var studentExpireDate = $("#upStudentExpireDate").val();
            var date1 = new Date(Date.parse(studentOpenDate.replace("-", "/")));
            var date2 = new Date(Date.parse(studentExpireDate.replace("-", "/")));
            if(date1<date2){
                $("#upCheck").css("display","none");
            }else {
                $("#upCheck").css("display","block");
            }
        }
        function fnUpOpenDateCheck() {
            var studentOpenDate = $("#upStudentOpenDate").val();
            var studentExpireDate = $("#upStudentExpireDate").val();
            var date1 = new Date(Date.parse(studentOpenDate.replace("-", "/")));
            var date2 = new Date(Date.parse(studentExpireDate.replace("-", "/")));
            if(date1<date2){
                $("#upOpenDateCheck").css("display","none");
            }else {
                $("#upOpenDateCheck").css("display","block");
            }
        }
        function fnOpenDateCheck() {
            var studentOpenDate = $("#studentOpenDate").val();
            var studentExpireDate = $("#studentExpireDate").val();
            var date1 = new Date(Date.parse(studentOpenDate.replace("-", "/")));
            var date2 = new Date(Date.parse(studentExpireDate.replace("-", "/")));
            if(date1<date2){
                $("#openDateCheck").css("display","none");
            }else {
                $("#openDateCheck").css("display","block");
            }
        }*/
        function fnDelivery(obj) {
            var data = {
                jobId: $(obj).parent().find("input").val(),
                studentId: $("#studentId").val()
            };
            $.post("delivery.do", data, function (response) {
                if (response.tip == "success") {
                    window.location.reload();
                }

            }, 'json');
        }

        function fnResult(obj) {
            $.post("resultModal.do",
                {
                    studentId: $("#studentId").val(),
                    jobId: $(obj).find("input").val()
                },
                function (response) {
                    $("span#result").text(response.tip);
                    $("#resultModal").modal({backdrop: "static", keyboard: false});
                    $('#resultModal').modal('show');
                }, 'json')
        }

        function fnConfirm() {
            $('#resultModal').modal('hide');
        }
    </script>
</head>
<body>
<input type="hidden" value="" id="company">
<form action="" method="post" id="userForm">
    <input type="hidden" id="studentId" name="studentId" value="${sessionScope.studentId}">
</form>
<div class="container-fluid">
    <!--导航条-->
    <nav class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand pull-left" href="#">高校毕业生就业去向管理系统</a>
            </div>
            <div class="collapse navbar-collapse" id="demo-nav">
                <ul class="nav navbar-nav navbar-left">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false"
                           aria-expanded="false">添加去向信息<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li class="dropdown-submenu" disabled="disabled">
                                <c:if test="${empty sessionScope.studentId}">
                                <a href="#" tabindex="-1">就业</a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0)">毕业时</a></li>
                                    <li><a href="javascript:void(0)">毕业3到5个月</a></li>
                                    <li><a href="javascript:void(0)">毕业5个月到一年</a></li>
                                    <li><a href="javascript:void(0)">毕业1年到3年</a></li>
                                    <li><a href="javascript:void(0)">毕业3年到5年</a></li>
                                    <li><a href="javascript:void(0)">毕业5年到10年</a></li>
                                </ul>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                <c:if test="${sessionScope.openG == 1}">
                                <a href="#" style="color: #337ab7;" tabindex="-1">就业</a>
                                <ul class="dropdown-menu pull-right">
                                    <c:if test="${empty student.stateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业时</a>
                                            <input type="hidden" value="1">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.stateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业时</a>
                                            <input type="hidden" value="1">
                                        </li>
                                    </c:if>
                                    <c:if test="${empty student.twoStateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业3到5个月</a>
                                            <input type="hidden" value="2">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.twoStateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业3到5个月</a>
                                            <input type="hidden" value="2">
                                        </li>
                                    </c:if>
                                    <c:if test="${empty student.threeStateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业5个月到一年</a>
                                            <input type="hidden" value="3">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.threeStateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业5个月到一年</a>
                                            <input type="hidden" value="3">
                                        </li>
                                    </c:if>
                                    <c:if test="${empty student.fourStateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业1年到3年</a>
                                            <input type="hidden" value="4">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.fourStateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业1年到3年</a>
                                            <input type="hidden" value="4">
                                        </li>
                                    </c:if>
                                    <c:if test="${empty student.fiveStateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业3年到5年</a>
                                            <input type="hidden" value="5">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.fiveStateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业3年到5年</a>
                                            <input type="hidden" value="5">
                                        </li>
                                    </c:if>
                                    <c:if test="${empty student.sixStateId}">
                                        <li>
                                            <a href="javascript:void(0)" style="color: #337ab7;"
                                               onclick="fnEmployers(this)">毕业5年到10年</a>
                                            <input type="hidden" value="6">
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty student.sixStateId}">
                                        <li>
                                            <a href="javascript:void(0)">毕业5年到10年</a>
                                            <input type="hidden" value="6">
                                        </li>
                                    </c:if>
                                </ul>
                                </c:if>
                                <c:if test="${sessionScope.openG != 1}">
                                <a href="#" tabindex="-1">就业</a>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="javascript:void(0)">毕业时</a></li>
                                    <li><a href="javascript:void(0)">毕业3到5个月</a></li>
                                    <li><a href="javascript:void(0)">毕业5个月到一年</a></li>
                                    <li><a href="javascript:void(0)">毕业1年到3年</a></li>
                                    <li><a href="javascript:void(0)">毕业3年到5年</a></li>
                                    <li><a href="javascript:void(0)">毕业5年到10年</a></li>
                                </ul>
                                </c:if>
                                </c:if>
                            <li>
                                <c:if test="${empty sessionScope.studentId}">
                                    <a href="javascript:void(0);">考研</a>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                    <c:if test="${sessionScope.openG == 2}">
                                        <a href="javascript:void(0);" onclick="fnPostgraduate()"
                                           style="color: #337ab7;">考研</a>
                                    </c:if>
                                    <c:if test="${sessionScope.openG != 2}">
                                        <a href="javascript:void(0);">考研</a>
                                    </c:if>
                                </c:if>
                            </li>
                            <li>
                                <c:if test="${empty sessionScope.studentId}">
                                <a href="javascript:void(0);">参军</a>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                <c:if test="${sessionScope.openG == 3}">
                                <a href="javascript:void(0);" onclick="fnJoinArmy()" style="color: #337ab7;">参军</a>
                                </c:if>
                                <c:if test="${sessionScope.openG != 3}">
                                <a href="javascript:void(0);">参军</a>
                                </c:if>
                                </c:if>
                            <li>
                                <c:if test="${empty sessionScope.studentId}">
                                <a href="javascript:void(0);">公务员</a>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                <c:if test="${sessionScope.openG == 4}">
                                <a href="javascript:void(0);" onclick="fnCivilServant()" style="color: #337ab7;">公务员</a>
                                </c:if>
                                <c:if test="${sessionScope.openG != 4}">
                                <a href="javascript:void(0);">公务员</a>
                                </c:if>
                                </c:if>

                            <li>
                                <c:if test="${empty sessionScope.studentId}">
                                <a href="javascript:void(0);">创业</a>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                <c:if test="${sessionScope.openG == 5}">
                                <a href="javascript:void(0);" onclick="fnEntrepreneurship()"
                                   style="color: #337ab7;">创业</a>
                                </c:if>
                                <c:if test="${sessionScope.openG != 5}">
                                <a href="javascript:void(0);">创业</a>
                                </c:if>
                                </c:if>
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <c:if test="${empty sessionScope.studentId}">
                            <a href="javascript:void(0);" onclick="fnAdd()" style="color: #337ab7;" id="addInformation">添加信息</a>
                        </c:if>
                        <c:if test="${not empty sessionScope.studentId}">
                            <a href="#" id="addInformation">添加信息</a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${empty sessionScope.studentId}">
                            <a href="#" id="updateInformation">修改信息</a>
                        </c:if>
                        <c:if test="${not empty sessionScope.studentId}">
                            <a href="javascript:void(0);" onclick="fnUpdate()" style="color: #337ab7"
                               id="updateInformation">修改信息</a>
                        </c:if>
                    </li>
                    <li>
                        <c:if test="${empty sessionScope.studentId}">
                            <a href="#" id="seeInformation">查看信息</a>
                        </c:if>
                        <c:if test="${not empty sessionScope.studentId}">
                            <a href="javascript:void(0);" onclick="fnSee()" style="color: #337ab7" id="seeInformation">查看信息</a>
                        </c:if>
                    </li>
                    <li><a href="javascript:void(0);" onclick="fnQuit()" style="color: #337ab7">退出</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="row">
        <div class="col-sm-12">
            <c:forEach items="${lists.list}" var="employers" varStatus="st">
                <div class="col-md-2">
                    <div id="box">
                        <div class="title">
                            <div class="bottom-height">
                                <c:if test="${empty sessionScope.studentId}">
                                <span style="font-size:18px;">
                                    <a href="javascript:void(0)">${employers.jobPositionName}
                                        <input type="hidden" name="jobPositionId"
                                               value="${employers.jobPositionId}"/></a></span>
                                </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                            <span style="font-size:18px;"><a href="javascript:void(0)"
                                                             onclick="fnResult(this)">${employers.jobPositionName}
                            <input type="hidden" name="jobPositionId" value="${employers.jobPositionId}"/></a></span>
                                </c:if>
                                <span
                                        style="float: right;font-size: 20px;font-weight: normal;color:red;">${employers.jobSalary}</span>
                            </div>
                            <div>
                                <span style="font-size: 14px;">${employers.jobPositionExperience}</span>/
                                <span style="font-size: 14px;">${employers.jobPositionEducation}</span>/
                                <span style="font-size: 14px;">${employers.jobPositionMajor}</span>
                            </div>
                        </div>
                        <hr size=1 style="border:1px dashed #eeeeee;width:100%">
                        <div class="title">
                            <div class="bottom-height">
                                <span style="font-size: 14px;">${employers.companyName}</span>
                                <span style="font-size: 14px;float: right;">${employers.jobPositionNumber}</span>
                            </div>
                            <div>
                                <span style="font-size: 14px;">${employers.jobPositionBusiness}</span>
                                <span style="float: right">
                                <c:if test="${not empty delivery}">
                                    <c:choose>
                                        <c:when test="${fn:contains(delivery,employers.jobPositionId)}">
                                            <button type="button" class="btn btn-default" style="color: #337ab7"
                                                    disabled>已投递</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-default" style="color: #337ab7"
                                                    onclick="fnDelivery(this)">投递</button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${empty delivery}">
                                    <c:if test="${empty sessionScope.studentId}">
                                        <button type="button" class="btn btn-default" disabled>投递</button>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.studentId}">
                                        <button type="button" class="btn btn-default" style="color: #337ab7"
                                                onclick="fnDelivery(this)" id="delivery">投递</button>
                                    </c:if>
                                </c:if>
                                    <input type="hidden" name="jobPositionId" value="${employers.jobPositionId}"/>
                            </span>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>
            <%--<div class="row">
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
                            <th>操作</th>
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
                            <td><c:if test="${empty sessionScope.studentId}">
                                <a href="javascript:void(0)">${employers.jobPositionId}</a>
                            </c:if>
                                <c:if test="${not empty sessionScope.studentId}">
                                    <a href="javascript:void(0)" onclick="fnResult(this)">${employers.jobPositionId}</a>
                                </c:if></td>
                            <td>${employers.companyName}</td>
                            <td>${employers.jobPositionMajor}</td>
                            <td>${employers.jobPositionName}</td>
                            <td>${employers.jobPositionNumber}</td>
                            <td>${employers.jobPositionExperience}</td>
                            <td>${employers.jobPositionDirection}</td>
                            <td>${employers.jobPositionLocal}</td>
                            <td>${employers.jobPositionEducation}</td>
                            <td>${employers.jobPositionBusiness}</td>
                            <td>
                                <c:if test="${not empty delivery}">
                                    <c:choose>
                                        <c:when test="${fn:contains(delivery,employers.jobPositionId)}">
                                            <button type="button" class="btn btn-default" style="color: #337ab7" disabled>已投递</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-default" style="color: #337ab7" onclick="fnDelivery(this)">投递</button>
                                        </c:otherwise>
                                    </c:choose>
                                    &lt;%&ndash;<c:forEach items="${delivery}" var="value" varStatus="indexValue">
                                        <c:if test="${value != employers.jobPositionId}">
                                            <button type="button" class="btn btn-default" style="color: #337ab7" onclick="fnDelivery(this)">投递</button>
                                        </c:if>
                                        <c:if test="${value == employers.jobPositionId}">
                                            <button type="button" class="btn btn-default" style="color: #337ab7" disabled>已投递</button>
                                        </c:if>
                                    </c:forEach>&ndash;%&gt;
                                </c:if>
                                <c:if test="${empty delivery}">
                                    <c:if test="${empty sessionScope.studentId}">
                                        <button type="button" class="btn btn-default" disabled>投递</button>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.studentId}">
                                        <button type="button" class="btn btn-default" style="color: #337ab7" onclick="fnDelivery(this)" id="delivery">投递</button>
                                    </c:if>
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
            </div>--%>
        </div>
        <div class="col-md-12">
            <c:if test="${not empty lists.list}">
                <div class="text-right">
                    <ul class="pagination" id="pagination1"></ul>
                </div>
            </c:if>
        </div>
        <form id="searchForm" action="" method="post">
            <c:if test="${empty lists.list}">
                <input type="hidden" id="pageNum" name="pageNum" value="1"/>
                <input type="hidden" id="totalPages" name="totalPages" value="1"/>
            </c:if>
            <c:if test="${not empty lists.list}">
                <input type="hidden" id="pageNum" name="pageNum" value="${lists.pageNum }"/>
                <input type="hidden" id="totalPages" name="totalPages" value="${lists.pages }"/>
            </c:if>
        </form>
    </div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 35%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        添加用户信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 550px">
                    <form method="post" id="addForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="schoolName" class="control-label col-sm-3">学校</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="schoolName" name="schoolName" value="">
                            </div>
                            <label for="schoolName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="departmentName" class="control-label col-sm-3">学院</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="departmentName" name="departmentName"
                                       value="">
                            </div>
                            <label for="departmentName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="majorName" class="control-label col-sm-3">专业</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="majorName" name="majorName" value="">
                            </div>
                            <label for="majorName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentNo" class="control-label col-sm-3">学号</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentNo" name="studentNo" value="">
                            </div>
                            <label for="studentNo" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentName" class="control-label col-sm-3">姓名</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentName" name="studentName" value="">
                            </div>
                            <label for="studentName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentSex" class="control-label col-sm-3">性别</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentSex" name="studentSex" value="">
                            </div>
                            <label for="studentSex" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentClass" class="control-label col-sm-3">班级</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentClass" name="studentClass" value="">
                            </div>
                            <label for="studentClass" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentOpenDate" class="control-label col-sm-3">入学时间</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentOpenDate" name="studentOpenDate"
                                       value="" readonly>
                            </div>
                            <%--<label for="studentExpireDate" class="error" class="col-sm-3" id="openDateCheck" style="display: none">入学时间小于毕业时间</label>--%>
                            <label for="studentOpenDate" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="studentExpireDate" class="control-label col-sm-3">毕业时间</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="studentExpireDate" name="studentExpireDate"
                                       value="" readonly>
                            </div>
                            <%--<label for="studentExpireDate" class="error" class="col-sm-3" id="check" style="display: none">毕业时间大于入学时间</label>--%>
                            <label for="studentExpireDate" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="employmentStatusName" class="control-label col-sm-3">方向</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="employmentStatusName"
                                       name="employmentStatusName" value="">
                            </div>
                            <label for="employmentStatusName" class="error" class="col-sm-3"></label>
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
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="joinArmyModel" tabindex="-1" role="dialog" aria-labelledby="joinArmyModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="joinArmyModalLabel">
                        添加用户参军信息
                    </h4>
                </div>
                <div class="modal-body" style="height:250px">
                    <form method="post" id="joinArmyForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="joinArmyMilitaryRegion" class="control-label col-sm-3">军种</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="joinArmyMilitaryRegion"
                                       name="joinArmyMilitaryRegion" value="">
                            </div>
                            <label for="joinArmyMilitaryRegion" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="joinArmyArms" class="control-label col-sm-3">军区</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="joinArmyArms" name="joinArmyArms" value="">
                            </div>
                            <label for="joinArmyArms" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="joinArmyLeadership" class="control-label col-sm-3">领导</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="joinArmyLeadership"
                                       name="joinArmyLeadership" value="">
                            </div>
                            <label for="joinArmyLeadership" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="joinArmyClose">关闭
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
    <div class="modal fade" id="civilServantModel" tabindex="-1" role="dialog" aria-labelledby="civilServantModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="civilServantModalLabel">
                        添加用户公务员信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 250px">
                    <form method="post" id="civilServantForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="civilServantLocal" class="control-label col-sm-3">从事地点</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="civilServantLocal" name="civilServantLocal"
                                       value="">
                            </div>
                            <label for="civilServantLocal" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="civilServantPosition" class="control-label col-sm-3">从事职业</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="civilServantPosition"
                                       name="civilServantPosition" value="">
                            </div>
                            <label for="civilServantPosition" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="civilServantSalary" class="control-label col-sm-3">薪水</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="civilServantSalary"
                                       name="civilServantSalary" value="">
                            </div>
                            <label for="civilServantSalary" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="civilServantClose">关闭
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
    <div class="modal fade" id="entrepreneurshipModel" tabindex="-1" role="dialog"
         aria-labelledby="entrepreneurshipModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="entrepreneurshipModalLabel">
                        添加用户创业信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 500px">
                    <form method="post" id="entrepreneurshipForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipName" class="control-label col-sm-3">公司名称</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipName"
                                       name="entrepreneurshipName" value="">
                            </div>
                            <label for="entrepreneurshipName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipChairman" class="control-label col-sm-3">公司董事长</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipChairman"
                                       name="entrepreneurshipChairman" value="">
                            </div>
                            <label for="entrepreneurshipChairman" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipCeo" class="control-label col-sm-3">公司ceo</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipCeo"
                                       name="entrepreneurshipCeo" value="">
                            </div>
                            <label for="entrepreneurshipCeo" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipCto" class="control-label col-sm-3">公司cto</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipCto"
                                       name="entrepreneurshipCto" value="">
                            </div>
                            <label for="entrepreneurshipCto" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipCfo" class="control-label col-sm-3">公司cfo</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipCfo"
                                       name="entrepreneurshipCfo" value="">
                            </div>
                            <label for="entrepreneurshipCfo" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipNumber" class="control-label col-sm-3">公司人数</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipNumber"
                                       name="entrepreneurshipNumber" value="">
                            </div>
                            <label for="entrepreneurshipNumber" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipRegisteredCapital" class="control-label col-sm-3">公司注册金</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipRegisteredCapital"
                                       name="entrepreneurshipRegisteredCapital" value="">
                            </div>
                            <label for="entrepreneurshipRegisteredCapital" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="entrepreneurshipDirection" class="control-label col-sm-3">公司方向</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="entrepreneurshipDirection"
                                       name="entrepreneurshipDirection" value="">
                            </div>
                            <label for="entrepreneurshipDirection" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="entrepreneurshipClose">关闭
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
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="postgraduateModel" tabindex="-1" role="dialog" aria-labelledby="postgraduateModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="postgraduateModalLabel">
                        添加用户考研信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 250px">
                    <form method="post" id="postgraduateForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="postgraduateSchool" class="control-label col-sm-3">学校</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="postgraduateSchool"
                                       name="postgraduateSchool" value="">
                            </div>
                            <label for="postgraduateSchool" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="postgraduateMajor" class="control-label col-sm-3">专业</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="postgraduateMajor" name="postgraduateMajor"
                                       value="">
                            </div>
                            <label for="postgraduateMajor" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="postgraduateTutor" class="control-label col-sm-3">导师</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="postgraduateTutor" name="postgraduateTutor"
                                       value="">
                            </div>
                            <label for="postgraduateTutor" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="postgraduateClose">关闭
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
    <div class="modal fade" id="employersModel" tabindex="-1" role="dialog" aria-labelledby="employersModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="employersModalLabel">
                        添加用户就业信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 500px">
                    <form method="post" id="employersForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="companyName" class="control-label col-sm-3">公司名称</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="companyName" name="companyName" value="">
                            </div>
                            <label for="companyName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="chairmanCompany" class="control-label col-sm-3">公司董事长</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="chairmanCompany" name="chairmanCompany"
                                       value="">
                            </div>
                            <label for="chairmanCompany" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="companyEnvironment" class="control-label col-sm-3">公司环境</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="companyEnvironment"
                                       name="companyEnvironment" value="">
                            </div>
                            <label for="companyEnvironment" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="companyPosition" class="control-label col-sm-3">公司职务</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="companyPosition" name="companyPosition"
                                       value="">
                            </div>
                            <label for="companyPosition" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="companySalary" class="control-label col-sm-3">公司薪水</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="companySalary" name="companySalary"
                                       value="">
                            </div>
                            <label for="companySalary" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="engageWork" class="control-label col-sm-3">从事工作</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="engageWork" name="engageWork" value="">
                            </div>
                            <label for="engageWork" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="companyProfile" class="control-label col-sm-3">公司简介</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" rows="3" name=companyProfile
                                          id="companyProfile"></textarea>
                                <%--<input type="text" class="form-control" id="companyProfile" name="studentSex" value="">--%>
                            </div>
                            <label for="companyProfile" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="employersClose">关闭
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
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 35%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close">
                        &times;
                    </button>
                    <h4 class="modal-title" id="updateModalLabel">
                        修改用户信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 550px">
                    <form method="post" id="updateForm" action="">
                        <div class="form-group col-sm-12">
                            <label for="upSchoolName" class="control-label col-sm-3">学校</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upSchoolName" name="schoolName" value="">
                            </div>
                            <label for="upSchoolName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upDepartmentName" class="control-label col-sm-3">学院</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upDepartmentName" name="departmentName"
                                       value="">
                            </div>
                            <label for="upDepartmentName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upMajorName" class="control-label col-sm-3">专业</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upMajorName" name="majorName" value="">
                            </div>
                            <label for="upMajorName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentNo" class="control-label col-sm-3">学号</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentNo" name="studentNo" value="">
                            </div>
                            <label for="upStudentNo" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentName" class="control-label col-sm-3">姓名</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentName" name="studentName" value="">
                            </div>
                            <label for="upStudentName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentSex" class="control-label col-sm-3">性别</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentSex" name="studentSex" value="">
                            </div>
                            <label for="upStudentSex" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentClass" class="control-label col-sm-3">班级</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentClass" name="studentClass"
                                       value="">
                            </div>
                            <label for="upStudentClass" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentOpenDate" class="control-label col-sm-3">入学时间</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentOpenDate" name="studentOpenDate"
                                       value="" readonly>
                            </div>
                            <%--<label for="studentExpireDate" class="error" class="col-sm-3" id="upOpenDateCheck" style="display: none">入学时间小于毕业时间</label>--%>
                            <label for="upStudentOpenDate" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upStudentExpireDate" class="control-label col-sm-3">毕业时间</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upStudentExpireDate"
                                       name="studentExpireDate"
                                       value="" readonly>
                            </div>
                            <%--<label for="studentExpireDate" class="error" class="col-sm-3" id="upCheck" style="display: none">毕业时间大于入学时间</label>--%>
                            <label for="upStudentExpireDate" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="form-group col-sm-12">
                            <label for="upEmploymentStatusName" class="control-label col-sm-3">方向</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="upEmploymentStatusName"
                                       name="employmentStatusName" value="">
                            </div>
                            <label for="upEmploymentStatusName" class="error" class="col-sm-3"></label>
                        </div>
                        <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                            <button type="button" class="btn btn-default" id="upClose">关闭
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
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" style="width: 10%;">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-center" id="resultModalLabel">
                        投递反馈信息
                    </h4>
                </div>
                <div class="modal-body" style="height: 50px">
                    <div class="col-sm-12 text-center">
                        <span id="result" style="font-size: 20px;"></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-12 text-center">
                        <button type="button" class="btn btn-primary" onclick="fnConfirm()">
                            确定
                        </button>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>
</body>
</html>

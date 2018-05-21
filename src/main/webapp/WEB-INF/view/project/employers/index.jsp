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
            <ul class="nav navbar-nav navbar-left">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-hidden="false" aria-expanded="false">招聘信息<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="javascript:void(0)" onclick="fnRelease()">发布信息</a></li>
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
                <td>${employers.jobPositionId}</td>
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
                    <button type="button" class="btn btn-default" onclick="fnUpJobPosition(this)">修改</button>
                    <button type="button" class="btn btn-default" onclick="fnDeJobPosition(this)">删除</button>
                    <button type="button" class="btn btn-default" onclick="fnSeJobPosition(this)">查看</button>
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
<!-- 模态框（Modal） -->
<div class="modal fade" id="jobPositionModal" tabindex="-1" role="dialog" aria-labelledby="jobPositionModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="jobPositionModalLabel">
                    发布招聘信息
                </h4>
            </div>
            <div class="modal-body" style="height: 550px">
                <form method="post" id="jobPositionForm" action="">
                    <div class="form-group col-sm-12">
                        <label for="companyName" class="control-label col-sm-3">公司名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="companyName" name="companyName" value="">
                        </div>
                        <label for="companyName" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionMajor" class="control-label col-sm-3">招聘专业</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionMajor" name="jobPositionMajor" value="">
                        </div>
                        <label for="jobPositionMajor" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionName" class="control-label col-sm-3">招聘岗位</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionName" name="jobPositionName" value="">
                        </div>
                        <label for="jobPositionName" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionNumber" class="control-label col-sm-3">招聘人数</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionNumber" name="jobPositionNumber" value="">
                        </div>
                        <label for="jobPositionNumber" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionExperience" class="control-label col-sm-3">工作经验</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionExperience" name="jobPositionExperience" value="">
                        </div>
                        <label for="jobPositionExperience" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionDirection" class="control-label col-sm-3">工作性质</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionDirection" name="jobPositionDirection" value="">
                        </div>
                        <label for="jobPositionDirection" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionLocal" class="control-label col-sm-3">工作地点</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionLocal" name="jobPositionLocal" value="">
                        </div>
                        <label for="jobPositionLocal" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionEducation" class="control-label col-sm-3">教育</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionEducation" name="jobPositionEducation"
                                   value="">
                        </div>
                        <label for="jobPositionEducation" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="jobPositionBusiness" class="control-label col-sm-3">工作方向</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="jobPositionBusiness" name="jobPositionBusiness"
                                   value="">
                        </div>
                        <label for="jobPositionBusiness" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="jobPositionClose">关闭
                        </button>
                        <button type="submit" class="btn btn-primary">
                            发布
                        </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="upJobPositionModal" tabindex="-1" role="dialog" aria-labelledby="upJobPositionModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="upJobPositionModalLabel">
                    发布招聘信息
                </h4>
            </div>
            <div class="modal-body" style="height: 550px">
                <form method="post" id="upJobPositionForm" action="">
                    <div class="form-group col-sm-12">
                        <label for="upCompanyName" class="control-label col-sm-3">公司名称</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upCompanyName" name="companyName" value="">
                        </div>
                        <label for="upCompanyName" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionMajor" class="control-label col-sm-3">招聘专业</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionMajor" name="jobPositionMajor" value="">
                        </div>
                        <label for="upJobPositionMajor" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionName" class="control-label col-sm-3">招聘岗位</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionName" name="jobPositionName" value="">
                        </div>
                        <label for="upJobPositionName" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionNumber" class="control-label col-sm-3">招聘人数</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionNumber" name="jobPositionNumber" value="">
                        </div>
                        <label for="upJobPositionNumber" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionExperience" class="control-label col-sm-3">工作经验</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionExperience" name="jobPositionExperience" value="">
                        </div>
                        <label for="upJobPositionExperience" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionDirection" class="control-label col-sm-3">工作性质</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionDirection" name="jobPositionDirection" value="">
                        </div>
                        <label for="upJobPositionDirection" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionLocal" class="control-label col-sm-3">工作地点</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionLocal" name="jobPositionLocal" value="">
                        </div>
                        <label for="upJobPositionLocal" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionEducation" class="control-label col-sm-3">教育</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionEducation" name="jobPositionEducation"
                                   value="">
                        </div>
                        <label for="upJobPositionEducation" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="form-group col-sm-12">
                        <label for="upJobPositionBusiness" class="control-label col-sm-3">工作方向</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="upJobPositionBusiness" name="jobPositionBusiness"
                                   value="">
                        </div>
                        <label for="upJobPositionBusiness" class="error" class="col-sm-3"></label>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-bottom: 30px;">
                        <button type="button" class="btn btn-default" id="upJobPositionClose">关闭
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
<form id="searchForm" action="" method="post">
    <c:if test="${empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="1"/>
        <input type="hidden" id="totalPages" name="totalPages" value="1"/>
    </c:if>
    <c:if test="${not empty lists.list}">
        <input type="hidden" id="pageNum" name="pageNum" value="${lists.pageNum }"/>
        <input type="hidden" id="totalPages" name="totalPages" value="${lists.pages}"/>
    </c:if>
</form>
<form id = "quit" method="post" action="">
    <input type="hidden" id="jobPositionId" value="" name="jobPositionId">
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
                    $("#searchForm").attr("action", "jumpEmployers.do");
                    $("#searchForm").submit();
                }
            }
        });
        var validatorUpJobPositionForm = $("#upJobPositionForm").validate({
            errorPlacement: function(error, element) {
                $( element )
                    .closest( "form" )
                    .find( "label[for='" + element.attr( "id" ) + "']" )
                    .append( error );
            },
            rules: {
                companyName: "required",
                jobPositionMajor: "required",
                jobPositionName: "required",
                jobPositionNumber: {
                    required:true,
                    number:true
                },
                jobPositionExperience: "required",
                jobPositionDirection: "required",
                jobPositionLocal: "required",
                jobPositionEducation: "required",
                jobPositionBusiness: "required",
            },
            messages: {
                companyName: "请输入公司名称",
                jobPositionMajor: "请输入招聘专业",
                jobPositionName: "请输入招聘岗位",
                jobPositionNumber: {
                    required:"请输入招聘人数",
                    number:"请输入数字"
                },
                jobPositionExperience: "请输入工作经验",
                jobPositionDirection: "请输入工作性质",
                jobPositionLocal: "请输入工作地点",
                jobPositionEducation: "请输入教育",
                jobPositionBusiness: "请输入工作性质",
            },
            submitHandler: function () {
                var data = {
                    jobPositionId: $("#jobPositionId").val(),
                    companyName: $("#upCompanyName").val(),
                    jobPositionMajor: $("#upJobPositionMajor").val(),
                    jobPositionName: $("#upJobPositionName").val(),
                    jobPositionNumber: $("#upJobPositionNumber").val(),
                    jobPositionExperience: $("#upJobPositionExperience").val(),
                    jobPositionDirection: $("#upJobPositionDirection").val(),
                    jobPositionLocal: $("#upJobPositionLocal").val(),
                    jobPositionEducation: $("#upJobPositionEducation").val(),
                    jobPositionBusiness: $("#upJobPositionBusiness").val()

                };
                $.post("upJobPosition.do", data, function (response) {
                    if (response.tip == "success") {
                        clean();
                        $("#upJobPositionModal").modal("hide");
                        window.location.reload();
                    }
                }, "json");
            }
        });
        var validatorJobPositionForm = $("#jobPositionForm").validate({
            errorPlacement: function(error, element) {
                $( element )
                    .closest( "form" )
                    .find( "label[for='" + element.attr( "id" ) + "']" )
                    .append( error );
            },
            rules: {
                companyName: "required",
                jobPositionMajor: "required",
                jobPositionName: "required",
                jobPositionNumber: {
                    required:true,
                    number:true
                },
                jobPositionExperience: "required",
                jobPositionDirection: "required",
                jobPositionLocal: "required",
                jobPositionEducation: "required",
                jobPositionBusiness: "required",
            },
            messages: {
                companyName: "请输入公司名称",
                jobPositionMajor: "请输入招聘专业",
                jobPositionName: "请输入招聘岗位",
                jobPositionNumber: {
                    required:"请输入招聘人数",
                    number:"请输入数字"
                },
                jobPositionExperience: "请输入工作经验",
                jobPositionDirection: "请输入工作性质",
                jobPositionLocal: "请输入工作地点",
                jobPositionEducation: "请输入教育",
                jobPositionBusiness: "请输入工作性质",
            },
            submitHandler: function () {
                var data = {
                    companyName: $("#companyName").val(),
                    jobPositionMajor: $("#jobPositionMajor").val(),
                    jobPositionName: $("#jobPositionName").val(),
                    jobPositionNumber: $("#jobPositionNumber").val(),
                    jobPositionExperience: $("#jobPositionExperience").val(),
                    jobPositionDirection: $("#jobPositionDirection").val(),
                    jobPositionLocal: $("#jobPositionLocal").val(),
                    jobPositionEducation: $("#jobPositionEducation").val(),
                    jobPositionBusiness: $("#jobPositionBusiness").val()

                };
                $.post("addJobPosition.do", data, function (response) {
                    if (response.tip == "success") {
                        clean();
                        $("#jobPositionModal").modal("hide");
                        window.location.reload();
                    }
                }, "json");
            }
        });
        $("#jobPositionClose").click(function () {
            clean();
            validatorJobPositionForm.resetForm();
            $("#jobPositionModal").modal('hide');
        });
        $("#upJobPositionClose").click(function () {
            clean();
            validatorUpJobPositionForm.resetForm();
            $("#upJobPositionModal").modal('hide');
        });
    });
    function fnQuit() {
        $("#quit").attr("action","quitJobPosition.do");
        $("#quit").submit();
    }
    function fnRelease() {
        $("#jobPositionModal").modal({backdrop: "static", keyboard: false});
        $("#jobPositionModal").modal('show');
    }
    function fnUpJobPosition(obj) {
        $("#jobPositionId").val($(obj).parent().parent().find("td").eq(0).text());
        var data ={jobId:$(obj).parent().parent().find("td").eq(0).text()};
        $.post("searchJobPositionById.do",data,function (response) {
            var student = response.tip;
            $("#upJobPositionModal").each(function () {
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
            $("#upJobPositionModal").modal({backdrop: "static", keyboard: false});
            $("#upJobPositionModal").modal('show');
        },'json')
    }
    function fnDeJobPosition(obj) {
        var data ={jobId:$(obj).parent().parent().find("td").eq(0).text()};
        $.post("deJobPosition.do",data,function (response) {
            if(response.tip =="success"){
                window.location.reload();
            }
        });
        
    }
    function clean() {
        var jobPositionForm = $("#jobPositionForm").find("input[type='text']");
        $(jobPositionForm).val("");
        var upJobPositionForm = $("#upJobPositionForm").find("input[type='text']");
        $(upJobPositionForm).val("");
    }
    function fnSeJobPosition(obj) {
        var data = $(obj).parent().parent().find("td").eq(0).text();
        $("#jobPositionId").val(data);
        $("#quit").attr("action","seJobPosition.do")
        $("#quit").submit();
    }
</script>
</body>
</html>

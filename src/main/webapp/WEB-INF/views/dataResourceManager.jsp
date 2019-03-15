<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /*获取工程路径*/
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>

    <title>数据源管理</title>
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function del(dataResourceId) {
            if (confirm("确定要删除该数据源吗？")) {
                $.ajax({
                    url: "<%=basePath%>dataResource/del",
                    type: "post",
                    dataType: "json",
                    data: {dataResourceId: dataResourceId},
                    success: function () {
                        alert("删除成功！");
                        $("#myform").submit();
                    },
                    error: function () {//不知道为什么有时会走error
                        alert("删除成功！");
                        $("#myform").submit();
                    }
                });
            }
        }

        function enableDataResource(dataResourceId) {
            if (confirm("确定要启用该数据源吗？")) {
                $.ajax({
                    url: "<%=basePath%>dataResource/enableDataResource",
                    type: "post",
                    dataType: "json",
                    data: {dataResourceId: dataResourceId},
                    success: function () {
                        alert("启用成功！");
                        $("#myform").submit();
                    },
                    error: function () {//不知道为什么有时会走error
                        alert("启用成功！");
                        $("#myform").submit();
                    }
                });
            }
        }

        function disableDataResource(dataResourceId) {
            if (confirm("确定要停用该数据源吗？")) {
                $.ajax({
                    url: "<%=basePath%>dataResource/disableDataResource",
                    type: "post",
                    dataType: "json",
                    data: {dataResourceId: dataResourceId},
                    success: function () {
                        alert("停用成功！");
                        $("#myform").submit();
                    },
                    error: function () {//不知道为什么有时会走error
                        alert("停用成功！");
                        $("#myform").submit();
                    }
                });
            }
        }

        //主界面高度自适应
        $(function () {
            //top代表顶层窗口对象
            top.mainHeight();
            if ('${msg}' != '') {
                alert('${msg}');
            }

        });

        //查询事件
        function findData() {
            $('#currentPage').val('1');
            document.forms[0].submit();
        }

        //清空查询条件
        function clearP() {
            $("#name").val("");
            $("#loginName").val("");
        }


        function rqst() {
            $.ajax({
                url: "http://172.18.37.167:8080/manager/index",
                type: "post",
                dataType: "json",
                data: {
                    "param": 123456
                },
                success: function (data) {
                    console.log(data);
                }, error: function () {
                    console.log("error");
                }
            })
        }
    </script>
</head>
<body>
<button class="button" id="asdf" onclick="rqst()">ssssssssss</button>
<form class="form-inline" role="form" action="<%=basePath%>dataResource/selectAll" method="post" id="myform">
    <div style="margin-left: 20px; ">
        <div style="margin-left: 20px;display: flow;">
            <img src="<%=basePath%>/img/logos/qianchengwuyou.png" style="margin-left: 80px">

            <img src="<%=basePath%>/img/logos/liepin.png" style="margin-left: 80px">

            <img src="<%=basePath%>/img/logos/zhilianzhaopin.png" style="margin-left: 80px">
            <img src="<%=basePath%>/img/timing.png"
                 style="margin-left: 200px; height: 40px">下次数据自动更新: 2019-3-15 00:00
        </div>


        <hr style="margin-top: 0px;"/>
        <table class="table table-hover">
            <thead>
            <tr style="text-align: center">
                <th style="text-align: center">序号</th>
                <th style="text-align: center">数据源名称</th>
                <th style="text-align: center">数据源类型</th>
                <th style="text-align: center">最近更新</th>
                <th style="text-align: center">当前状态</th>
                <th style="text-align: center">文件名称</th>
                <th style="text-align: center">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${!empty dataResourceList }">
                <c:forEach items="${dataResourceList}" var="dataResource" varStatus="status">
                    <tr class="tableItems" style="text-align: center">
                        <td>${status.index+1}</td>
                        <td>${dataResource.dataResourceName}</td>
                        <td>${dataResource.dataResourceType}</td>
                        <td>${dataResource.lastUpdated}</td>
                        <c:if test="${dataResource.dataResourceStatus=='生效中'}">
                            <td><img src="<%=basePath%>/img/dataResourceActive.png" style="height: 15%" alt="生效中">生效中
                            </td>
                        </c:if>
                        <c:if test="${dataResource.dataResourceStatus=='未生效'}">
                            <td><img src="<%=basePath%>/img/dataResourceInactive.png" style="height: 15%" alt="未生效">未生效
                            </td>
                        </c:if>
                        <td>
                                ${dataResource.dataResourceFileName}
                        </td>
                        <td>
                            <c:if test="${dataResource.dataResourceStatus=='生效中'}">

                                <button type="button" class="btn btn-warning"
                                        onclick="disableDataResource('${dataResource.dataResourceId }')">停用
                                </button>
                            </c:if>
                            <c:if test="${dataResource.dataResourceStatus=='未生效'}">

                                <button type="button" class="btn btn-primary"
                                        onclick="enableDataResource('${dataResource.dataResourceId }')">启用
                                </button>
                            </c:if>
                            <c:if test="${dataResource.dataResourceType!='系统内置'}">
                                <button type="button" class="btn btn-danger"
                                        onclick="del('${dataResource.dataResourceId }')">删除
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <tr class="tableItems" style="text-align: center">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                    <input type="button" data-toggle="modal" data-target="#addModal" class="btn btn-primary"
                           value="新增数据源"/>
                </td>

            </tr>
            </tbody>
        </table>

    </div>
</form>

<form action="<%=basePath%>dataResource/addDataResource" method="post" enctype="multipart/form-data"
      id="register_form1">
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 id="mytitle1" class="modal-title" id="myModalLabel1">
                        新增数据源
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">数据源名称
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" id="roleName1" placeholder="数据源名称"
                               name="dataResourceName" autofocus="autofocus">
                    </div>
                    <div class="form-group">数据源文件上传
                        <i class="fa fa-user fa-lg"></i>
                        <input type="file" name="file">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-info">
                            确认
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </div>
</form>
</body>
</html>
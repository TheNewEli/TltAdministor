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
    </script>
</head>
<body>
<form class="form-inline" role="form" action="<%=basePath%>role/selectAll" method="post" id="myform">
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

                                <button type="button" class="btn btn-danger"
                                        onclick="disableDataResource('${dataResource.dataResourceId }')">停用
                                </button>
                            </c:if>
                            <c:if test="${dataResource.dataResourceStatus=='未生效'}">

                                <button type="button" class="btn btn-primary"
                                        onclick="disableDataResource('${dataResource.dataResourceId }')">启用
                                </button>
                            </c:if>
                            <c:if test="${dataResource.dataResourceType!='系统内置'}">
                                <button type="button" class="btn btn-danger" onclick="del('${dataResource.dataResourceId }')">删除
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
                    <button type="button" class="btn btn-primary" onclick="addDataResource()">
                        新建数据源
                    </button>
                </td>

            </tr>
            </tbody>
        </table>

    </div>
</form>
<div style="text-align: center"><h1>欢迎访问</h1></div>
</body>
</html>
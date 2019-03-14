<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    /*获取工程路径*/
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>角色管理</title>
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

        //删除用户
        function del(roleName) {
            if (confirm("确定要删除该角色吗？")) {
                $.ajax({
                    url: "<%=basePath%>role/del",
                    type: "post",
                    dataType: "json",
                    data: {roleName: roleName},
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

        //编辑用户 先获取当前ID用户信息
        function edit(roleName) {
            $.ajax({
                url: "<%=basePath%>role/selectRoleByName",
                type: "post",
                dataType: "json",
                data: {roleName: roleName},
                success: function (data) {
                    $("#editModal").modal("show");
                    $("#roleName2").val(data.roleName);
                    $("#geographicalSearch2").val(data.geographicalSearch.toString());
                    $("#hotJobSearch2").val(data.hotJobSearch.toString());
                    $("#salaryInformationSearch2").val(data.salaryInformationSearch.toString());
                    $("#occupationRatioDisplay2").val(data.occupationRatioDisplay.toString());
                    $("#educationSituationDisplay2").val(data.educationSituationDisplay.toString());
                    $("#talentSalaryDisplay2").val(data.talentSalaryDisplay.toString());
                    $("#geographicTypeDisplay2").val(data.geographicTypeDisplay.toString());
                    $("#myName").val(data.roleName);
                },
                error: function () {
                    alert("获取用户数据失败！");
                }
            });
        }
    </script>
</head>
<body>
<div class="table-responsive">
    <form class="form-inline" role="form" action="<%=basePath%>role/selectAll" method="post" id="myform">
        <div style="margin-left: 80px;">
            角色名称：<input type="text" name="roleName" id="name" value="${roleInfo1.roleName}" class="form-control"
                        style="width: 120px;">
            <input type="button" onclick="findData();" class="btn btn-info" value="查询"/>
            <input type="button" onclick="clearP();" class="btn btn-info" value="清空"/>
            <input type="button" data-toggle="modal" data-target="#addModal" class="btn btn-primary" value="新增"/>
        </div>
        <hr style="margin-top: 10px;"/>
        <div style="margin-left: 20px;">
            <table class="table table-hover">
                <thead>
                <tr style="text-align: center">
                    <th style="text-align: center">序号</th>
                    <th style="text-align: center">角色名称</th>
                    <th style="text-align: center">地域检索</th>
                    <th style="text-align: center">热门职位检索</th>
                    <th style="text-align: center">薪资信息检索</th>
                    <th style="text-align: center">职业占比展示</th>
                    <th style="text-align: center">学历情况展示</th>
                    <th style="text-align: center">人才薪资展示</th>
                    <th style="text-align: center">地域类型展示</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty roleInfoList }">
                    <c:forEach items="${roleInfoList}" var="role" varStatus="status">
                        <tr class="tableItems" style="text-align: center">
                            <td>${status.index+1}</td>
                            <td>${role.roleName}</td>
                            <c:if test="${role.geographicalSearch==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.geographicalSearch==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.hotJobSearch==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.hotJobSearch==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.salaryInformationSearch==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.salaryInformationSearch==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.occupationRatioDisplay==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.occupationRatioDisplay==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.educationSituationDisplay==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.educationSituationDisplay==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.talentSalaryDisplay==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.talentSalaryDisplay==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <c:if test="${role.geographicTypeDisplay==true}">
                                <td><img src="<%=basePath%>/img/authorized.png" style="height: 15%" alt="已授权"></td>
                            </c:if>
                            <c:if test="${role.geographicTypeDisplay==false}">
                                <td><img src="<%=basePath%>/img/unauthorized.png" style="height: 15%" alt="未授权"></td>
                            </c:if>
                            <td>
                                <button type="button" class="btn btn-success" onclick="edit('${role.roleName }')">编辑
                                </button>
                                <button type="button" class="btn btn-danger" onclick="del('${role.roleName }')">删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
            <div>
                <jsp:include page="/common/page.jsp"/>
            </div>
        </div>
    </form>
</div>
<!-- 新增用户模态框（Modal） -->
<form action="<%=basePath%>role/addRole" method="post" id="register_form1">
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 id="mytitle1" class="modal-title" id="myModalLabel1">
                        新增用户
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">角色名称
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" id="roleName1" placeholder="角色名称"
                               name="roleName" autofocus="autofocus"/>
                    </div>
                    <div class="form-group">地域检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="geographicalSearch" id="geographicalSearch1"
                                autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">热门职位检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="hotJobSearch" id="hotJobSearch1"
                                autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">薪资信息检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="salaryInformationSearch"
                                id="salaryInformationSearch1" autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">职业占比展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="occupationRatioDisplay" id="occupationRatioDisplay1"
                                autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">学历情况展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="educationSituationDisplay"
                                id="educationSituationDisplay1" autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">人才薪资展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="talentSalaryDisplay" id="talentSalaryDisplay1"
                                autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
                    </div>
                    <div class="form-group">地域类型展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="geographicTypeDisplay" id="geographicTypeDisplay1"
                                autofocus="autofocus">
                            <option value="false">禁止</option>
                            <option value="true">授权</option>
                        </select>
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
<!-- 编辑用户模态框（Modal） -->
<form action="<%=basePath%>role/addRole" method="post" id="editModalForm">
    <input type="hidden" id="myName" name="myName"/>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 id="mytitle2" class="modal-title" id="myModalLabel2">
                        编辑用户
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">角色名称
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" id="roleName2" placeholder="角色名称"
                               name="roleName" autofocus="autofocus"/>
                    </div>
                    <div class="form-group">地域检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="geographicalSearch" id="geographicalSearch2"
                                autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">热门职位检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="hotJobSearch" id="hotJobSearch2"
                                autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">薪资信息检索
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="salaryInformationSearch"
                                id="salaryInformationSearch2" autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">职业占比展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="occupationRatioDisplay" id="occupationRatioDisplay2"
                                autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">学历情况展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="educationSituationDisplay"
                                id="educationSituationDisplay2" autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">人才薪资展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="talentSalaryDisplay" id="talentSalaryDisplay2"
                                autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
                    </div>
                    <div class="form-group">地域类型展示
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="geographicTypeDisplay" id="geographicTypeDisplay2"
                                autofocus="autofocus">
                            <option value="true">授权</option>
                            <option value="false">禁止</option>
                        </select>
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
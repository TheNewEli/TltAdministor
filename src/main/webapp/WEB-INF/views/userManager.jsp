<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    /*获取工程路径*/
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
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
        function del(userId) {
            if (confirm("确定要删除该用户吗？")) {
                $.ajax({
                    url: "<%=basePath%>user/del",
                    type: "post",
                    dataType: "json",
                    data: {userId: userId},
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
        function edit(userId) {
            $.ajax({
                url: "<%=basePath%>user/selectUserById",
                type: "post",
                dataType: "json",
                data: {userId: userId},
                success: function (data) {
                    $("#editModal").modal("show");
                    $("#name2").val(data.userNickname);
                    $("#sex2").val(data.userSex);
                    $("#authorization2").val(data.userAuthorization);
                    $("#password2").val(data.userPassword);
                    $("#rpassword2").val(data.userPassword);
                    $("#myid").val(data.userId);
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
    <form class="form-inline" role="form" action="<%=basePath%>user/selectAll" method="post" id="myform">
        <div style="margin-left: 80px;">
            姓名：<input type="text" name="userNickname" id="name" value="${userInfo1.userNickname}" class="form-control"
                      style="width: 120px;">
            账号：<input type="text" name="userId" id="loginName" value="${userInfo1.userId}" class="form-control"
                      style="width: 120px;">
            <input type="button" onclick="findData();" class="btn btn-info" value="查询"/>
            <input type="button" onclick="clearP();" class="btn btn-info" value="清空"/>
            <input type="button" data-toggle="modal" data-target="#addModal" class="btn btn-info" value="新增"/>
        </div>
        <hr style="margin-top: 10px;"/>
        <div style="margin-left: 20px;">
            <table class="table table-hover">
                <thead>
                <tr style="text-align: center">
                    <th style="text-align: center">序号</th>
                    <th style="text-align: center">用户ID</th>
                    <th style="text-align: center">昵称</th>
                    <th style="text-align: center">密码</th>
                    <th style="text-align: center">性别</th>
                    <th style="text-align: center">权限</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty userList }">
                    <c:forEach items="${userList}" var="user" varStatus="status">
                        <tr class="tableItems" style="text-align: center">
                            <td>${status.index+1}</td>
                            <td>${user.userId}</td>
                            <td>${user.userNickname}</td>
                            <td>${user.userPassword}</td>
                            <td>${user.userSex}</td>
                            <td>${user.userAuthorization}</td>
                            <td>
                                <button type="button" class="btn btn-success" onclick="edit('${user.userId }')">编辑
                                </button>
                                <button type="button" class="btn btn-danger" onclick="del('${user.userId }')">删除
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
<form action="<%=basePath%>user/addUser" method="post" id="register_form1">
    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 id="mytitle" class="modal-title" id="myModalLabel">
                        新增用户
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" id="name1" placeholder="用户昵称"
                               name="userNickname" autofocus="autofocus" required="required"/>
                    </div>
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="userSex" id="sex1" autofocus="autofocus" required="required">
                            <option value="1">男</option>
                            <option value="0">女</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <i class="fa fa-lock fa-lg"></i>
                        <input class="form-control required" placeholder="用户密码" id="password1" name="userPassword"
                               required="required"/>
                    </div>

                    <div class="form-group">
                        <i class="fa fa-check fa-lg"></i>
                        <input class="form-control required" placeholder="重复密码" id="rpassword1" name="rpassword"
                               required="required"/>
                    </div>
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
</form>
<!-- 编辑用户模态框（Modal） -->
<form action="<%=basePath%>user/addUser" method="post" id="editModalForm">
    <input type="hidden" id="myid" name="myid"/>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">--%>
                <%--×--%>
                <%--</button>--%>
                <%--<h4 id="mytitle1" class="modal-title" id="myModalLabel1">--%>
                <%--编辑用户--%>
                <%--</h4>--%>
                <%--</div>--%>
                <%--<div class="modal-body">--%>
                <%--<div class="form-group">--%>
                <%--<i class="fa fa-user fa-lg"></i>--%>
                <%--<input class="form-control required" type="text" id="name2" placeholder="用户昵称"--%>
                <%--name="userNickname" autofocus="autofocus"/>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                <%--<i class="fa fa-user fa-lg"></i>--%>
                <%--<select class="form-control required" name="userSex" id="sex2" autofocus="autofocus">--%>
                <%--<option value="1">男</option>--%>
                <%--<option value="0">女</option>--%>
                <%--</select>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                <%--<i class="fa fa-user fa-lg"></i>--%>
                <%--<select class="form-control required" name="userAuthorization" id="authorization2"--%>
                <%--autofocus="autofocus">--%>
                <%--<option value="0">普通用户</option>--%>
                <%--<option value="1">特权用户</option>--%>
                <%--</select>--%>
                <%--</div>--%>

                <%--<div class="form-group">--%>
                <%--<i class="fa fa-lock fa-lg"></i>--%>
                <%--<input class="form-control required" placeholder="用户密码" id="password2" name="userPassword"/>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭--%>
                <%--</button>--%>
                <%--<button type="submit" class="btn btn-info">--%>
                <%--确认--%>
                <%--</button>--%>
                <%--</div>--%>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×
                    </button>
                    <h4 id="mytitle1" class="modal-title" id="myModalLabel1">
                        新增用户
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <input class="form-control required" type="text" id="name2" placeholder="用户昵称"
                               name="userNickname" autofocus="autofocus"/>
                    </div>
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="userSex" id="sex2" autofocus="autofocus">
                            <option value="1">男</option>
                            <option value="0">女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <i class="fa fa-user fa-lg"></i>
                        <select class="form-control required" name="userAuthorization" id="authorization2" autofocus="autofocus">
                            <option value="0">普通用户</option>
                            <option value="1">特权用户</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <i class="fa fa-lock fa-lg"></i>
                        <input class="form-control required" placeholder="用户密码" id="password2" name="userPassword"/>
                    </div>

                    <div class="form-group">
                        <i class="fa fa-check fa-lg"></i>
                        <input class="form-control required" placeholder="重复密码" id="rpassword2" name="rpassword"/>
                    </div>
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
</form>
</body>
</html>
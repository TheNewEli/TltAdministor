<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    /*获取工程路径*/
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>主界面</title>
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#userManager").attr("class","active");
            $("#frm_right").attr("src","<%=basePath%>user/selectAll");
        });

        function menuClick(obj,url){
            if(obj==1){
                $("#userManager").attr("class","active");
                $("#roleManager").attr("class","");
                $("#dataResourceManager").attr("class","");
            }
            if(obj==2){
                $("#roleManager").attr("class","active");
                $("#userManager").attr("class","");
                $("#dataResourceManager").attr("class","");
            }
            if(obj==3){
                $("#dataResourceManager").attr("class","active");
                $("#roleManager").attr("class","");
                $("#userManager").attr("class","");
            }
            $("#frm_right").attr("src",url);
        }

        function loginOut(obj){
            if (confirm('您确定要退出系统吗？')) {
                obj.href = "<%=basePath%>admin/loginOut";
                obj.onclick = "";
                obj.click();
            }
        }
        //主界面自适应高度   这个函数要在frm_right加载完了调用才有用
        function mainHeight() {
            var ifm= document.getElementById("frm_right");
            var subWeb =document.frames ? document.frames["frm_right"].document : ifm.contentDocument;
            if(ifm != null && subWeb != null) {
                var hg=subWeb.body.scrollHeight;
                ifm.height = hg<600?600:hg;
            }
        }
    </script>
</head>
<body>
<%--导航栏和用户信息--%>
<div>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="#">您好:${adminInfo.adminAccount},欢迎登入</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="javascript:void(0)" onclick="loginOut(this)"><span class="glyphicon glyphicon-user"></span> 退出</a></li>
            </ul>
        </div>
    </nav>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#"></a>
            </div>
            <div>
                <ul class="nav navbar-nav" id="top" style="font-size: 16px;">
                    <li id="userManager"><a href="javascript:void(0)" onclick="menuClick(1,'<%=basePath%>user/selectAll')">用户管理</a></li>
                    <li id="roleManager"><a href="javascript:void(0)" onclick="menuClick(2,'<%=basePath%>role/selectAll')">角色管理</a></li>
                    <li id="dataResourceManager"><a href="javascript:void(0)" onclick="menuClick(3,'<%=basePath%>dataResource/selectAll')">数据源管理</a></li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<%--下方主界面--%>
<div style=" text-align: center;height: 100%;">
    <iframe frameborder="0" name="frm_right" id="frm_right"	width="100%" scrolling="no" src="" style="margin:0px auto 0px auto; background-color: white;padding: 0px" ></iframe>
</div>
</body>
</html>
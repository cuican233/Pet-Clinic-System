<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cc.Bean.User"%>
<%@page import="com.cc.Bean.Speciality"%>
<%@page import="com.cc.Bean.Vet"%>
<%@page import="java.util.List"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>客户查询结果页面</title>
    <%--<link href="CSS/styles.css" rel="stylesheet"/>--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <SCRIPT type="text/javascript">
        function confirmDialog()
        {
            if(confirm("确定要删除该客户信息吗?"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    </SCRIPT>
</head>
<body>
    <div id="header"><%@include file="/inc/header.inc" %>
    </div>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>客户姓名</th>
                <th>客户电话</th>
                <th>客户地址</th>
                <th>操作</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <%
            List<User> users = (List<User>) request.getAttribute("users");
            for (User user:users) {
        %>
        <tbody>
            <tr class="result">
                <td><%=user.getName()%></td>
                <td><%=user.getTel()%></td>
                <td><%=user.getAddress()%></td>
                <td><a href="CustomerServlet?id=<%=user.getId() %>">查看</a></td>
                <td><a href="CustomerServlet?mode=delete&cid=<%=user.getId()%>" onclick=" return confirmDialog();">删除</a></td>
                <td><a href="CustomerServlet?mode=modifycustomer&id=<%=user.getId() %>">修改</a></td>
            </tr>
        <%
            }
        %>
            <tr>
                <td><input value="返回" type="button" onclick="location.href='customersearch.jsp'" /></td>
            </tr>
        </tbody>
    </table>

    <h4><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>
    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</body>
</html>

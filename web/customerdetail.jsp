<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.cc.Bean.Pet"%>
<%@page import="com.cc.Bean.User"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>客户详细信息页面</title>
    <%--<link href="CSS/styles.css" rel="stylesheet" />--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <SCRIPT type="text/javascript">
        function confirmDialog()
        {
            if(confirm("确定要删除该宠物信息吗?"))
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
    <div id="header">
        <%@ include file="inc/header.inc"%>
    </div>
        <%
            User user = (User) request.getAttribute("user");
        %>
    <form action="CustomerServlet" method="post" class="form-horizontal" role="form">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">客户姓名：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="name" disabled="disabled" value="<%=user.getName()%>">
            </div>
        </div>
        <div class="form-group">
            <label for="tel" class="col-sm-2 control-label">联系电话：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="tel" disabled="disabled" value="<%=user.getTel()%>">
            </div>
        </div>
        <div class="form-group">
            <label for="address" class="col-sm-2 control-label">家庭地址：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="address" disabled="disabled" value="<%=user.getAddress()%>">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <ul class="nav nav-pills">
                    <li class="nav-item"><button type="button" class="btn btn-default" onclick="location.href='customersearch.jsp'">返回</button></li>
                    <li class="nav-item"><a href="PetServlet?m=toAdd&cid=<%=user.getId()%>&cname=<%=URLEncoder.encode(user.getName(), "utf-8")%>" class="nav-link" title="转到添加新客户页面">添加新宠物</a></li>
                </ul>
            </div>
        </div>
    </form>
    <%--比较request.getAttribute()和request.getAttribute()的区别--%>
        <h4 align="center" style="color:red"><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%><%=request.getParameter("msg") == null ? "" : request.getParameter("msg")%></h4>
        <hr>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>宠物信息</th>
                <th></th>
                <th></th>
                <th>操作</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <%
            for (Pet pet : user.getPets())
            {
        %>
        <tbody>
            <tr>
                <td><img src="<%=pet.getPhoto()%>" width="180px" height="150px"></td>
                <td style="line-height: 150px">姓名:<%=pet.getName()%></td>
                <td style="line-height: 150px">生日:<%=pet.getBirthdate()%></td>
                <td style="line-height: 150px">
                    <a href="PetServlet?m=delete&pid=<%=pet.getId()%>&cid=<%=user.getId()%>" onclick=" return confirmDialog();">删除</a>
                </td>
                <td style="line-height: 150px">
                    <a href="VisitServlet?m=toAdd&customerId=<%=user.getId()%>&petId=<%=pet.getId()%>&petName=<%=URLEncoder.encode(pet.getName(), "UTF-8")%>">添加病例</a>
                </td>
                <td style="line-height: 150px">
                    <a href="VisitServlet?m=showHistory&petId=<%=pet.getId()%>">浏览病例</a>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
   <div id="footer">
       <%@ include  file="inc/footer.inc"%>
   </div>
</body>
</html>

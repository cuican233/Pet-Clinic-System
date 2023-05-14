<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cc.Bean.Pet"%>
<%@page import="com.cc.Bean.User"%>
<%@page import="java.util.List"%>
<%@ page import="com.cc.dao.UserDAO" %>
<%@page import="java.net.URLEncoder"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>宠物查询结果页面</title>
    <%--<link href="CSS/styles.css" rel="stylesheet"/>--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<div>
    <div id="header"><%@include file="/inc/header.inc" %></div>
    <table class="table table-bordered">
        <h4><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>
        <thead>
        <tr>
            <th colspan="2">宠物信息</th>
            <th>就诊管理</th>
            <th></th>
        </tr>
        </thead>
        <%
            List<Pet> pets = (List<Pet>) request.getAttribute("pets");
            for (Pet pet : pets)
            {
                User user = new UserDAO().getById(pet.getOwnerId());

        %>
        <tbody>
            <tr>
                <td><img src="<%=pet.getPhoto()%>" width="180px" height="150px"></td>
                <td class="minWidth" style="line-height: 30px">姓名:<%=pet.getName()%><br/>生日:<%=pet.getBirthdate()%><br/>主人：<%=pet.getOwnerName()%><br/>电话：<%=user.getTel()%><br/>地址：<%=user.getAddress()%></td>
                <td class="minWidth" style="line-height: 150px">
                    <a href="TreatServlet?mode=showResume&petId=<%=pet.getId()%>">查看病例</a>
                </td>
                <td class="minWidth" style="line-height: 150px">
                    <a href="TreatServlet?mode=toAdd&customerId=<%=user.getId()%>&petId=<%=pet.getId()%>&petName=<%=URLEncoder.encode(pet.getName(), "UTF-8")%>">添加病例</a>
                </td>
            </tr>
            <%
                }
            %>
            <td><input value="返回" type="button" onclick="location.href='treatSearch.jsp'" /></td>
        </tbody>

    </table>


    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>

</body>
</html>

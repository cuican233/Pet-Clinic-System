<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cc.Bean.Pet"%>
<%@page import="java.util.List"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>宠物查询结果页面</title>
    <base href="<%=basePath%>">
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

<%
    if(application.getAttribute("counter")==null){
        String counter="0";
        application.setAttribute("counter",counter);
    }
    else{
        int count=Integer.valueOf((String)application.getAttribute("counter")).intValue();
        count++;
        application.setAttribute("counter",count+"");
    }
%>
<body>
<div>
    <div id="header"><%@include file="/inc/header.inc" %></div>
    <h3 style="color: red">该页面共被访问：<%=application.getAttribute("counter")%>次</h3>
    <table class="table table-hover">
        <thead>
            <tr>
                <th align="center">宠物姓名</th>
                <th align="center">宠物生日</th>
                <th align="center">宠物照片</th>
                <th align="center">宠物主人</th>
                <th align="center">操作</th>
                <th></th>
            </tr>
        </thead>
        <%
            List<Pet> pets = (List<Pet>) request.getAttribute("pets");
            for (Pet pet:pets) {
        %>
        <tbody>
            <tr class="result">
                <td style="line-height: 150px"><%=pet.getName()%></td>
                <td style="line-height: 150px"><%=pet.getBirthdate()%></td>
                <td style="line-height: 150px"><img src="<%=pet.getPhoto()%>" width="180px" height="150px"></td>
                <td style="line-height: 150px"><%=pet.getOwnerName()%></td>
                <td style="line-height: 150px"><a href="PetServlet?m=deletePet&petId=<%=pet.getId()%>&petName=<%=pet.getName()%>" onclick=" return confirmDialog();">删除</a></td>
                <td style="line-height: 150px"><a href="PetServlet?m=modifyPet&petId=<%=pet.getId()%>&petName=<%=pet.getName()%>&petOwnerName=<%=pet.getOwnerName()%>">修改</a></td>
            </tr>
            <%
                }
            %>

            <td><input value="返回" type="button" onclick="location.href='petSearch.jsp'" /></td>

        </tbody>

    </table>

    <h4 align="center" style="color:red"><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>
    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>
</body>
</html>

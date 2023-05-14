<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cc.Bean.Visit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="<%=basePath%>">
    <%--<link rel="stylesheet" href="CSS/styles.css">--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>病历查询结果</title>

</head>
<body>
    <div id="container">
        <div id="header">
            <%@ include file="inc/header.inc"%>
        </div>

        <table class="table table-hover">
            <thead>
                <tr>
                    <td width="120">主治医生</td>
                    <td width="120">治疗时间</td>
                    <td width="200">病情描述</td>
                    <td width="200">治疗方案</td>
                </tr>
            </thead>
        <%
            List<Visit> visits = (List<Visit>)request.getAttribute("visits");
            for (Visit v : visits) {
        %>
        <tbody>
        <tr class="result">
            <td width="120">
                <%=v.getVetName() %>
            </td>
            <td width="120">
                <%=v.getVisitdate() %>
            </td>
            <td>
                <%=v.getDescription() %>
            </td>
            <td>
                <%=v.getTreatment() %>
            </td>
        </tr>
        <%
            }
        %>
        <tr class="cols4">
            <td colspan="4"><input type="button" value="返回" onclick="history.back(-1);" /></td>
        </tr>

        <h4 style="color: red"><%=request.getAttribute("msg")==null?"":request.getAttribute("msg") %></h4>

        </tbody>
    </table>

    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>
</body>
</html>

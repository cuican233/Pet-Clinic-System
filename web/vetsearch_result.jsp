<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.cc.Bean.Speciality"%>
<%@page import="com.cc.Bean.Vet"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>医生查询页面</title>
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
<div>
    <div id="header">
        <%@include file="inc/header.inc" %>
    </div>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>姓名</th>
                    <th>专业特长</th>
                    <th>操作</th>
                    <th></th>
                </tr>
            </thead>
            <%
                List<Vet> vets = (List<Vet>) request.getAttribute("vets");
                for (Vet vet : vets) {
            %>
            <tbody>
                <tr>
                    <td><%=vet.getName()%></td>
                        <td>
                            <%
                                for(Speciality spec:vet.getSpecs()){
                            %>
                            <span><%=spec.getName()%></span>
                            <%
                                }
                            %>
                        </td>
                    <td><a href="VetServlet?mode=deleteVet&vetId=<%=vet.getId()%>&vetName=<%=vet.getName()%>" onclick=" return confirmDialog();">删除</a></td>
                    <td><a href="VetServlet?mode=modifyvet&vetId=<%=vet.getId() %>">修改</a></td>
                </tr>
            <%
                }
            %>
            <td><input value="返回" type="button" onclick="history.back(-1)" /></td>
            </tbody>

        </table>
        <h4 align="center" style="color:red"><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>
    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>
</body>
</html>

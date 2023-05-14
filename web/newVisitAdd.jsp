<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cc.Bean.Vet"%>
<%@page import="com.cc.Bean.Speciality"%>
<%@page import="java.util.List"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>宠物病历添加页面</title>
    <%--<link href="CSS/styles.css" rel="stylesheet" />--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<!-- 将各个页面相同的公用代码保存成外部文件 使用静态导入的方式导入到当前页面 方便后期维护 -->
<div id="header">
    <%@include file="inc/header.inc"%>
</div>

<form action="TreatServlet" method="post" class="form-horizontal" role="form">
    <input type="hidden" name="mode" value="saveResume">
    <div class="form-group">
        <label for="pname" class="col-sm-2 control-label">宠物名字：</label>
        <div class="col-sm-7">
            <%--petName, customerId和petId，这三个参数都来自customerdetail.jsp的添加病历链接--%>
            <input type="text" class="form-control" id="pname" name="pname" value="<%=request.getParameter("petName")%>"  disabled="disabled">
            <input type="hidden" name="cid" value="<%=request.getParameter("customerId")%>" />
            <input type="hidden" name="pid" value="<%=request.getParameter("petId")%>" />
        </div>
    </div>
    <div class="form-group">
        <label for="vid" class="col-sm-2 control-label">主治医生：</label>
        <div class="col-sm-7">
            <select name="vid" id="vid" class="form-control">
                <%
                    List<Vet> vets = (List<Vet>) request.getAttribute("vets");
                    if (vets != null)
                    {
                        for (Vet vet : vets)
                        {
                %>
                <option value="<%=vet.getId()%>"><%=vet.getName()%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="description" class="col-sm-2 control-label">病情描述：</label>
        <div class="col-sm-7">
            <textarea name="description" id="description" class="form-control" rows="5"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="treatment" class="col-sm-2 control-label" class="form-control">治疗方案：</label>
        <div class="col-sm-7">
            <textarea name="treatment" id="treatment" class="form-control" rows="5"></textarea>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <ul class="nav nav-pills">
                <li class="nav-item"><button type="submit" class="btn btn-default">保存</button></li>
                <li class="nav-item"><button type="reset" class="btn btn-default">清空</button></li>
                <li class="nav-item"><button type="button" class="btn btn-default" onclick="location.href='treatSearch.jsp'">取消</button></li>
            </ul>
        </div>
    </div>
</form>
<h4><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>

<div id="footer">
    <%@ include  file="inc/footer.inc"%>
</div>

</body>
</html>

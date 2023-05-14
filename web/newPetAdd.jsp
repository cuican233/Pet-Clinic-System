
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.cc.Bean.User"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新宠物添加页面</title>
    <%--<link href="CSS/styles.css" rel="stylesheet" />--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
    <style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function preview(source)//上传图片到服务器之前，先实现图片预览，add by hlzhang, 20180202
        {
            var file = source.files[0];
            if(window.FileReader)
            {
                var fr = new FileReader();
                var portrait = document.getElementById('portrait');
                fr.onloadend = function(e){ portrait.src = e.target.result; };
                fr.readAsDataURL(file);
                portrait.style.display = 'block';
            }
        }
    </script>
</head>
<body>
<div>
    <div id="header">
        <%@include file="inc/header.inc"%>  <!-- 将各个页面相同的公用代码保存成外部文件 使用静态导入的方式导入到当前页面 方便后期维护 -->
    </div>
    <form action="PetServlet" method="post" enctype="multipart/form-data" class="form-horizontal" role="form"> <!-- 文件上传  要修改表单的enctype属性 -->
        <input type="hidden" name="m" value="newPetAdd">

        <div class="form-group">
            <label for="userId" class="col-sm-2 control-label">宠物主人：</label>
            <div class="col-sm-7">
                <select name="userId" id="userId" class="form-control">
                    <option >请选择宠物的主人</option>
                    <%
                        List<User> users = (List<User>) request.getAttribute("users");
                        if (users != null)
                        {
                            for (User user : users)
                            {
                    %>
                    <option value="<%=user.getId()%>"><%=user.getName()%></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">宠物名字：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="name" placeholder="请输入宠物名字" name="name">
            </div>
        </div>
        <div class="form-group">
            <label for="birthdate" class="col-sm-2 control-label">宠物生日：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="birthdate" placeholder="请输入宠物生日" name="birthdate">
            </div>
        </div>
        <div class="form-group">
            <label for="photo" class="col-sm-2 control-label">宠物照片：</label>
            <div class="col-sm-7">
                <input name="photo" type="file" accept="image/*" onchange="preview(this)" class="form-control" id="photo"/>
            </div>
        </div>
        <div class="form-group">
            <label for="portrait" class="col-sm-2 control-label">照片预览：</label>
            <div class="col-sm-7">
                <img id="portrait" src="" style="display:none;" width="200px" height="200px"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <ul class="nav nav-pills">
                    <li class="nav-item"><button type="submit" class="btn btn-default">保存</button></li>
                    <li class="nav-item"><button type="reset" class="btn btn-default" onclick="document.getElementById('portrait').style.display = 'none';">清空</button></li>
                    <li class="nav-item"><button type="button" class="btn btn-default" onclick="location.href='petSearch.jsp'">取消</button></li>
                </ul>
            </div>
        </div>
    </form>
    <h4><%=request.getAttribute("msg") == null ? "" : request.getAttribute("msg")%></h4>
    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>
</body>
</html>

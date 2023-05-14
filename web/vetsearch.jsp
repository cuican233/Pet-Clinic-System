<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>医生查询页面</title>
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
    <div id="header">
        <%@ include  file="inc/header.inc"%>
    </div>

    <form action="VetServlet" method="post" class="form-horizontal" role="form">
        <input type="hidden" name="m" value="search">
        <!-- type="hidden"  隐藏表单控件  用来传递值  这个控件在前台页面不显示 -->

        <div class="form-group">
            <label for="vname" class="col-sm-2 control-label">医生姓名：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="vname" placeholder="请输入姓名" name="vname">
            </div>
        </div>
        <div class="form-group">
            <label for="sname" class="col-sm-2 control-label">所属专业：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="sname" placeholder="专业" name="sname">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <ul class="nav nav-pills">
                    <li class="nav-item"><button type="submit" class="btn btn-default">查询</button></li>
                    <li class="nav-item"><button type="reset" class="btn btn-default">清空</button></li>
                    <li class="nav-item"><a href="VetServlet?mode=newVet" class="nav-link" title="转到添加新医生页面">添加新医生</a></li>
                    <li class="nav-item"><a href="VetServlet?mode=newSpec" class="nav-link" title="转到添加新专业页面">添加新专业</a></li>
                </ul>
            </div>
        </div>
    </form>
    <h4 style="text-align: center"><%=request.getAttribute("msg")==null?"":request.getAttribute("msg") %></h4>

        <br>
        <br>
    <div id="footer">
        <%@ include  file="inc/footer.inc"%>
    </div>
</div>
</body>
</html>

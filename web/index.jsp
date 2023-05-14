<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>爱心宠物诊所系统</title>
  <%--<link href="CSS/styles.css" rel="stylesheet" type="text/css"/>--%>
  <%--<link href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css" rel="stylesheet">--%>
  <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>--%>
  <%--<style>.bd-placeholder-img{font-size:1.125rem;text-anchor:middle;-webkit-user-select:none;-moz-user-select:none;user-select:none}@media (min-width:768px){.bd-placeholder-img-lg{font-size:3.5rem}}.b-example-divider{height:3rem;background-color:rgba(0,0,0,.1);border:solid rgba(0,0,0,.15);border-width:1px 0;box-shadow:inset 0 .5em 1.5em rgba(0,0,0,.1),inset 0 .125em .5em rgba(0,0,0,.15)}.form-control-dark{color:#fff;background-color:var(--bs-dark);border-color:var(--bs-gray)}.form-control-dark:focus{color:#fff;background-color:var(--bs-dark);border-color:#fff;box-shadow:0 0 0 .25rem rgba(255,255,255,.25)}.bi{vertical-align:-.125em;fill:currentColor}.text-small{font-size:85%}.dropdown-toggle{outline:0}</style>--%>
  <link href="favicon.ico" rel="shortcut icon" />
  <link href="https://cdn.bootcss.com/twitter-bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style=" background: url(https://img.zcool.cn/community/0119075db53a56a801209e1fb4eadc.jpg@1280w_1l_2o_100sh.jpg) no-repeat center center fixed; background-size: 100%;">


<div class="modal-dialog" style="margin-top: 10%;text-align: center">
    <div class="modal-content">
        <div class="modal-header" style="text-align: center">
            <h4 class="modal-title text-center" id="myModalLabel">登录</h4>
        </div>
        <form action="LoginServlet" method="post">
            <div class="modal-body" id = "model-body" style="text-align: center">
                <div class="form-group">

                    <input type="text" class="form-control"placeholder="用户名" autocomplete="off" name="username">
                </div>
                <div class="form-group">

                    <input type="password" class="form-control" placeholder="密码" autocomplete="off" name="pwd">
                </div>
                <div class="form-group">

                    <input type="text" class="form-control" placeholder="验证码" autocomplete="off" name="usercode">
                </div>
                <div class="form-group">
                    <h4 class="modal-title text-left" id="yanzheng">点击刷新：<img src="CheckCode" onclick="this.src='CheckCode?rand='+Math.random()" width="100" height="45"/></h4>
                </div>

            </div>

            <div class="modal-footer">
                <div class="form-group">
                    <button type="submit" class="btn btn-primary form-control">登录</button>
                </div>
                <div class="form-group">
                    <button type="reset" class="btn btn-primary form-control">重置</button>
                </div>
            </div>

        </form>

    </div><!-- /.modal-content -->
</div><!-- /.modal -->
<h4><%=request.getAttribute("msg")==null?"":request.getAttribute("msg") %>
    <%=request.getParameter("para")==null?"":request.getParameter("para") %>
</h4>

<div id="footer">
    <%@ include  file="inc/footer.inc"%>
</div>

</body>

</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'counter.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

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
This is my JSP page. <br>

该网站共被访问：<%=application.getAttribute("counter") %>次。
</body>
</html>
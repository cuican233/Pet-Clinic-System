package com.cc.utils;

//import javax.servlet.*;
import com.cc.Bean.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

//@WebFilter(filterName = "AuthenticFilter")
@WebFilter("/*")
public class AuthenticFilter implements Filter
{
    private static final List<String> adminAuths = new ArrayList<>();

    static
    {
        adminAuths.add("/index.jsp");

        adminAuths.add("/vetsearch_result.jsp");
        adminAuths.add("/vetsearch.jsp");
        adminAuths.add("/vetadd.jsp");
        adminAuths.add("/modifyVet.jsp");

        adminAuths.add("/customersearch.jsp");
        adminAuths.add("/customersearch_result.jsp");
        adminAuths.add("/customerdetail.jsp");
        adminAuths.add("/customeradd.jsp");

        adminAuths.add("/petSearch.jsp");
        adminAuths.add("/petSearchResult.jsp");
        adminAuths.add("/newPetAdd.jsp");

        adminAuths.add("/treatSearch.jsp");
        adminAuths.add("/treatSearchResult.jsp");
        adminAuths.add("/newVisitadd.jsp");
    }
    public void destroy()
    {
        System.out.println("身份验证过滤器已销毁");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException
    {
        HttpServletRequest httpreq = (HttpServletRequest) request;
        HttpSession session = httpreq.getSession(true);
        String requestURI = httpreq.getRequestURI();
        requestURI = requestURI.substring(requestURI.lastIndexOf("/"));
        System.out.println("身份验证过滤器URI：" + requestURI);
        if (adminAuths.contains(requestURI))
        {
            User user = (User) session.getAttribute("user");
            if (user == null)
            {
                request.setAttribute("msg", "请先登录");
                request.getRequestDispatcher("/index.jsp").forward(httpreq, response);
                System.out.println("请先登录");
            }
            else if (user.getRole().equals("admin"))
            {
                System.out.println("当前登录用户是系统管理员");
                chain.doFilter(request, response);
            }
            else
                {
                request.setAttribute("msg", "对不起,该页面只有管理员能够访问");
                System.out.println("对不起,该页面只有管理员能够访问");
                request.getRequestDispatcher("/index.jsp").forward(httpreq, response);
            }
        }
        else
        {
            chain.doFilter(request, response);
        }
    }

    public void init(FilterConfig config) {
        System.out.println("身份验证过滤器启动");
    }

}

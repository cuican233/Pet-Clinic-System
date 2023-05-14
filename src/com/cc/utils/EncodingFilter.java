package com.cc.utils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

//@WebFilter(filterName = "EncodingFilter")
@WebFilter("/*")
public class EncodingFilter implements Filter {
    public void destroy()
    {
        System.out.println("中文编码验证过滤器销毁");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException
    {
        request.setCharacterEncoding("utf-8");
//        System.out.println(((HttpServletRequest) request).getRequestURI());
        chain.doFilter(request, response);
    }

    public void init(FilterConfig config) {
        System.out.println("中文编码过滤器启动");
    }
}

package com.cc.servlet;

import com.cc.Bean.Speciality;
import com.cc.Bean.Vet;
import com.cc.dao.SpecialityDAO;
import com.cc.dao.VetDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VetServlet")
//Vets Management Servlet
public class VetServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        //doPost方法会被多个表单调用 ,查询医生,增加医生,增加专业  因此这里需要根据不同表单传递的标示参数调用不同的方法
        String m = request.getParameter("m");
        request.setCharacterEncoding("utf-8");
        if("search".equals(m))
        {
            search(request, response);
        }
        else if("addVet".equals(m))
        {
            addVet(request, response);
        }
        else if("addSpec".equals(m))
        {
            addSpec(request, response);
        }
        else if("modify".equals(m))
        {
            modify(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {

            String mode = request.getParameter("mode");//获得从vetsearch.jsp或vetsearch_result.jsp的超链接传递来的mode参数
            if("newVet".equals(mode))
            {
                request.setAttribute("specs", new SpecialityDAO().getAll());
                request.getRequestDispatcher("/vetadd.jsp").forward(request, response);
            }
            else if("deleteVet".equals(mode))
            {
                new VetDAO().delete(Integer.parseInt(request.getParameter("vetId")));
                request.setAttribute("msg", "成功删除医生："+request.getParameter("vetName"));
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
            else if("newSpec".equals(mode))
            {
                request.getRequestDispatcher("/specialityAdd.jsp").forward(request, response);
            }
            else if("modifyvet".equals(mode))
            {
                modifyVet(request, response);
            }
            else
            {
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
        }
    }

    private void addVet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
    {
        //这里需要根据表单封装一个Vet   表单里有医生名  专业id下拉列表
        Vet vet=new Vet();
        //根据下拉列表封装多个专业
        request.setCharacterEncoding("UTF-8");
        String[] sids = request.getParameterValues("sid");
        String vname = request.getParameter("vname");
        System.out.println(vname);
        if("".equals(vname))
        {
            request.setAttribute("msg", "请输入医生姓名");
            //虽然要返回的vetadd.jsp提示消息 但是不能直接转发到vetadd.jsp  因为vetadd.jsp需要专业集合显示数据
            doGet(request, response);
        }
        else if(null==sids || 0==sids.length)
        {
            request.setAttribute("msg", "请选择专业");
            doGet(request, response);
        }
        else
        {
            vet.setName(vname);
            for(String sid:sids)
            {
                Speciality s=new Speciality();
                s.setId(Integer.parseInt(sid));
                vet.getSpecs().add(s);
            }
            try
            {
                new VetDAO().save(vet);
                request.setAttribute("msg", "添加成功");
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
            catch (Exception e)
            {
                request.setAttribute("msg",e.getMessage());
                doGet(request,response);
            }
        }

    }

    private void addSpec(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
    {
        request.setCharacterEncoding("utf-8");
        Speciality spec = new Speciality();
        String specName = request.getParameter("specName");
        String specDesc = request.getParameter("specDesc");
        if("".equals(specName))
        {
            request.setAttribute("msg", "请输入专业名称");
		    request.getRequestDispatcher("/specialityAdd.jsp").forward(request, response);
        }
        else
        {
            spec.setName(specName);
            spec.setDesc(specDesc);
            try
            {
                new SpecialityDAO().save(spec);
                request.setAttribute("msg", "添加成功");
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
            catch (Exception e)
            {
                request.setAttribute("msg",e.getMessage());
                doGet(request,response);
            }
        }

    }

    private void search(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
    {
        String vname=request.getParameter("vname");
        String sname=request.getParameter("sname");
        try
        {
            List<Vet> vets=new VetDAO().search(vname, sname);
            if(0==vets.size())
            {
                request.setAttribute("msg", "没有相关医生信息");
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
            else
            {
                request.setAttribute("vets", vets);
                request.getRequestDispatcher("/vetsearch_result.jsp").forward(request, response);
            }
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
        }
    }

    private void modifyVet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try
        {
            VetDAO vetDAO = new VetDAO();
            int vetid = Integer.parseInt(request.getParameter("vetId"));//得到vetsearch_result.jsp的“修改”链接发送来的参数客户id
            Vet vet = vetDAO.getById(vetid);
            request.setAttribute("vets", vet);
            request.setAttribute("specs", new SpecialityDAO().getAll());
            request.getRequestDispatcher("/modifyVet.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
        }
    }

    private void modify(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
    {
        //这里需要根据表单封装一个Vet   表单里有医生名  专业id下拉列表
        Vet vet=new Vet();
        //根据下拉列表封装多个专业
        String[] sids = request.getParameterValues("sid");
        String vname = request.getParameter("vname");
        System.out.println(vname);
        if(null==sids || 0==sids.length)
        {
            request.setAttribute("msg", "请选择专业");
            doGet(request, response);
        }
        else
        {
            vet.setName(vname);
            for(String sid:sids)
            {
                Speciality s=new Speciality();
                s.setId(Integer.parseInt(sid));
                vet.getSpecs().add(s);
            }
            try
            {
                new VetDAO().update(vet);
                request.setAttribute("msg", "修改成功");
                request.getRequestDispatcher("/vetsearch.jsp").forward(request, response);
            }
            catch (Exception e)
            {
                request.setAttribute("msg",e.getMessage());
                doGet(request,response);
            }
        }

    }

}

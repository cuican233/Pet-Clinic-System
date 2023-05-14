package com.cc.servlet;

import com.cc.Bean.Pet;
import com.cc.Bean.User;
import com.cc.dao.UserDAO;
import com.cc.dao.PetDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        String mode = request.getParameter("mode");//获得传递来的mode参数，只有添加宠物成功后，才会有从PetServlet传递来的mode参数
        System.out.println(mode);
        if("savePet".equals(mode))//如果mode的值等于"savePet"，说明是请求是来自PetServlet添加宠物成功后，
            // 再sendRedirect到customerdetail.jsp，才触发了DoGet(0；
        {
            afterSavePet(request, response);
        }
        else if("saveVisit".equals(mode))//如果mode的值等于"saveVisit"，说明是请求是来自VisitServlet添加病历成功后，
            // 再sendRedirect到customerdetail.jsp
        {
            afterSaveVisit(request, response);
        }
        else if("delete".equals(mode))//如果mode的值等于"delete"，说明请求是来自customerserarch_result.jsp的“删除客户”链接
        {
            deleteCustomer(request, response);
        }
        else if("modifycustomer".equals(mode))
        {
            modifyCustomer(request, response);
        }
        else//如果mode的值等于null,说明是请求是来自customerserarch_result.jsp的“查看明细”链接
        {
            showDetail(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String m=request.getParameter("m");
        if("search".equals(m))//查询已有客户，来自于customersearch.jsp提交的表单
        {
            searchCustomer(request, response);
        }
        else if("save".equals(m))//保存新的客户，来自于customeradd.jsp提交的表单
        {
            saveCustomer(request, response);
        }
        else if("modify".equals(m))//保存新的客户，来自于customeradd.jsp提交的表单
        {
            modify(request, response);
        }
    }

    private void saveCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {//add
        String name = request.getParameter("name");
        if("".equals(name))//客户姓名不能为空
        {
            request.setAttribute("msg", "请输入客户姓名");
			request.getRequestDispatcher("/customeradd.jsp").forward(request, response);//这里可以直接转发到 customeradd.jsp
            return;// 调整到customeradd.jsp后，函数直接返回，add by hlzhang, 20180122
        }

        User user=new User();
        user.setName(request.getParameter("name"));
        user.setAddress(request.getParameter("address"));
        user.setTel(request.getParameter("tel"));
        user.setRole("customer");
        user.setPwd("123456");

        try
        {
            new UserDAO().save(user);
            request.setAttribute("msg", "添加客户成功");
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }

    private void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            List<User> users = new UserDAO().searchCustomer(request.getParameter("cname"));
            if (0 == users.size())
            {
                request.setAttribute("msg", "没有找到客户信息");
                request.getRequestDispatcher("/customersearch.jsp").forward(request, response);

            }
            else
            {
                request.setAttribute("users", users);
                request.getRequestDispatcher("/customersearch_result.jsp").forward(request, response);
            }
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }


    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            int id = Integer.parseInt(request.getParameter("cid"));
            UserDAO userDAO = new UserDAO();
            userDAO.delete(id);
            request.setAttribute("msg", "删除客户成功");
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }


    private void afterSaveVisit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            UserDAO userDAO = new UserDAO();
            PetDAO petDAO = new PetDAO();
            int ownerId = Integer.parseInt(request.getParameter("cid"));
            //得到VisitServlet的添加病历成功后，sendRedirect到ctomerdetail.jsp所得到的主人id
            User user = userDAO.getById(ownerId);
            List<Pet> pets = petDAO.getPetsByOwnerId(ownerId);
            user.setPets(pets);
            request.setAttribute("user", user);
            request.setAttribute("msg", "添加病历成功");
            request.getRequestDispatcher("/customerdetail.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }

    private void afterSavePet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            int id = Integer.parseInt(request.getParameter("id"));//1得到petServlet的添加宠物成功后，sendRedirect到ctomerdetail.jsp所得到的主人id
            User user = new UserDAO().getById(id); //2根据主人id查找UserDAO.getById()
            List<Pet> pets = new PetDAO().getPetsByOwnerId(id);//3根据主人id查找PetDAO.getPetsByOwnerId()
            user.setPets(pets);//4将两个查找结果通过request转发到结果页面customerdetail.jsp
            request.setAttribute("user", user);//Pet是User的属性，已包含在User中传递给了customerdetail.jsp，因此无需单独传递pets参数
            request.setAttribute("msg", "添加宠物成功");
            request.getRequestDispatcher("/customerdetail.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            UserDAO userDAO = new UserDAO();
            PetDAO petDAO = new PetDAO();
            int ownerId = Integer.parseInt(request.getParameter("id"));//得到customersearch_resultl.jsp的“查看明细”链接发送来的参数客户id
            User user = userDAO.getById(ownerId);
            List<Pet> pets = petDAO.getPetsByOwnerId(ownerId);
            user.setPets(pets);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/customerdetail.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }


    private void modifyCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try
        {
            UserDAO userDAO = new UserDAO();
            int id = Integer.parseInt(request.getParameter("id"));//得到vetsearch_result.jsp的“修改”链接发送来的参数客户id
            User user = userDAO.getById(id);
            request.setAttribute("users", user);
            request.getRequestDispatcher("/modifyCustomer.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
    }

    private void modify(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
    {
        String name = request.getParameter("nname");
        UserDAO userDAO = new UserDAO();
        if("".equals(name))//客户姓名不能为空
        {
            request.setAttribute("msg", "请输入修改客户姓名");
            request.getRequestDispatcher("/customeradd.jsp").forward(request, response);//这里可以直接转发到 customeradd.jsp
            return;// 调整到customeradd.jsp后，函数直接返回，add by hlzhang, 20180122
        }

        try
        {
            User user = userDAO.getByName(request.getParameter("oname"));
            int id = user.getId();
            User user2=new User();
            user2.setId(id);
            user2.setName(request.getParameter("nname"));
            user2.setAddress(request.getParameter("address"));
            user2.setTel(request.getParameter("tel"));
            user2.setRole("customer");
            user2.setPwd("123456");

            new UserDAO().update(user2);
            request.setAttribute("msg", "客户信息修改成功");
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }
        catch (Exception e)
        {
            request.setAttribute("msg", e.getMessage());
            request.getRequestDispatcher("/customersearch.jsp").forward(request, response);
        }

    }
}
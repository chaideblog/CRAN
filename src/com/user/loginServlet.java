package com.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.database.DBOperation;
import java.sql.*;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/login")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		ResultSet rs=null;
		
		try {
			DBOperation dbo=new DBOperation();
			String sql="select username from puser where username='"+username+"'";
			rs=dbo.query(sql);
			if(rs.next()){
				sql="select password from puser where password='"+password+"'";
				rs=dbo.query(sql);
				if(rs.next()){
					HttpSession session=request.getSession();
					session.setAttribute("username", username);	//将username存放到session中
					out.println("<script language='javascript'>alert('登录成功！');window.location='"+request.getContextPath()+"/index.jsp';</script>");
				}else{
					out.println("<script language='javascript'>alert('密码错误！');history.back();</script>");
				}
			}else{
				out.println("<script language='javascript'>alert('该用户不存在！');history.back();</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null){
				
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

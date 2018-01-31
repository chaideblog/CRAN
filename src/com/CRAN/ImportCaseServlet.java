package com.CRAN;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBOperation;
import com.excel.ExcelOperation;

/**
 * Servlet implementation class ImportCaseServlet
 */
@WebServlet("/importCase")
public class ImportCaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImportCaseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String caseNum=request.getParameter("caseNum");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		ServletContext context=getServletContext();
		
		if(caseNum.equals("7")){
			//先清空数据库中数据，需要清空的表有ue,rru,bbu,bbupool,link,antenna,linkaccess2rru,linkbbu2rru,accesspoint,uegroup
			try {
				DBOperation dbo=new DBOperation();
				Connection conn=dbo.getConnection();
				conn.setAutoCommit(false);
				dbo.update("delete from ue");
				dbo.update("delete from rru");
				dbo.update("delete from bbu");
				dbo.update("delete from bbupool");
				dbo.update("delete from link");
				dbo.update("delete from antenna");
				dbo.update("delete from linkaccess2rru");
				dbo.update("delete from linkbbu2rru");
				dbo.update("delete from accesspoint");
				dbo.update("delete from uegroup");
				conn.commit();
				if(conn!=null) conn.close();
			} catch (Exception e1) {
				e1.printStackTrace();
			} finally {
				//这里如果调用conn.close会要求包围到一个try/catch块中，为什么？
			}
			
			String path=context.getRealPath("/")+"\\cases\\7\\";
			try {
				//导入antenna
				String antennaPath=path+"Antenna.xls";
				ExcelOperation.antennaImport(antennaPath);
				//导入bbu
				String bbuPath=path+"Bbu.xls";
				ExcelOperation.bbuImport(bbuPath);
				//导入bbuPool
				String bbuPoolPath=path+"BbuPool.xls";
				ExcelOperation.bbuPoolImport(bbuPoolPath);
				//导入rru
				String rruPath=path+"Rru.xls";
				ExcelOperation.rruImport(rruPath);
				//导入ue（excel文件中的浮点数导入到数据库时显示不完整，在原来的系统中也存在这个问题）
				String uePath=path+"Ue.xls";
				ExcelOperation.ueImport(uePath);
				//导入linkCircle（这里虽然从命名上看导的是LinkCircle表，而实际上导的是Link表）
				String linkCirclePath=path+"Link.xls";
				ExcelOperation.linkCircleImport(linkCirclePath);
				
				out.println("<script language='javascript'>alert('数据库导入成功！');window.location='"+request.getContextPath()+"/index.jsp';</script>");
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script language='javascript'>alert('数据库导入失败！');history.back();</script>");
			}
		}else{
			out.println("<script language='javascript'>alert('该实例目前无法导入！');history.back();</script>");
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

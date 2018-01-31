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
			//��������ݿ������ݣ���Ҫ��յı���ue,rru,bbu,bbupool,link,antenna,linkaccess2rru,linkbbu2rru,accesspoint,uegroup
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
				//�����������conn.close��Ҫ���Χ��һ��try/catch���У�Ϊʲô��
			}
			
			String path=context.getRealPath("/")+"\\cases\\7\\";
			try {
				//����antenna
				String antennaPath=path+"Antenna.xls";
				ExcelOperation.antennaImport(antennaPath);
				//����bbu
				String bbuPath=path+"Bbu.xls";
				ExcelOperation.bbuImport(bbuPath);
				//����bbuPool
				String bbuPoolPath=path+"BbuPool.xls";
				ExcelOperation.bbuPoolImport(bbuPoolPath);
				//����rru
				String rruPath=path+"Rru.xls";
				ExcelOperation.rruImport(rruPath);
				//����ue��excel�ļ��еĸ��������뵽���ݿ�ʱ��ʾ����������ԭ����ϵͳ��Ҳ����������⣩
				String uePath=path+"Ue.xls";
				ExcelOperation.ueImport(uePath);
				//����linkCircle��������Ȼ�������Ͽ�������LinkCircle����ʵ���ϵ�����Link��
				String linkCirclePath=path+"Link.xls";
				ExcelOperation.linkCircleImport(linkCirclePath);
				
				out.println("<script language='javascript'>alert('���ݿ⵼��ɹ���');window.location='"+request.getContextPath()+"/index.jsp';</script>");
			} catch (Exception e) {
				e.printStackTrace();
				out.println("<script language='javascript'>alert('���ݿ⵼��ʧ�ܣ�');history.back();</script>");
			}
		}else{
			out.println("<script language='javascript'>alert('��ʵ��Ŀǰ�޷����룡');history.back();</script>");
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

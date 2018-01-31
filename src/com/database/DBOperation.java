package com.database;

import java.sql.*;

public class DBOperation {
	private static final String URL = "jdbc:mysql://localhost:3306/c-ran?useUnicode=true&characterEncoding=utf-8";
	private static final String USERNAME = "root";
	private static String PASSWORD = "";
	private Connection conn=null;
	private Statement stmt=null;
	private ResultSet rs=null;

	//��������
	public DBOperation () throws Exception{
	     Class.forName("com.mysql.jdbc.Driver");
	}
	
	//�������ݿ�����
	public Connection getConnection() throws Exception{
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
	
	//�ر����ݿ���Դ
	public void close(){
		try {
			if(rs!=null){
				rs.close();
			}
			if(stmt!=null){
				stmt.close();
			}
			if(conn!=null){
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//��ѯ
	public ResultSet query(String sql) throws Exception{
		try {
			conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//�˴����ܹر�rs����ΪҪ����rs
		}
		
		return rs;
	}
	
	//����ɾ����
	public boolean update(String sql){
		boolean flag=true;
		try {
			conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
			stmt=conn.createStatement();
			stmt.executeUpdate(sql);	//�����ܸ�sql���Ӱ��ļ�¼����Ŀ
		} catch (Exception e) {
			e.printStackTrace();
			flag=false;
		} finally {
			this.close();
		}
		
		return flag;
	}
}

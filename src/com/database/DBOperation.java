package com.database;

import java.sql.*;

public class DBOperation {
	private static final String URL = "jdbc:mysql://localhost:3306/c-ran?useUnicode=true&characterEncoding=utf-8";
	private static final String USERNAME = "root";
	private static String PASSWORD = "";
	private Connection conn=null;
	private Statement stmt=null;
	private ResultSet rs=null;

	//加载驱动
	public DBOperation () throws Exception{
	     Class.forName("com.mysql.jdbc.Driver");
	}
	
	//返回数据库连接
	public Connection getConnection() throws Exception{
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
	
	//关闭数据库资源
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
	
	//查询
	public ResultSet query(String sql) throws Exception{
		try {
			conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//此处不能关闭rs，因为要返回rs
		}
		
		return rs;
	}
	
	//增、删、改
	public boolean update(String sql){
		boolean flag=true;
		try {
			conn=DriverManager.getConnection(URL, USERNAME, PASSWORD);
			stmt=conn.createStatement();
			stmt.executeUpdate(sql);	//返回受该sql语句影响的记录的数目
		} catch (Exception e) {
			e.printStackTrace();
			flag=false;
		} finally {
			this.close();
		}
		
		return flag;
	}
}

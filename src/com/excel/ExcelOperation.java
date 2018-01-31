package com.excel;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.database.DBOperation;

/**
 * 
 * @author ���
 *
 */
public class ExcelOperation {
	// dbOperation dbo=new dbOperation(); //����ᱨ����֪��Ϊʲô

	public static void accessPointImport(String path) throws Exception {

	}
	
	public static void linkImport(String path) throws Exception{
		
	}

	/**
	 * ��antenna.xls�е����ݵ������ݿ��е�antenna��
	 * @param path
	 * @throws Exception
	 */
	public static void antennaImport(String path) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement(
					"insert into Antenna(AntennaId,AngleCoverages,M,N,DisHori,DisVert,AntennaMode,VertGain,HoriGain,RadiationLobe,TiltAngle) values (?,?,?,?,?,?,?,?,?,?,?)");
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);//AntennaId
				pst.setString(2, result[i][1]);//AngleCoverages
				pst.setString(3, result[i][2]);//m
				pst.setString(4, result[i][3]);//n
				pst.setString(5, result[i][4]);//DisHori
				pst.setString(6, result[i][5]);//DisVert
				pst.setString(7, result[i][6]);//AntennaMode
				pst.setString(8, result[i][7]);//VertGain
				pst.setString(9, result[i][8]);//HoriGain
				pst.setString(10, result[i][9]);//RadiationLobe
				pst.setString(11, result[i][10]);//TiltAngle
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * ��Bbu.xls�е����ݵ������ݿ��е�bbu��
	 * @param path
	 * @throws Exception
	 */
	public static void bbuImport(String path) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement("insert into Bbu(BbuId,BbuPoolId,X,Y,Z,RruNum,SchedualRruMode,TransPower,EquipPower,IsActivity,Res,LinkId,Optime) values (?,?,?,?,?,?,?,?,?,?,?,?,?)" );
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);//BbuId
				pst.setString(2, result[i][1]);//BbuPoolId
				pst.setString(3, result[i][2]);//x
				pst.setString(4, result[i][3]);//y
				pst.setString(5, result[i][4]);//z
				pst.setString(6, result[i][5]);//RruNum
				pst.setString(7, result[i][6]);//srm
				pst.setString(8, result[i][7]);//transpower
				pst.setString(9, result[i][8]);//ep
				pst.setString(10, result[i][9]);//ia
				pst.setString(11, result[i][10]);//res
				pst.setString(12, result[i][11]);//lk
				pst.setString(13, result[i][12]);//op
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * ��BbuPool.xls�е����ݵ������ݿ��е�bbupool��
	 * @param path
	 * @throws Exception
	 */
	public static void bbuPoolImport(String path) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement("insert into BbuPool(BbuPoolId,X,Y,Z,AllRes,ResLeft,DynamicEnergy,StaticEnergy,BbuPoolInfo) values (?,?,?,?,?,?,?,?,?)" );
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);//BbuPoolId
				pst.setString(2, result[i][1]);//X
				pst.setString(3, result[i][2]);//Y
				pst.setString(4, result[i][3]);//Z
				pst.setString(5, result[i][4]);//AllRes
				pst.setString(6, result[i][5]);//ResLeft
				pst.setString(7, result[i][6]);//DynamicEnengy
				pst.setString(8, result[i][7]);//StaticEnengy
				pst.setString(9, result[i][8]);//BbuPoolInfo
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * ��Rru.xls�е����ݵ������ݿ��е�rru��
	 * @param path
	 * @throws Exception
	 */
	public static void rruImport(String path) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement("insert into Rru(RruId,ServiceBbuId,Radius,X,Y,Z,RruTransPower,RruBandwidth,UeNum,IsActivity,CarrierFrequent,RruAntennaId,EquipPower,Optime,Rate) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" );
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);//RruId
				pst.setString(2, result[i][1]);//ServiceBbuId
				pst.setString(3, result[i][2]);//Radius
				pst.setString(4, result[i][3]);//X
				pst.setString(5, result[i][4]);//Y
				pst.setString(6, result[i][5]);//Z
				pst.setString(7, result[i][6]);//RruTransPower
				pst.setString(8, result[i][7]);//RruBandWith
				pst.setString(9, result[i][8]);//UeNum
				pst.setString(10, result[i][9]);//IsActivity
				pst.setString(11, result[i][10]);//CarrierFrequent
				pst.setString(12, result[i][11]);//RruAntennaId
				pst.setString(13, result[i][12]);//EquipPower
				pst.setString(14, result[i][13]);//op
				pst.setString(15, result[i][14]);//rate
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * ��Ue.xls�е����ݵ������ݿ��е�ue��
	 * @param path
	 * @throws Exception
	 */
	public static void ueImport(String path) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement("insert into Ue(UeId,UeType,X,Y,Z,ServiceRruId,RbNum,UeTransPower,UeAntennaId,IsActivity,UeGroupId,ModelType,SNR,TotalBit,TTISent,AverageRate) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)" );
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);//UeId
				pst.setString(2, result[i][1]);//UeType
				pst.setString(3, result[i][2]);//X
				pst.setString(4, result[i][3]);//Y
				pst.setString(5, result[i][4]);//Z
				pst.setString(6, result[i][5]);//ServiceRruId
				pst.setString(7, result[i][6]);//RbNum
				pst.setString(8, result[i][7]);//UeTransPower
				pst.setString(9, result[i][8]);//UeAntennaId
				pst.setString(10, result[i][9]);//IsActivity
				pst.setString(11, result[i][10]);//UeGroupId
				pst.setString(12, result[i][11]);//ModelType
				pst.setString(13, result[i][12]);//SNR
				pst.setString(14, result[i][13]);//TotalBit
				pst.setString(15, result[i][14]);//TTIsent
				pst.setString(16, result[i][15]);//AverageRate
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * ��Link.xls�е����ݵ������ݿ��е�link��ע�⣬������Ȼ������������linkCircle����ʵ�ʵ�����link����ʱΪʲô����д��Ҳ��֪����
	 * @param path
	 * @throws Exception
	 */
	public static void linkCircleImport(String path) throws Exception{
		Connection conn = null;
		PreparedStatement pst = null;
		DBOperation dbo=new DBOperation();
		try {
			conn=dbo.getConnection();
			conn.setAutoCommit(false);
			pst = (PreparedStatement) conn.prepareStatement("insert into Link (LinkId,LinkType,X1,Y1,Z1,X2,Y2,Z2,LongRadius,ShortRadius,AccesspointNum,Cost) values (?,?,?,?,?,?,?,?,?,?,?,?)" );
			File file = new File(path);
			String[][] result = getData(file, 1);
			int rowLength = result.length;
			for (int i = 0; i < rowLength; i++) {
				pst.setString(1, result[i][0]);
				pst.setString(2, result[i][1]);
				pst.setString(3, result[i][2]);
				pst.setString(4, result[i][3]);
				pst.setString(5, result[i][4]);
				pst.setString(6, result[i][5]);
				pst.setString(7, result[i][6]);
				pst.setString(8, result[i][7]);
				pst.setString(9, result[i][8]);
				pst.setString(10, result[i][9]);
				pst.setString(11, result[i][10]);
				pst.setString(12, result[i][11]);
				pst.addBatch();	// �����������
			}
			pst.executeBatch();	// ���������ύ
			conn.commit();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			//��������ݿ⵼��ʧ�ܣ�ID�ظ���
			e.printStackTrace();
		} finally {
			if (pst != null) {
				pst.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	/**
	 * ��ȡExcel�����ݣ���һά��ʾ�У��ڶ�ά��ʾ��
	 * 
	 * @param file
	 *            ��ȡ���ݵ�ԴExcel
	 * @param ignoreRows
	 *            ��ȡ���ݺ��Ե�������������ͷ����Ҫ������Ե�����Ϊ1
	 * @return ������Excel�����ݵ�����
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static String[][] getData(File file, int ignoreRows) throws FileNotFoundException, IOException {
		List<String[]> result = new ArrayList<String[]>();
		int rowSize = 0;
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
		// ��HSSFWorkbook
		POIFSFileSystem fs = new POIFSFileSystem(in);
		HSSFWorkbook wb = new HSSFWorkbook(fs);
		HSSFCell cell = null;
		for (int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
			HSSFSheet st = wb.getSheetAt(sheetIndex);

			// ��һ��Ϊ���⣬��ȡ
			// System.out.println("<=lastrow"+st.getLastRowNum());
			for (int rowIndex = ignoreRows; rowIndex <= st.getLastRowNum(); rowIndex++) {
				HSSFRow row = st.getRow(rowIndex);
				if (row == null) {
					continue;
				}
				int tempRowSize = row.getPhysicalNumberOfCells();
				if (tempRowSize > rowSize) {
					rowSize = tempRowSize;
				}
				// System.out.println(rowSize);
				String[] values = new String[rowSize];
				Arrays.fill(values, "");
				boolean hasValue = false;
				// System.out.println("rowindex"+rowIndex);
				// System.out.println("<lastcolumn"+row.getPhysicalNumberOfCells());
				for (short columnIndex = 0; columnIndex < row.getPhysicalNumberOfCells(); columnIndex++) {
					// System.out.println(columnIndex);
					String value = "";
					cell = row.getCell(columnIndex);
					if (cell != null) {
						// ע�⣺һ��Ҫ��������������ܻ��������
						cell.setEncoding(HSSFCell.ENCODING_UTF_16);
						switch (cell.getCellType()) {
						case HSSFCell.CELL_TYPE_STRING:
							value = cell.getStringCellValue();
							break;
						case HSSFCell.CELL_TYPE_NUMERIC:
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								Date date = cell.getDateCellValue();
								if (date != null) {
									value = new SimpleDateFormat("yyyy-MM-dd").format(date);
								} else {
									value = "";
								}
							} else {
								value = new DecimalFormat("0").format(cell.getNumericCellValue());
							}
							break;
						case HSSFCell.CELL_TYPE_FORMULA:
							// ����ʱ���Ϊ��ʽ���ɵ���������ֵ
							if (!cell.getStringCellValue().equals("")) {
								value = cell.getStringCellValue();
							} else {
								value = cell.getNumericCellValue() + "";
							}
							break;
						case HSSFCell.CELL_TYPE_BLANK:
							break;
						case HSSFCell.CELL_TYPE_ERROR:
							value = "";
							break;
						case HSSFCell.CELL_TYPE_BOOLEAN:
							value = (cell.getBooleanCellValue() == true ? "Y" : "N");
							break;
						default:
							value = "";
						}
					}
					if (columnIndex == 0 && value.trim().equals("")) {
						break;
					}
					values[columnIndex] = rightTrim(value);
					hasValue = true;
				}

				if (hasValue) {
					result.add(values);
					// System.out.println(values);
				}
			}
		}
		in.close();
		String[][] returnArray = new String[result.size()][rowSize];
		for (int i = 0; i < returnArray.length; i++) {
			returnArray[i] = (String[]) result.get(i);
		}
		return returnArray;
	}

	/**
	 * ȥ���ַ����ұߵĿո�
	 * 
	 * @param str
	 *            Ҫ������ַ���
	 * @return �������ַ���
	 */
	public static String rightTrim(String str) {
		if (str == null) {
			return "";
		}
		int length = str.length();
		for (int i = length - 1; i >= 0; i--) {
			if (str.charAt(i) != 0x20) {
				break;
			}
			length--;
		}
		return str.substring(0, length);
	}

	public static void main(String[] args) {
//		 String path="WebContent\\cases\\7\\Antenna.xls";
//		 try {
//		 antennaImport(path);
//		 } catch (Exception e) {
//		 e.printStackTrace();
//		 }
	}
}

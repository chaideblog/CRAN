<%@ page import="com.database.DBOperation"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page errorPage="errorPage.jsp" %>
   
<!-- 为了防止index.jsp文件过大，可以考虑将各个模块分别作为一个jsp文件，然后用include指令包含进来 -->
    
<jsp:useBean id="dbo" class="com.database.DBOperation" scope="application"></jsp:useBean>

<!-- 声明成员变量 -->

<!-- 测试 -->
<%

%>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
  <title>test</title>
  <style type="text/css">
    html{height:100%}
    body{height:100%;margin:0px;padding-top:50px}
    #container{height:100%}
  </style>

  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript"
    src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
  <script src="http://localhost:8080/CRAN/js/echarts.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts/echart.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echart-gl.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
  <script type="text/javascript"
    src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=bA855jBQ52TRbpu21Ey0GBD4YxfQWFpH"></script>
  <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
  <script>
    $(document).ready(function(){
      // 网络部署——BBU
      $("#radio1").click(function(){
        $("#table1").show();
        $("#table2").hide();
      });
      $("#radio2").click(function(){
        $("#table1").hide();
        $("#table2").show();
      });

      //运行配置——场景参数配置——用户移动模型
      $("#speedDistributeType").change(function(){
        var selectedValue=$(this).val();
        if(selectedValue==1){ //均匀分布
          $("#uniformDistribution").show();
          $("#normalDistribution").hide();
        }
        if(selectedValue==2){ //正态分布
          $("#uniformDistribution").hide();
          $("#normalDistribution").show();
        }
      });

      //场景参数配置——业务量模型
      $("#businessModel").change(function(){
        var selectedValue=$(this).val();
        if(selectedValue==1){ //非既定业务量
          $("#businessModelConfig").attr("data-target","#nonEstablishedBusinessModal");
        }
        if(selectedValue==2){ //既定业务量
          $("#businessModelConfig").attr("data-target","#establishedBusinessModal");
        }
      });
    });
  </script>
</head>

<body>
  <!-- 导航条 -->
  <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
          aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>  <!-- 这个Toggle navigation显示在哪了? -->
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">CRAN</a>
        <!-- 这里可以换成一个北邮的logo -->
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">网络部署<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#" data-toggle="modal" data-target="#BBUModal">BBU</a></li>
              <li><a href="#" data-toggle="modal" data-target="#RRUModal">RRU</a></li>
              <li><a href="#" data-toggle="modal" data-target="#UEModal">UE</a></li>
              <li><a href="#" data-toggle="modal" data-target="#fileImportModal">参数文件导入</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">链路部署<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#" data-toggle="modal" data-target="#BbuPool2BbuPoolModal">BbuPool-BbuPool</a></li>
              <li><a href="#" data-toggle="modal" data-target="#BBU2BBUModal">BBU-BBU</a></li>
              <li><a href="#" data-toggle="modal" data-target="#BBU2RRUModal">BBU-RRU</a></li>
              <li><a href="#" data-toggle="modal" data-target="#LinkCircleModal">LinkCircle</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">网络优化<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#">链接规划</a></li>
              <li><a href="#">负载均衡</a></li>
              <li><a href="#">自主管理</a></li>
              <li><a href="#">节能补偿</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">运行配置<span class="caret"></span></a>
            <ul class="dropdown-menu">
              <li><a href="#" data-toggle="modal" data-target="#sceneParameterConfig">场景参数配置</a></li>
              <li><a href="#" data-toggle="modal" data-target="#controlParameterConfig">控制参数配置</a></li>
            </ul>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <!-- 这里可以考虑用图片显示个数，不过导航条是黑色的，需要将原系统中的图片处理一下显示效果才比较好 -->
          <li style="color:#FFF;margin-top:15px;margin-right:20px;">BBUPool：10</li>
          <li style="color:#FFF;margin-top:15px;margin-right:20px;">BBU：10</li>
          <li style="color:#FFF;margin-top:15px;margin-right:20px;">RRU：10</li>
          <li style="color:#FFF;margin-top:15px;margin-right:20px;">UE：10</li>
          <li>
            <form class="navbar-form navbar-right">	<!-- 这个form只用来改变样式 -->
            <%
            if(session.getAttribute("username")!=null){
            %>
            <span style="color:#fff;">欢迎您,<%=session.getAttribute("username") %>!&nbsp;&nbsp;</span><a href="<%=request.getContextPath() %>/logout" style="color:#fff;margin-right:10px">注销</a>
            <%}else{ %>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#loginModal" style="margin-right:20px;">用户登录</button>
            <%} %>	<%-- 这个警告是什么意思？ --%>
              <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#caseModal" style="margin-right:20px;">实例管理</button>
            </form>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- 导航条 -->

  <!-- 用户登录 -->
  <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-label="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h3 class="modal-title">用户登录</h3>
        </div>

        <form name="loginForm" method="post" action="login"> <!-- 这里要提交到特定的页面进行处理 -->
          <div class="modal-body">
            <div class="form-group">
              <label class="control-label">帐号</label>
              <input id="name" type="text" name="username" class="form-control" placeholder="帐号" required autofocus/>
              <span class="label label-warning" id="username_msg"></span>
            </div>
            <div class="form-group">
              <label class="control-label">密码</label>
              <input id="password" type="password" name="password" class="form-control" placeholder="密码" />
              <span class="label label-warning" id="password_msg"></span>
            </div>
          </div>

          <div class="modal-footer">
            <input type="submit" name="submit" class="btn btn-primary" value="登录">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 用户登录 -->

  <!-- 实例管理 -->
  <div class="modal fade" id="caseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title" id="myModalLabel">实例管理</h4>
        </div>

        <form name="importCaseForm" method="post" action="importCase">  <!-- 这里要提交到特定的页面进行处理 -->
          <div class="modal-body">
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td></td> <!-- 这里本来应该是th，但是如果是th的话无法实现居中，所以改成了td -->
                <td>实例名</td>
                <td>备注</td>
                <td>修改</td>
                <td>删除</td>
              </tr>

              <tr>
                <td><input type="radio" name="caseNum" value="1"></td>
                <td>1</td>
                <td>1</td>
                <td><a href="#"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
              <tr>
                <td><input type="radio" name="caseNum" value="6"></td>
                <td>6</td>
                <td>1</td>
                <td><a href="#"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
              <tr>
                <td><input type="radio" name="caseNum" value="7"></td>
                <td>7</td>
                <td>1</td>
                <td><a href="#"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </div>

          <div class="modal-footer">
           	<button type="button" class="btn btn-success">新建</button>
            <input type="submit" name="submit" class="btn btn-primary" value="导入实例">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 实例管理 -->

  <!-- 网络部署 -->
  <!-- BBU -->
  <div class="modal fade" id="BBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4>BBU参数输入</h4>
        </div>

        <div class="modal-body">
          <h4>BBUPool</h4>
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td></td>
                <td>BBUPool ID</td>
                <td>X坐标(m)</td>
                <td>Y坐标(m)</td>
                <td>Z坐标(m)</td>
                <td>备注</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td><input id="radio1" type="radio" name="radio" value=""></td>
                <td>1</td>
                <td>516.0</td>
                <td>116.0</td>
                <td>1.0</td>
                <td>延庆</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyBBUPoolModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
              <tr>
                <td><input id="radio2" type="radio" name="radio" value=""></td>
                <td>2</td>
                <td>516.0</td>
                <td>116.0</td>
                <td>1.0</td>
                <td>延庆</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyBBUPoolModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBBUPoolModal" style="width:110px;height:35px;">添加BBUPool</button>
          </div>
          <hr>
          <h4>BBU</h4>
          <table id="table1" class="table table-bordered table-hover text-center" hidden>
            <tr>
              <td>BBU ID</td>
              <td>X坐标(m)</td>
              <td>Y坐标(m)</td>
              <td>Z坐标(m)</td>
              <td>传输功率(dBm)</td>
              <td>资源量</td>
              <td>RRU的调度方式</td>
              <td>接入环</td>
              <td>修改</td>
              <td>删除</td>
            </tr>

            <tr>
              <td>1</td>
              <td>624.0</td>
              <td>261.0</td>
              <td>1500.0</td>
              <td>43.0</td>
              <td>20.0</td>
              <td>CIS</td>
              <td>2</td>
              <td><a href="#" data-toggle="modal" data-target="#modifyBBUModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
              <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
            </tr>
          </table>
          <table id="table2" class="table table-bordered table-hover text-center" hidden>
            <tr>
              <td>BBU ID</td>
              <td>X坐标(m)</td>
              <td>Y坐标(m)</td>
              <td>Z坐标(m)</td>
              <td>传输功率(dBm)</td>
              <td>资源量</td>
              <td>RRU的调度方式</td>
              <td>接入环</td>
              <td>修改</td>
              <td>删除</td>
            </tr>

            <tr>
              <td>2</td>
              <td>624.0</td>
              <td>261.0</td>
              <td>1500.0</td>
              <td>43.0</td>
              <td>20.0</td>
              <td>CIS</td>
              <td>2</td>
              <td><a href="#" data-toggle="modal" data-target="#modifyBBUModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
              <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
            </tr>
          </table>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBBUModal" style="width:110px;height:35px;">添加BBU</button>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 添加BBUPool -->
  <div class="modal fade" id="addBBUPoolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加BBUPool</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="remark">备注</label>
              <input type="text" class="form-control" id="remark" placeholder="备注">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加BBUPool -->

  <!-- 修改BBUPool -->
  <div class="modal fade" id="modifyBBUPoolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改BBUPool</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="remark">备注</label>
              <input type="text" class="form-control" id="remark" placeholder="备注">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改BBUPool -->

  <!-- 添加BBU -->
  <div class="modal fade" id="addBBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加BBU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="transmissionPower">传输功率</label>
              <input type="text" class="form-control" id="transmissionPower" placeholder="传输功率">
            </div>
            <div class="form-group">
              <label for="resource">资源量</label>
              <input type="text" class="form-control" id="resource" placeholder="资源量">
            </div>
            <div class="form-group">
              <label for="schedulingMode">调度方式</label>
              <select class="form-control" id="schedulingMode">
                <option value="RRS">RRS</option>
                <option value="CIS">CIS</option>
                <option value="PFS">PFS</option>
              </select>
            </div>
            <div class="form-group">
              <label for="accessedRing">接入环ID</label>
              <input type="text" class="form-control" id="accessedRing" placeholder="接入环ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加BBU -->

  <!-- 修改BBU -->
  <div class="modal fade" id="modifyBBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改BBU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="transmissionPower">传输功率</label>
              <input type="text" class="form-control" id="transmissionPower" placeholder="传输功率">
            </div>
            <div class="form-group">
              <label for="resource">资源量</label>
              <input type="text" class="form-control" id="resource" placeholder="资源量">
            </div>
            <div class="form-group">
              <label for="schedulingMode">调度方式</label>
              <select class="form-control" id="schedulingMode">
                <option value="RRS">RRS</option>
                <option value="CIS">CIS</option>
                <option value="PFS">PFS</option>
              </select>
            </div>
            <div class="form-group">
              <label for="accessedRing">接入环ID</label>
              <input type="text" class="form-control" id="accessedRing" placeholder="接入环ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改BBU -->
  <!-- BBU -->

  <!-- RRU -->
  <div class="modal fade" id="RRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">RRU参数录入</h4>
        </div>

        <div class="modal-body">
          <h4>BBU</h4>
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td></td>
                <td>BBU ID</td>
                <td>X坐标(m)</td>
                <td>Y坐标(m)</td>
                <td>Z坐标(m)</td>
                <td>传输功率(dBm)</td>
                <td>资源量</td>
                <td>RRU的调度方式</td>
                <td>接入环</td>
                <td>备注</td>
              </tr>
  
              <tr>
                <td><input type="radio" name="radio" value=""></td>
                <td>0</td>
                <td>176.0</td>
                <td>301.0</td>
                <td>1000.0</td>
                <td>43.0</td>
                <td>20.0</td>
                <td>PFS</td>
                <td>1</td>
                <td>延庆</td>
              </tr>
            </table>
          </form>
          <hr>
          <h4>RRU</h4>
          <table class="table table-bordered table-hover text-center">
            <tr>
              <td>RRU ID</td>
              <td>X坐标(m)</td>
              <td>Y坐标(m)</td>
              <td>Z坐标(m)</td>
              <td>发射功率(dBm)</td>
              <td>最大用户量</td>
              <td>载频(Hz)</td>
              <td>RRU的状态</td>
              <td>天线类型</td>
              <td>修改</td>
              <td>删除</td>
            </tr>

            <tr>
              <td>0</td>
              <td>4</td>
              <td>624.0</td>
              <td>261.0</td>
              <td>1500.0</td>
              <td>43.0</td>
              <td>20.0</td>
              <td>CIS</td>
              <td>2</td>
              <td><a href="#" data-toggle="modal" data-target="#modifyRRUModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
              <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
            </tr>
          </table>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addRRUModal" style="width:110px;height:35px;">添加RRU</button>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- RRU -->

  <!-- 添加RRU -->
  <div class="modal fade" id="addRRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加RRU</h4>
        </div>
          
        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="launchPower">发射功率</label>
              <input type="text" class="form-control" id="launchPower" placeholder="发射功率">
            </div>
            <div class="form-group">
              <label for="maxUserNumber">最大用户量</label>
              <input type="text" class="form-control" id="maxUserNumber" placeholder="最大用户量">
            </div>
            <div class="form-group">
              <label for="carrierFrequency">载频</label>
              <input type="text" class="form-control" id="carrierFrequency" placeholder="载频">
            </div>
            <div class="form-group">
              <label for="RRUState">RRU状态</label>
              <select class="form-control" id="RRUState">
                <option value="open">打开</option>
                <option value="close">关闭</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加RRU -->

  <!-- 修改RRU -->
  <div class="modal fade" id="modifyRRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改RRU</h4>
        </div>
          
        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Z坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="launchPower">发射功率</label>
              <input type="text" class="form-control" id="launchPower" placeholder="发射功率">
            </div>
            <div class="form-group">
              <label for="maxUserNumber">最大用户量</label>
              <input type="text" class="form-control" id="maxUserNumber" placeholder="最大用户量">
            </div>
            <div class="form-group">
              <label for="carrierFrequency">载频</label>
              <input type="text" class="form-control" id="carrierFrequency" placeholder="载频">
            </div>
            <div class="form-group">
              <label for="RRUState">RRU状态</label>
              <select class="form-control" id="RRUState">
                <option value="open">打开</option>
                <option value="close">关闭</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改RRU -->

  <!-- UE -->
  <div class="modal fade" id="UEModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">UE参数录入</h4>
        </div>

        <div class="modal-body">
          <h4>UE群</h4>
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td></td>
                <td>UE群ID</td>
                <td>UE个数</td>
                <td>中心X坐标(m)</td>
                <td>中心Y坐标(m)</td>
                <td>分布方式</td>
                <td>区域半径(m)</td>
                <td>室内外信息</td>
                <td>天线类型</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td><input type="radio" name="radio" value=""></td>
                <td>1</td>
                <td>30</td>
                <td>248.0</td>
                <td>384.0</td>
                <td>分布方式</td>
                <td>100.0</td>
                <td>室外</td>
                <td>0</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyUEGroupModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addUEGroupModal" style="width:110px;height:35px;">添加UE群</button>
          </div>
          <hr>
          <h4>UE</h4>
          <table class="table table-bordered table-hover text-center">
            <tr>
              <td>UE ID</td>
              <td>X坐标(m)</td>
              <td>Y坐标(m)</td>
              <td>Z坐标(m)</td>
              <td>室内外信息</td>
              <td>天线类型</td>
              <td>UE群ID</td>
              <td>修改</td>
              <td>删除</td>
            </tr>

            <tr>
              <td>2</td>
              <td>248.0</td>
              <td>384.0</td>
              <td>0.0</td>
              <td>室外</td>
              <td>1</td>
              <td>1</td>
              <td><a href="#" data-toggle="modal" data-target="#modifyUEModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
              <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
            </tr>
          </table>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addUEModal" style="width:110px;height:35px;">添加UE</button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- UE -->

  <!-- 添加UE群 -->
  <div class="modal fade" id="addUEGroupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加UE群</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="UENumber">UE个数</label>
              <input type="text" class="form-control" id="UENumber" placeholder="UE个数">
            </div>
            <div class="form-group">
              <label for="X">中心X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="中心X坐标">
            </div>
            <div class="form-group">
              <label for="Y">中心Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="中心Y坐标">
            </div>
            <div class="form-group">
              <label for="distributionMode">分布方式</label>
              <input type="text" class="form-control" id="distributionMode" placeholder="分布方式">
            </div>
            <div class="form-group">
              <label for="regionRadius">区域半径</label>
              <input type="text" class="form-control" id="regionRadius" placeholder="区域半径">
            </div>
            <div class="form-group">
              <label for="indoorOrOutdoor">室内外信息</label>
              <select class="form-control" id="indoorOrOutdoor">
                <option value="indoor">室内</option>
                <option value="outdoor">室外</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加UE群 -->

  <!-- 修改UE群 -->
  <div class="modal fade" id="modifyUEGroupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改UE群</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="UENumber">UE个数</label>
              <input type="text" class="form-control" id="UENumber" placeholder="UE个数">
            </div>
            <div class="form-group">
              <label for="X">中心X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="中心X坐标">
            </div>
            <div class="form-group">
              <label for="Y">中心Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="中心Y坐标">
            </div>
            <div class="form-group">
              <label for="distributionMode">分布方式</label>
              <input type="text" class="form-control" id="distributionMode" placeholder="分布方式">
            </div>
            <div class="form-group">
              <label for="regionRadius">区域半径</label>
              <input type="text" class="form-control" id="regionRadius" placeholder="区域半径">
            </div>
            <div class="form-group">
              <label for="indoorOrOutdoor">室内外信息</label>
              <select class="form-control" id="indoorOrOutdoor">
                <option value="indoor">室内</option>
                <option value="outdoor">室外</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改UE群 -->

  <!-- 添加UE -->
  <div class="modal fade" id="addUEModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加UE</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Y坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="indoorOrOutdoor">室内外信息</label>
              <select class="form-control" id="indoorOrOutdoor">
                <option value="indoor">室内</option>
                <option value="outdoor">室外</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
            <div class="form-group">
              <label for="UEGroupID">UE群ID</label>
              <input type="text" class="form-control" id="UEGroupID" placeholder="UE群ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加UE -->

  <!-- 修改UE -->
  <div class="modal fade" id="modifyUEModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改UE</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="X">X坐标</label>
              <input type="text" class="form-control" id="X" placeholder="X坐标">
            </div>
            <div class="form-group">
              <label for="Y">Y坐标</label>
              <input type="text" class="form-control" id="Y" placeholder="Y坐标">
            </div>
            <div class="form-group">
              <label for="Z">Y坐标</label>
              <input type="text" class="form-control" id="Z" placeholder="Z坐标">
            </div>
            <div class="form-group">
              <label for="indoorOrOutdoor">室内外信息</label>
              <select class="form-control" id="indoorOrOutdoor">
                <option value="indoor">室内</option>
                <option value="outdoor">室外</option>
              </select>
            </div>
            <div class="form-group">
              <label for="antennaType">天线类型</label>
              <select class="form-control" id="antennaType">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
              </select>
            </div>
            <div class="form-group">
              <label for="UEGroupID">UE群ID</label>
              <input type="text" class="form-control" id="UEGroupID" placeholder="UE群ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改UE -->

  <!-- 参数文件导入 -->
  <div class="modal fade" id="fileImportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">Modal title</h4>
        </div>

        <form>
          <div class="modal-body">
            <div class="form-group">
              <label for="fileType">参数文件导入类型</label>
              <select class="form-control" id="fileType">
                <option value="BBUPool">BBUPool</option>
                <option value="BBU">BBU</option>
                <option value="RRU">RRU</option>
                <option value="UE">UE</option>
                <option value="天线">天线</option>
                <option value="LinkCircle">LinkCircle</option>
                <option value="LinkBbu2Bbu">LinkBbu2Bbu</option>
                <option value="LinkBbu2Rru">LinkBbu2Rru</option>
                <option value="LinkBbuPool2BbuPool">LinkBbuPool2BbuPool</option>
              </select>
            </div>
            <hr>
            <div class="form-group">
              <label for="fileImport">文件导入</label>
              <input type="file" id="fileImport">
            </div>
          </div>

          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 参数文件导入 -->
  <!-- 网络部署 -->

  <!-- 链路部署 -->
  <!-- BbuPool-BbuPool -->
  <div class="modal fade" id="BbuPool2BbuPoolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">BBU池间链路输入</h4>
        </div>

        <div class="modal-body">
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td>光纤链路 ID</td>
                <td>端点池1 ID</td>
                <td>端点池2 ID</td>
                <td>最大传输速度(Mbps)</td>
                <td>链路类型</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2</td>
                <td>100</td>
                <td>总线型</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyBbuPool2BbuPoolModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBbuPool2BbuPoolModal" style="width:110px;height:35px;">添加</button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- BbuPool-BbuPool -->

  <!-- 添加BbuPool-BbuPool -->
  <div class="modal fade" id="addBbuPool2BbuPoolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加BbuPool-BbuPool</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BbuPool1ID">端点池1 ID</label>
              <input type="text" class="form-control" id="BbuPool1ID" placeholder="端点池1 ID">
            </div>
            <div class="form-group">
              <label for="BbuPool2ID">端点池2 ID</label>
              <input type="text" class="form-control" id="BbuPool2ID" placeholder="端点池2 ID">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加BbuPool-BbuPool -->

  <!-- 修改BbuPool-BbuPool -->
  <div class="modal fade" id="modifyBbuPool2BbuPoolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改BbuPool-BbuPool</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BbuPool1ID">端点池1 ID</label>
              <input type="text" class="form-control" id="BbuPool1ID" placeholder="端点池1 ID">
            </div>
            <div class="form-group">
              <label for="BbuPool2ID">端点池2 ID</label>
              <input type="text" class="form-control" id="BbuPool2ID" placeholder="端点池2 ID">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改BbuPool-BbuPool -->

  <!-- BBU-BBU -->
  <div class="modal fade" id="BBU2BBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">池内BBU间链路输入</h4>
        </div>

        <div class="modal-body">
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td>光纤链路 ID</td>
                <td>端点BBU1 ID</td>
                <td>端点BBU2 ID</td>
                <td>最大传输速度(Mbps)</td>
                <td>链路类型</td>
                <td>接入环 ID</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2</td>
                <td>100</td>
                <td>总线型</td>
                <td>1</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyBBU2BBUModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBBU2BBUModal" style="width:110px;height:35px;">添加</button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- BBU-BBU -->

  <!-- 添加BBU-BBU -->
  <div class="modal fade" id="addBBU2BBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加BBU-BBU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BBU1ID">端点BBU1 ID</label>
              <input type="text" class="form-control" id="BBU1ID" placeholder="端点BBU1 ID">
            </div>
            <div class="form-group">
              <label for="BBU2ID">端点BBU2 ID</label>
              <input type="text" class="form-control" id="BBU2ID" placeholder="端点BBU2 ID">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
            <div class="form-group">
              <label for="accessedRingID">接入环 ID</label>
              <input type="text" class="form-control" id="accessedRingID" placeholder="接入环 ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加BBU-BBU -->

  <!-- 修改BBU-BBU -->
  <div class="modal fade" id="modifyBBU2BBUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改BBU-BBU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BBU1ID">端点BBU1 ID</label>
              <input type="text" class="form-control" id="BBU1ID" placeholder="端点BBU1 ID">
            </div>
            <div class="form-group">
              <label for="BBU2ID">端点BBU2 ID</label>
              <input type="text" class="form-control" id="BBU2ID" placeholder="端点BBU2 ID">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
            <div class="form-group">
              <label for="accessedRingID">接入环 ID</label>
              <input type="text" class="form-control" id="accessedRingID" placeholder="接入环 ID">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改BBU-BBU -->

  <!-- BBU-RRU -->
  <div class="modal fade" id="BBU2RRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">BBU与RRU链路输入</h4>
        </div>

        <div class="modal-body">
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td>光纤链路 ID</td>
                <td>端点BBU ID</td>
                <td>端点RRU ID</td>
                <td>最大传输速度(Mbps)</td>
                <td>链路类型</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td>1</td>
                <td>1</td>
                <td>2</td>
                <td>100</td>
                <td>总线型</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyBBU2RRUModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addBBU2RRUModal" style="width:110px;height:35px;">添加</button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>

  <!-- 添加BBU-RRU -->
  <div class="modal fade" id="addBBU2RRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加BBU-RRU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BBUID">端点BBU ID</label>
              <input type="text" class="form-control" id="BBUID" placeholder="端点BBU ID">
            </div>
            <div class="form-group">
              <label for="RRUID">端点RRU ID</label>
              <input type="text" class="form-control" id="RRUID" placeholder="端点RRU ID">
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加BBU-RRU -->

  <!-- 修改BBU-RRU -->
  <div class="modal fade" id="modifyBBU2RRUModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改BBU-RRU</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="linkID">光纤链路 ID</label>
              <input type="text" class="form-control" id="linkID" placeholder="光纤链路ID">
            </div>
            <div class="form-group">
              <label for="BBUID">端点BBU ID</label>
              <input type="text" class="form-control" id="BBUID" placeholder="端点BBU ID">
            </div>
            <div class="form-group">
              <label for="RRUID">端点RRU ID</label>
              <input type="text" class="form-control" id="RRUID" placeholder="端点RRU ID">
            </div>
            <div class="form-group">
              <label for="maxTransmissionSpeed">最大传输速度</label>
              <input type="text" class="form-control" id="maxTransmissionSpeed" placeholder="最大传输速度">
            </div>
            <div class="form-group">
              <label for="linkType">链路类型</label>
              <select class="form-control" id="linkType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改BBU-RRU -->
  <!-- BBU-RRU -->

  <!-- LinkCircle -->
  <div class="modal fade" id="LinkCircleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">链路输入</h4>
        </div>

        <div class="modal-body">
          <form method="" action="">  <!-- 只是用来承载单选框的，不一定会用到 -->
            <table class="table table-bordered table-hover text-center">
              <tr>
                <td>环 ID</td>
                <td>环类型</td>
                <td>X1坐标(m)</td>
                <td>Y1坐标(m)</td>
                <td>X2坐标(m)</td>
                <td>Y2坐标(m)</td>
                <td>长半径(m)</td>
                <td>短半径(m)</td>
                <td>备选接入点个数</td>
                <td>修改</td>
                <td>删除</td>
              </tr>
  
              <tr>
                <td>1</td>
                <td>总线型</td>
                <td>310.0</td>
                <td>386.0</td>
                <td>0.0</td>
                <td>0.0</td>
                <td>80.0</td>
                <td>80.0</td>
                <td>6</td>
                <td><a href="#" data-toggle="modal" data-target="#modifyLinkCircleModal"><span class="glyphicon glyphicon-pencil"></span></a></td>
                <td><a href="#"><span class="glyphicon glyphicon-remove"></span></a></td>
              </tr>
            </table>
          </form>
          <div class="text-right">
            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addLinkCircleModal" style="width:110px;height:35px;">添加</button>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- LinkCircle -->

  <!-- 添加LinkCircle -->
  <div class="modal fade" id="addLinkCircleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加LinkCircle</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="accessedRingType">接入环类型</label>
              <select class="form-control" id="accessedRingType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="X1">X1坐标</label>
              <input type="text" class="form-control" id="X1" placeholder="X1坐标">
            </div>
            <div class="form-group">
              <label for="Y1">Y1坐标</label>
              <input type="text" class="form-control" id="Y1" placeholder="Y1坐标">
            </div>
            <div class="form-group">
              <label for="X2">X2坐标</label>
              <input type="text" class="form-control" id="X2" placeholder="X2坐标">
            </div>
            <div class="form-group">
              <label for="Y2">Y2坐标</label>
              <input type="text" class="form-control" id="Y2" placeholder="Y2坐标">
            </div>
            <div class="form-group">
              <label for="longRadius">长半径</label>
              <input type="text" class="form-control" id="longRadius" placeholder="长半径">
            </div>
            <div class="form-group">
              <label for="shortRadius">短半径</label>
              <input type="text" class="form-control" id="shortRadius" placeholder="短半径">
            </div>
            <div class="form-group">
              <label for="alternativeAccessedPointNumber">备选接入点个数</label>
              <input type="text" class="form-control" id="alternativeAccessedPointNumber" placeholder="备选接入点个数">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加LinkCircle -->

  <!-- 修改LinkCircle -->
  <div class="modal fade" id="modifyLinkCircleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">修改LinkCircle</h4>
        </div>
          
        <form method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="accessedRingType">接入环类型</label>
              <select class="form-control" id="accessedRingType">
                <option value="bus">总线型</option>
                <option value="circle">环形</option>
              </select>
            </div>
            <div class="form-group">
              <label for="X1">X1坐标</label>
              <input type="text" class="form-control" id="X1" placeholder="X1坐标">
            </div>
            <div class="form-group">
              <label for="Y1">Y1坐标</label>
              <input type="text" class="form-control" id="Y1" placeholder="Y1坐标">
            </div>
            <div class="form-group">
              <label for="X2">X2坐标</label>
              <input type="text" class="form-control" id="X2" placeholder="X2坐标">
            </div>
            <div class="form-group">
              <label for="Y2">Y2坐标</label>
              <input type="text" class="form-control" id="Y2" placeholder="Y2坐标">
            </div>
            <div class="form-group">
              <label for="longRadius">长半径</label>
              <input type="text" class="form-control" id="longRadius" placeholder="长半径">
            </div>
            <div class="form-group">
              <label for="shortRadius">短半径</label>
              <input type="text" class="form-control" id="shortRadius" placeholder="短半径">
            </div>
            <div class="form-group">
              <label for="alternativeAccessedPointNumber">备选接入点个数</label>
              <input type="text" class="form-control" id="alternativeAccessedPointNumber" placeholder="备选接入点个数">
            </div>
          </div>
  
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            <input type="submit" value="确定" class="btn btn-success"></button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 修改LinkCircle -->
  <!-- 链路部署 -->

  <!-- 网络优化 -->
  <!-- 网络优化 -->

  <!-- 运行配置 -->
  <!-- 场景参数配置 -->
  <div class="modal fade" id="sceneParameterConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">场景参数配置</h4>
        </div>

        <div class="modal-body">
          <div class="form-group">
              <label for="userMoveModel">用户移动模型</label>
              <span style="cursor:pointer;color:dodgerblue" data-toggle="modal" data-target="#userMoveModelModal">详细配置</span>
            <select class="form-control" id="userMoveModel">
              <option value="1">全随机模型</option>
              <option value="2">部分随机模型</option>
            </select>
          </div>
          <div class="form-group">
            <label for="userState">用户状态</label>
            <input type="text" class="form-control" id="userState" placeholder="用户状态">
          </div>
          <div class="form-group">
            <label for="systemFrequencyBandResource">系统频带资源</label>
            <span style="cursor:pointer;color:dodgerblue" data-toggle="modal" data-target="#systemFrequencyBandResourceModal">详细配置</span>
            <input type="text" class="form-control" id="systemFrequencyBandResource" value="频带划分">
          </div>
          <div class="form-group">
            <label for="wirelessLinkModel">无线链路模型</label>
            <select class="form-control" id="wirelessLinkModel">
              <option value="1">自由空间模型</option>
              <option value="2">自由+衰落</option>
              <option value="3">Hata231</option>
              <option value="4">Hata231修正</option>
            </select>
          </div>
          <div class="form-group">
            <label for="resourceDispatchModel">资源调度模型</label>
            <select class="form-control" id="resourceDispatchModel">
              <option value="1">轮询</option>
              <option value="2">最大载干比</option>
              <option value="3">比例公平</option>
            </select>
          </div>
          <div class="form-group">
            <label for="businessModel">业务量模型</label>
            <span id="businessModelConfig" style="cursor:pointer;color:dodgerblue" data-toggle="modal" data-target="#nonEstablishedBusinessModal">详细配置</span>
            <select class="form-control" id="businessModel">
              <option value="1">非既定业务量</option>
              <option value="2">既定业务量</option>
            </select>
          </div>
          <div class="form-group">
            <label for="wiredLinkModel">有线链路模型</label>
            <select class="form-control" id="wiredLinkModel">
              <option value="1">待定</option>
            </select>
          </div>
          <div class="form-group">
            <div class="row">
              <form name="" method="" action="">
                <div class="col-md-6">
                  <label for="configFile">配置文件</label>
                  <input type="file" id="configFile">
                </div>
                <div class="col-md-6 text-right" style="margin-top:15px">
                  <button type="submit" class="btn btn-primary">保存</button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 场景参数配置 -->

  <!-- 用户移动模型 -->
  <div class="modal fade" id="userMoveModelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">用户移动模型配置</h4>
        </div>

        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="speedDistributeType">速度分布类型</label>
              <select class="form-control" id="speedDistributeType">
                <option value="1">均匀分布</option>
                <option value="2">正态分布</option>
              </select>
            </div>
            <!-- 均匀分布 -->
            <div id="uniformDistribution">
              <div class="form-group">
                <label for="speedRange">速度范围</label>
                <div class="row">
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="speedRangeFrom">
                  </div>
                  <div class="col-md-2 text-center">
                    <span>————</span>
                  </div>
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="speedRangeTo">
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label for="X">X区间</label>
                <div class="row">
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="XFrom">
                  </div>
                  <div class="col-md-2 text-center">
                    <span>————</span>
                  </div>
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="XTo">
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label for="Y">Y区间</label>
                <div class="row">
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="YFrom">
                  </div>
                  <div class="col-md-2 text-center">
                    <span>————</span>
                  </div>
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="YTo">
                  </div>
                </div>
              </div>
            </div>
            <!-- 均匀分布 -->

            <!-- 正态分布 -->
            <div id="normalDistribution" hidden>
              <div class="form-group">
                <label for="speedAverage">速度均值</label>
                <input type="text" class="form-control" id="speedAverage" placeholder="速度均值">
              </div>
              <div class="form-group">
                <label for="speedVariance">速度方差</label>
                <input type="text" class="form-control" id="speedVariance" placeholder="速度方差">
              </div>
              <div class="form-group">
                <label for="X">X区间</label>
                <div class="row">
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="XFrom">
                  </div>
                  <div class="col-md-2 text-center">
                    <span>————</span>
                  </div>
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="XTo">
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label for="Y">Y区间</label>
                <div class="row">
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="YFrom">
                  </div>
                  <div class="col-md-2 text-center">
                    <span>————</span>
                  </div>
                  <div class="col-md-5">
                    <input type="text" class="form-control" id="YTo">
                  </div>
                </div>
              </div>
            </div>
            <!-- 正态分布 -->
          </div>

          <div class="modal-footer">
            <button type="submit" class="btn btn-success">确定</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 用户移动模型 -->

  <!-- 系统频带资源 -->
  <div class="modal fade" id="systemFrequencyBandResourceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">系统频带资源</h4>
          </div>

          <form name="" method="" action="">
            <div class="modal-body">
              <div class="form-group">
                <label for="frequencyBandNumber">频带号</label>
                <select class="form-control" id="frequencyBandNumber">
                  <option value="0">添加或选择</option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                </select>
              </div>
              <div class="form-group">
                <label for="totalBandwidth">总带宽</label>
                <input type="text" class="form-control" id="totalBandwidth" placeholder="总带宽">
              </div>
              <div class="form-group">
                <label for="centralFrequency">中心频率</label>
                <input type="text" class="form-control" id="centralFrequency" placeholder="中心频率">
              </div>
              <div class="form-group">
                <label for="frequencyBandWidth">频带宽度</label>
                <input type="text" class="form-control" id="frequencyBandWidth" placeholder="频带宽度">
              </div>
              <div class="form-group">
                <label for="isPublicFrequencyBand">是否公共频带</label>
                <select class="form-control" id="isPublicFrequencyBand">
                  <option value="1">公共频带</option>
                  <option value="2">非公共频带</option>
                </select>
              </div>
              <div class="form-group">
                <label for="BbuPoolID">BbuPool ID</label>
                <input type="text" class="form-control" id="BbuPoolID" placeholder="BbuPool ID">
              </div>
              <div class="form-group">
                <label for="BbuID">Bbu ID</label>
                <input type="text" class="form-control" id="BbuID" placeholder="BbuID ID">
              </div>
              <div class="text-right">
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addFrequencyBandModal">添加</button>
                <button type="button" class="btn btn-primary">修改</button> <!-- 修改直接在当前框里修改吧，就不单独写一个框了 -->
                <button type="button" class="btn btn-danger">删除</button>
              </div>
            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  <!-- 系统频带资源 -->

  <!-- 添加频带 -->
  <div class="modal fade" id="addFrequencyBandModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">添加频带</h4>
        </div>

        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="frequencyBandNumber">频带号</label>
              <input type="text" class="form-control" id="frequencyBandNumber" placeholder="频带号">
            </div>
            <div class="form-group">
              <label for="totalBandwidth">总带宽</label>
              <input type="text" class="form-control" id="totalBandwidth" placeholder="总带宽">
            </div>
            <div class="form-group">
              <label for="centralFrequency">中心频率</label>
              <input type="text" class="form-control" id="centralFrequency" placeholder="中心频率">
            </div>
            <div class="form-group">
              <label for="frequencyBandWidth">频带宽度</label>
              <input type="text" class="form-control" id="frequencyBandWidth" placeholder="频带宽度">
            </div>
            <div class="form-group">
              <label for="isPublicFrequencyBand">是否公共频带</label>
              <select class="form-control" id="isPublicFrequencyBand">
                <option value="1">公共频带</option>
                <option value="2">非公共频带</option>
              </select>
            </div>
            <div class="form-group">
              <label for="BbuPoolID">BbuPool ID</label>
              <input type="text" class="form-control" id="BbuPoolID" placeholder="BbuPool ID">
            </div>
            <div class="form-group">
              <label for="BbuID">Bbu ID</label>
              <input type="text" class="form-control" id="BbuID" placeholder="BbuID ID">
            </div>
            <p style="color:red">注意：若选择公共频带，不需要BbuPool ID和Bbu ID</p>  <!-- 这里最好把字体颜色改成红色 -->
          </div>

          <div class="modal-footer">
            <input type="submit" class="btn btn-primary" value="确定">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 添加频带 -->

  <!-- 非既定业务量 -->
  <div class="modal fade" id="nonEstablishedBusinessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">非既定业务量配置</h4>
        </div>
  
        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="VoIPUserProportion">VoIP用户占比</label>
              <input type="text" class="form-control" id="VoIPUserProportion" placeholder="VoIP用户占比">
            </div>
            <div class="form-group">
              <label for="nonVoIPMinSpeed">非VoIP最低速率</label>
              <input type="text" class="form-control" id="nonVoIPMinSpeed" placeholder="非VoIP最低速率">
            </div>
          </div>
  
          <div class="modal-footer">
            <input type="submit" class="btn btn-success" value="确定">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 非既定业务量 -->

  <!-- 既定业务量模型 -->
  <div class="modal fade" id="establishedBusinessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">既定业务量配置</h4>
        </div>
  
        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="file">业务量</label>
              <input type="file" id="file">
            </div>
          </div>
  
          <div class="modal-footer">
            <input type="submit" class="btn btn-success" value="确定">
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 既定业务量模型 -->

  <!-- 控制参数配置 -->
  <div class="modal fade" id="controlParameterConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">控制参数配置</h4>
        </div>

        <form name="" method="" action="">
          <div class="modal-body">
            <div class="form-group">
              <label for="sampleUnit">抽样单位</label>
              <select class="form-control" id="sampleUnit">
                <option value="TTI">TTI</option>
                <option value="s">s</option>
                <option value="m">m</option>
                <option value="h">h</option>
                <option value="d">d</option>
              </select>
            </div>
            <div class="form-group">
              <label for="TTILength">TTI时长(ms)</label>
              <input type="text" class="form-control" id="TTILength" placeholder="TTI时长(ms)">
            </div>
            <div class="form-group">
              <label for="totalLength">仿真总时长(ms)</label>
              <input type="text" class="form-control" id="totalLength" placeholder="仿真总时长(ms)">
            </div>
            <div class="form-group">
              <label for="sampleTimeTTINumber">抽样时刻TTI数</label>
              <input type="text" class="form-control" id="sampleTimeTTINumber" placeholder="抽样时刻TTI数">
            </div>
            <div class="form-group">  <!-- 这里要用JS设置效果，未实现 -->
              <label for="sampleType">抽样类型</label>
              <select class="form-control" id="sampleType">
                <option value="1">等间隔抽样</option>
                <option value="2">自定义抽样</option>
              </select>
            </div>
            <div class="form-group">  <!-- 等间隔抽样间隔 -->
              <label for="interval1">抽样间隔</label>
              <input type="text" class="form-control" id="interval1" placeholder="等间隔抽样间隔">
            </div>
            <div class="form-group">  <!-- 自定义抽样间隔 -->
              <label for="interval2">抽样间隔</label>
              <input type="text" class="form-control" id="interval2" placeholder="用逗号隔开">
            </div>
            <div class="form-group">
              <div class="row">
                <form name="" method="" action="">
                  <div class="col-md-6">
                    <label for="configFile">配置文件</label>
                    <input type="file" id="configFile">
                  </div>
                  <div class="col-md-6 text-right" style="margin-top:15px">
                    <button type="submit" class="btn btn-primary">上传</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <div class="modal-footer">  <!-- 导出参数按钮未做 -->
            <button type="submit" class="btn btn-info" data-dismiss="modal">保存</button>
            <button type="submit" class="btn btn-success" data-dismiss="modal">运行</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- 控制参数配置 -->
  <!-- 运行配置 -->

  <!-- 百度地图 -->
  <div class="container-fluid" id="container">

  </div>
  <!-- 百度地图 -->

  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap.min.js"></script>

  <script type="text/javascript">
  	//初始化地图
    var map = new BMap.Map("container");  //创建地图实例
    var point = new BMap.Point(116.404, 39.915);  //创建点坐标（此处为天安门坐标）
    map.centerAndZoom(point, 15); //初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);  //开启鼠标滚轮缩放
    
    //在地图上添加一些控件
    map.addControl(new BMap.NavigationControl());	//添加平移缩放控件 （位于地图左上方）
    map.addControl(new BMap.ScaleControl());	//添加比例尺控件（位于地图左下方）
    map.addControl(new BMap.OverviewMapControl());	//添加缩略地图（位于地图右下方）
    map.addControl(new BMap.MapTypeControl());	//添加地图类型（位于地图右上方）
    map.setCurrentCity("北京"); // 仅当设置城市信息时，MapTypeControl的切换功能才能可用
    
//  //添加标注
//  var marker=new BMap.Marker(new BMap.Point(116.380589,39.913385));
// 	map.addOverlay(marker);
// 	var marker=new BMap.Marker(new BMap.Point(116.397981,39.913828));
// 	map.addOverlay(marker);
	
// 	//添加折线
// 	var polyline=new BMap.Polyline([
//     new BMap.Point(116.380589,39.913385),
//     new BMap.Point(116.397981,39.913828)
//     ],
//     {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5}
//     );
// 	map.addOverlay(polyline);

	//测试
	<%
	String sql="select * from bbu";
	ResultSet rs=dbo.query(sql);
	while(rs.next()){
	%>
	var marker<%=rs.getInt(1) %>=new BMap.Marker(new BMap.Point(<%=rs.getDouble(3) %>,<%=rs.getDouble(4) %>));
	map.addOverlay(marker<%=rs.getInt(1) %>);
	<%} %>
  </script>
</body>

</html>
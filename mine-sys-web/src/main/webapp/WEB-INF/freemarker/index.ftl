<!DOCTYPE html>
<html lang="z-ch">
<head>
    <title>演示站点主页</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=8">
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Cache" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, userEO-scalable=no">
    <meta name="keywords" content="HTML, CSS, JS, JavaScript, framework, bootstrap, front-end, frontend, web development">
    <meta name="author" content="设计：王齐 <wangqi@bootcss.com>">
    <link href="/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/plugins/pagination/css/jquery.pagination.css" rel="stylesheet"/>
    <link href="/plugins/ztree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet"/>
    <link href="/plugins/niceValidator/dist/jquery.validator.css" rel="stylesheet"/>
    <link href="/plugins/video/css/video-js.min.css" rel="stylesheet"/>
    <link href="/plugins/jquery-toast/src/jquery.toast.css" rel="stylesheet"/>
    <link href="/css/icon/iconfont.css" rel="stylesheet"/>
    <link href="/css/menu.css" rel="stylesheet"/>
    <link href="/css/common.css" rel="stylesheet"/>
    <script src="/js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script src="/plugins/layer/layer.js" type="text/javascript"></script>
    <script src="/plugins/niceValidator/dist/jquery.validator.min.js?local=zh-CN" type="text/javascript"></script>
    <script src="/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/plugins/ztree/js/jquery.ztree.all.min.js" type="text/javascript"></script>
    <script src="/plugins/pagination/js/jquery.pagination.min.js" type="text/javascript"></script>
    <script src="/js/juicer.js"></script>
    <script src="/js/art.template.js"></script>
    <script src="/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/plugins/video/js/video.min.js" type="text/javascript"></script>
    <script src="/plugins/video/js/zh-CN.js" type="text/javascript"></script>
    <script src="/plugins/jquery-toast/src/jquery.toast.js" type="text/javascript"></script>
    <script src="/js/boot.js" type="text/javascript"></script>
    <script src="/js/sock.min.js" type="text/javascript"></script>
    <script src="/js/stomp.min.js" type="text/javascript"></script>
    <script src="/js/common.js" type="text/javascript"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 bg-primary">
            <div class="col-xs-2 banner">LONSUN EX8</div>
            <div class="col-xs-10">
                <div class="row pull-right">
                    <div class="f_left">
                        <span class="glyphicon glyphicon-home"></span>&nbsp;演示站点
                    </div>
                    <div class="f_left">
                        <span class="glyphicon glyphicon-map-marker"></span>&nbsp;${(localUser.OrganName)!'单位'}
                    </div>
                    <div class="f_left">
                        <span class="glyphicon glyphicon-edit"></span>&nbsp;${(localUser.PersonName)!'个人信息'}
                    </div>
                    <div class="f_left">
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;信息
                    </div>
                    <div class="f_left">
                        <span class="glyphicon glyphicon-off"></span>&nbsp;退出登录
                    </div>
                </div>
                <div id="mainHeader" class="row mainHeader pull-right"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2" id="mainMenu"></div>
        <div class="col-md-10" id="mainContainer"></div>
    </div>
</div>
<div id="layerWin" class="hidden"></div>
<div id="layerWin2" class="hidden"></div>
<iframe id="download_frame" name="download_frame" class="hide" src="about:blank"></iframe>
</body>
<script src="/js/sidebar-menu.js"></script>
<script id="headerMenu" type="text/html">
    <ul>
        <% for( var i = 0 ; i < data.length ; i ++ ) {%>
        <li onclick="loadLeftMenu(this)" data-id="<%=data[i].id%>">
            <i class="iconfont <%=data[i].iconClass%>"></i>&nbsp;<%=data[i].name%>
        </li>
        <%}%>
    </ul>
</script>
<script id="leftMenu" type="text/html">
    <% for( var i = 0 ; i < data.length ; i ++ ) {%>
    <% if(data[i].type == 'INDICATOR'){ %>
    <li class="header"><%=data[i].name%></li>
    <%}%>
    <%if(data[i].children.length > 0){%>
    <% for( var n = 0 ; n < data[i].children.length ; n ++ ) {%>
    <li class="treeview" type="<%=data[i].children[n].type%>" reqUrl="<%=data[i].children[n].reqUrl%>">
        <a href="#">
            <i class="iconfont <%=data[i].children[n].iconClass%>"></i>
            <span><%=data[i].children[n].name%></span>
            <i class="iconfont icon-msnui-rightmini pull-right"></i>
        </a>
        <%if(data[i].children[n].children.length > 0){%>
        <ul class="treeview-menu">
            <% for( var j = 0 ; j < data[i].children[n].children.length ; j ++ ) {%>
            <li type="<%=data[i].children[n].children[j].type%>" reqUrl="<%=data[i].children[n].children[j].reqUrl%>">
                <a href="#">
                    <i class="iconfont <%=data[i].children[n].children[j].iconClass%>"></i>
                    <span><%=data[i].children[n].children[j].name%></span>
                    <i class="iconfont icon-msnui-rightmini pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <%include('leftMenu',{data:data[i].children[n].children[j].children})%>
                </ul>
            </li>
            <%}%>
        </ul>
        <%}%>
    </li>
    <%}%>
    <%}else{%>
    <li type="<%=data[i].type%>" reqUrl="<%=data[i].reqUrl%>">
        <a href="#">
            <i class="iconfont <%=data[i].iconClass%>"></i>
            <span><%=data[i].name%></span>
            <i class="iconfont icon-msnui-rightmini pull-right"></i>
        </a>
    </li>
    <%}%>
    <%}%>
</script>
<script>
    $(document).ready(function () {
        initSocket();
        loadSysMenu();
        $(".f_left:eq(0)").click(function(){
            window.open ("/login/mainSite");
        });
        $(".f_left:eq(4)").click(function(){
            $.get("/login/logout",function(d){
                if(d.status == 1){
                    window.location.reload(true);
                }else{
                    window.location = "/login/logout";
                }
            });
        });
    });

    function loadSysMenu() {
        $.post("/menu/getMenuTree", {type: "CATAGORY"}, function (result) {
            $("#mainHeader").empty().html(template('headerMenu', {data: result}));
            $("#mainHeader ul li").click(function () {
                $(this).addClass('active-header').siblings().removeClass('active-header');
            });
            $("#mainHeader ul li:first").trigger("click");
        });
    }

    function loadLeftMenu(obj) {
        var id = $(obj).attr("data-id");
        $.post("/menu/getMenuTree", {id: id, queryFlag: '1'}, function (result) {
            $("#mainMenu").empty().html("<ul class=\"sidebar-menu\">" + template('leftMenu', {data: result}) + "</ul>");
            $.sidebarMenu($('.sidebar-menu'));
            $('.sidebar-menu li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var type = $(this).attr("type");
                var url = $(this).attr("reqUrl");
                if (type == 'URL') {
                    if (url == undefined || url == '') {
                        layer.msg("缺少地址参数，无法访问该功能！", {icon: 2, shade: 0.01, time: 1000});
                        return;
                    } else {
                        $("#mainContainer").empty().load(url, function (response, status, xhr) {
                            if (status == 'error') {
                                var errorCode = xhr.status;
                                if (errorCode == '403') {
                                    $(this).load("/common/403");
                                } else if (errorCode == '404') {
                                    $(this).load("/common/404");
                                } else if (errorCode == '500') {
                                    $(this).load("/common/500");
                                } else if (errorCode == '404') {
                                    $(this).load("/common/503");
                                }
                            }
                        });
                    }
                }
            });
            $("#mainMenu ul li").each(function () {
                if (this.type == 'URL') {
                    $(this).trigger('click').addClass('active');
                    return false;
                }
            });
        });
    }
    setInterval(function(){
        var h = document.documentElement.clientHeight;
        var bodyHeight = document.getElementById("mainContainer");
        bodyHeight.style.height = (h - 70) + "px";
    },200);
</script>
</html>
<div class="portlet light">
    <div class="portlet-body">
        <div class="table-toolbar" style="margin-bottom: 5px">
            <div class="row">
                <div class="col-md-1">
                    <button id="adduser_btn" class="btn btn-info btn-export" onclick="exportLog()"> 导 出 </button>
                </div>
                <div class="col-md-11">
                    <form class="form-inline tr search-toolbar pull-right" role="form" id="loginForm">
                        <div class="form-group">
                            <select class="form-control" id="type" ms-duplex="dropdown">
                                <option value="uid">用户名</option>
                                <option value="createUser">姓名</option>
                                <option value="organName">单位名称</option>
                                <option value="loginIp">登入IP</option>
                                <option value="description">描述</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" name="startDate" id="startDate" class="form-control w160"
                                   placeholder="开始时间"
                                   onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
                        </div>
                        <div class="form-group">
                            <input type="text" name="endDate" id="endDate" class="form-control w160"
                                   placeholder="结束时间"
                                   onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
                        </div>
                        <div class="form-group">
                            <input type="text" id="searchKey" name="searchKey" class="form-control w120"
                                   placeholder="关键词">
                        </div>
                        <button type="button" class="btn btn-primary btn-search" onclick="search()">查询</button>
                        <button type="button" class="btn btn-success" onclick="searchClear()">显示全部</button>
                    </form>
                </div>
            </div>
        </div>
        <div id="datagrid1" class="mini-datagrid" style="width:100%;height:600px;" allowCellSelect="false"
             onlyCheckSelection="true"
             allowResize="true" url="/sysLog/getLoginPage" sizeList="[20,30,50]" pageSize="20"
             idField="id" multiSelect="flase">
            <div property="columns">
                <!-- 复选框列-->
                <!--<div type="checkcolumn"></div>-->
                <!-- 序号列-->
                <div type="indexcolumn" width="50" headerAlign="center" align="center">序号</div>
                ##
                <div field="uid" width="100" headerAlign="center" align="center">用户名</div>
                <div field="createUser" width="100" headerAlign="center" align="center">姓名</div>
                <div field="organName" width="200" headerAlign="center" align="center">单位名称
                </div>
                <div field="loginIp" width="110" headerAlign="center" align="center">登录IP</div>
                <div field="createDate" width="140" headerAlign="center" align="center"
                     dateFormat="yyyy-MM-dd HH:mm:ss">
                    登录时间
                </div>
                <div width="140" headerAlign="center" align="center" renderer="renderdescrip">描述</div>
                <div width="30%" headerAlign="center" align="center" renderer="renderdesOther">其他</div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    mini.parse();
    cmm = {
        dataFlag: 1,
        siteId: null
    }
    var grid = mini.get("datagrid1");

    grid.load(cmm);

    //条件查询
    var search = function () {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var key = $("#searchKey").val();
        var type = $("#type").val();
        grid.load({startDate: startDate, endDate: endDate, type: type, key: key, dataFlag: 1});
    }

    //清除条件
    var searchClear = function () {
        $("#loginForm")[0].reset();
        grid.load({dataFlag: 1});
    }

    //描述
    function renderdescrip(e) {
        var str = "";
        var rec = e.record;
        if (rec.description == '登录成功' || rec.description == '登录成功。' || rec.description == '退出成功') {
            str = rec.description;
        } else {
            str = '<font class="red">' + rec.description + '</font>';
        }
        return str;
    }

    //其他信息
    function renderdesOther(e) {
        var rec = e.record;
        var os = rec.os;
        var browser = rec.browser;
        var resolutionRatio = rec.resolutionRatio;
        var clientVersion = rec.clientVersion;
        var str = "";
        if (os != null && os.trim().length > 0) {
            str = "os=" + os;
        }
        if (browser != null && browser.trim().length > 0) {
            str = str + ";browser=" + browser;
        }
        if (resolutionRatio != null && resolutionRatio.trim().length > 0) {
            str = str + ";resolutionRatio=" + resolutionRatio;
        }
        if (clientVersion != null && clientVersion.trim().length > 0) {
            str = str + ";clientVersion=" + clientVersion;
        }
        return str;
    }

    var exportLog = function () {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var key = $("#searchKey").val();
        var type = $("#type").val();
        var params = "startDate=" + startDate + "&endDate=" + endDate + "&key=" + key + "&type=" + type;
        $('#download_frame').attr("src", "/sysLog/getLogHistoryExport?" + params);
    }

    function onKeyEnter(e) {
        search();
    }

</script>
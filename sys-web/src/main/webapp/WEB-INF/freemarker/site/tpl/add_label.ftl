0#parse("_page_layout/_header.vm")
</head>
<!-- END HEAD -->
<body class="page-body-white" ms-controller="label_form">

<div id="ui_layout" class="mini-layout" style="width:100%;height:100%;" >
    <div region="center" style="border:none; overflow: auto;">
        <div class="portlet light">
            <div class="portlet-body form">
                <form id="label_form" role="form">
                    <div class="form-body">
                        <div class="form-group">
                            <label>标签选择</label>
                            <input id="tpl_label_comb" class="form-control mini-treeselect" style="width:100%;height: 30px"
                                   multiSelect="false" valueFromSelect="false"
                                   textField="name" valueField="id" parentField="pId" value=""
                                   onbeforenodeselect="beforenodeselect" allowInput="true"
                                   showRadioButton="false" showFolderCheckBox="false"
                                   url="/label/tree?dataFlag=1&pid=-1"
                                    />
                        </div>
                        <div class="form-group">
                            <label>标签内容</label>
                            <textarea id="label_val" class="form-control" style="width: 100%;height: 100%"></textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div region="south" height="57" splitSize="0" showHeader="false" allowResize="false" showSplit="false"
         style="border:none; border-top: solid 1px #E9EDEF; overflow:hidden;">
        <div class="pd10 tr">
            <button type="button" class="btn btn-default btn-save" onclick="ok()">确 定</button>
            <button type="button" class="btn btn-default btn-reset" onclick="closeLabel()">关 闭</button>
        </div>
    </div>
</div>
#parse("_page_layout/_footer.vm")
<script src="$!{sysStaticPath}/assets/scripts/Comm.Func.js"></script>
<script>
    mini.parse();
    var cur = {
        labelCombo : mini.get("tpl_label_comb"),
        labelNode : null,
        labelVal : $('#label_val')
    };

    $(document).ready(function () {
        cur.labelCombo.on('nodeclick', function (node) {
            if (!isNull(node.node)) {
                cur.labelNode = node.node;
                cur.labelVal.val(node.node.config);
            }
        });
    })

    function ok() {
        parent.insertLabelVal(cur.labelNode.config);
    }

    function closeLabel() {
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);
    }

    function beforenodeselect(e) {
        //禁止选中父节点
        if (e.isLeaf == false) e.cancel = true;
    }
</script>
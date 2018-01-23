<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志显示服务</title>
    <style type="text/css">
        .wrapper {
            width: 1020px;
            margin: 0 auto;
            padding: 20px;
            background: #FFF;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="panel-body mod-json">
        <div>
            <div class="row">
                <label>服务器地址：</label>
                <input type="radio" name="url" checked="true" >线上
                <input type="radio"  name="url" >线下
                <input type="radio"  name="url" >其他
                <input type="text" >
            </div>

        </div>
        <div class="row ui-mt-10">
            <button id="confirm_button" class="btn btn-success ui-fl-r">生成QR图</button>
        </div>
        <div class="row ui-mt-20"><h4>结果</h4>
            <hr class="x-hr">
            <div id="preview">
                <canvas width="200" height="200"></canvas>
            </div>
        </div>
    </div>

</div>
</body>
</html>

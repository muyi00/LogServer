<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志显示服务</title>
    <style type="text/css">
        .parent {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            padding-top: 8rem;
            min-height: 520px;
            background-color: rgba(0, 0, 0, 0);
            background-color: #0079b6;
        }

        .child {
            max-width: 40rem;
            margin: auto;
            border-radius: 10px;
            background-color: rgb(255, 255, 255);
            box-shadow: 0px 6px 7.84px 0.16px rgba(0, 47, 71, 0.3);
            font-family: "Microsoft YaHei";
            padding: 1.5625rem 3.75rem 3.5rem 3.75rem;
        }

        .row {
            width: 100%;
            height: 2rem;
            font-size: 1rem;
        }
    </style>
</head>
<body>
<div class="parent">
    <div class="child">
        <div class="row">
            服务器地址：
            <input type="radio" id="url_online" checked="true" onclick="url_online_change()">线上
            <input type="radio" id="url_offline" onclick="url_offline_change()">线下
            <input type="radio" id="url_other" onclick="url_otherchange()">其他
        </div>
        <div class="row">
            <input id="url" placeholder="请输入服务器地址" width="100" type="text">
        </div>

        <div class="row">
            是否开启环信：<input type="checkbox">
        </div>
        <div class="row">
            是否调试模式：<input type="checkbox">
        </div>
        <div class="row">
            日志是否写到文件中：<input type="checkbox">
        </div>
        <button type="submit" class="row">生成二维码</button>
        <div id="qrcode"/>
    </div>
</div>
</body>
<script>
    function url_online_change() {
        document.getElementById("url_online").checked = true;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_other").checked = false;
    }
    function url_offline_change() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = true;
        document.getElementById("url_other").checked = false;
    }
    function url_otherchange() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_other").checked = true;
    }


</script>
</html>

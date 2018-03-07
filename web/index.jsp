<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>运气到家调试配置</title>
    <script src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="http://static.runoob.com/assets/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://static.runoob.com/assets/qrcode/qrcode.min.js"></script>

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
            width: 30rem;
            height: 30rem;
            background-color: rgb(255, 255, 255);
            margin: auto;
            border-radius: 10px;
            box-shadow: 0px 6px 7.84px 0.16px rgba(0, 47, 71, 0.3);
            padding: 1.5625rem 3.75rem 3.5rem 3.75rem;
            font-family: "Microsoft YaHei";
        }

        .row {
            width: 100%;
            height: 2rem;
            font-size: 1rem;
        }

        .qr {
            position: relative;
            left: 50%;
            margin-top: 50px;
            margin-left: -100px;
            /*margin:auto;*/
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
            <input type="radio" id="url_shuang" onclick="url_shuang_change()">双
            <input type="radio" id="url_tao" onclick="url_tao_change()">涛
            <input type="radio" id="url_other" onclick="url_otherchange()">其他
        </div>
        <div class="row" id="url_input_row" style="display:none;">
            <input id="url" placeholder="请输入服务器地址" style="width:100%" type="text">
        </div>

        <div class="row" style="display:none;">
            是否开启环信：<input type="checkbox" id="isOpenHx" checked="true">
        </div>
        <div class="row">
            是否调试模式：<input type="checkbox" id="isDebug">
        </div>
        <div class="row">
            日志是否写到文件中：<input type="checkbox" id="isWriteLog">
        </div>
        <button type="button" class="row" onclick="createQR()">生成二维码</button>
        <div id="qrcode" class="qr"></div>

    </div>
</div>
</body>
<script>
    var URL_COOL = "http://cool.haoyunqi.com.cn";
    var URL_220 = "http://192.168.2.220:8080/cool.web";
    var URL_SHUANG = "http://192.168.2.21:8080/cool.shuang";
    var URL_TAO = "http://192.168.2.20:8080/cool.web";

    var qrcode = new QRCode(document.getElementById("qrcode"), {
        text: "",
        width: 200,
        height: 200,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.H
    });


    function createQR() {

        var url = URL_220;
        if (document.getElementById("url_online").checked) {
            url = URL_COOL;
        } else if (document.getElementById("url_offline").checked) {
            url = URL_220;
        } else if (document.getElementById("url_shuang").checked) {
            url = URL_SHUANG;
        } else if (document.getElementById("url_tao").checked) {
            url = URL_TAO;
        } else {
            var otherUrl = document.getElementById("url").value;
            var str = otherUrl.replace(/(^\s*)|(\s*$)/g, '');//去除空格;
            if (str == '' || str == undefined || str == null) {
                alert("地址不能为空")
                return;
            }
            url = otherUrl;
        }

        var isOpenHx = document.getElementById("isOpenHx").checked;
        var isDebug = document.getElementById("isDebug").checked
        var isWriteLog = document.getElementById("isWriteLog").checked

        var params = {
            "packageName": "com.dlh.hqy.psclient",
            "dateStr": getCurrentDateYYYYMMDD(),
            "urlStr": url,
            "openHx": isOpenHx,
            "debug": isDebug,
            "writeLog": isWriteLog
        }
        var json = JSON.stringify(params);

        //alert(json)
        qrcode.clear();
        qrcode.makeCode(json);
    }


    function url_online_change() {
        document.getElementById("url_online").checked = true;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_shuang").checked = false;
        document.getElementById("url_tao").checked = false;
        document.getElementById("url_other").checked = false;
        document.getElementById("url_input_row").style.display = 'none';

    }

    function url_offline_change() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = true;
        document.getElementById("url_shuang").checked = false;
        document.getElementById("url_tao").checked = false;
        document.getElementById("url_other").checked = false;
        document.getElementById("url_input_row").style.display = 'none';
    }

    function url_shuang_change() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_shuang").checked = true;
        document.getElementById("url_tao").checked = false;
        document.getElementById("url_other").checked = false;
        document.getElementById("url_input_row").style.display = 'none';
    }

    function url_tao_change() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_shuang").checked = false;
        document.getElementById("url_tao").checked = true;
        document.getElementById("url_other").checked = false;
        document.getElementById("url_input_row").style.display = 'none';
    }


    function url_otherchange() {
        document.getElementById("url_online").checked = false;
        document.getElementById("url_offline").checked = false;
        document.getElementById("url_shuang").checked = false;
        document.getElementById("url_tao").checked = false;
        document.getElementById("url_other").checked = true;
        document.getElementById("url_input_row").style.display = 'block';
        document.getElementById("url").value = URL_220;
    }

    function getCurrentDateYYYYMMDD() {
        var nowDate = new Date();
        var year = nowDate.getFullYear();
        var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
        var day = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
        return year + month + day + "";
    }

</script>
</html>

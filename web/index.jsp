<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志系统</title>
    <style type="text/css">
        #Container {
            width: 100%;
            height: 100%;
            background: #FFF;
        }
    </style>

    <%--<script type="text/javascript">--%>
        <%--var xmlHttpRequest;--%>
        <%--//XmlHttpRequest对象--%>
        <%--function createXmlHttpRequest(){--%>
            <%--if(window.ActiveXObject){ //如果是IE浏览器--%>
                <%--return new ActiveXObject("Microsoft.XMLHTTP");--%>
            <%--}else if(window.XMLHttpRequest){ //非IE浏览器--%>
                <%--return new XMLHttpRequest();--%>
            <%--}--%>
        <%--}--%>

        <%--function getLog(){--%>
            <%--var url = "http://localhost:8080/log";--%>
            <%--//1.创建XMLHttpRequest组建--%>
            <%--xmlHttpRequest = createXmlHttpRequest();--%>

            <%--//2.设置回调函数--%>
            <%--xmlHttpRequest.onreadystatechange = zswFun;--%>

            <%--//3.初始化XMLHttpRequest组建--%>
            <%--xmlHttpRequest.open("GET",url,true);--%>

            <%--//4.发送请求--%>
            <%--xmlHttpRequest.send(null);--%>
        <%--}--%>


        <%--//回调函数--%>
        <%--function zswFun(){--%>
            <%--if(xmlHttpRequest.readyState == 4 && xmlHttpRequest.status == 200){--%>
                <%--document.getElementById(Content).innerHTML=xmlHttpRequest.responseText;--%>
            <%--}--%>
        <%--}--%>

        <%--setTimeout('getLog()', 3000);--%>
    <%--</script>--%>
</head>
<body>
    <h6>LogServer</h6>
</body>
</html>

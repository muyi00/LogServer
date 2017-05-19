import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/5/18.
 */
public class LogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final int MAX_LOGINFO = 100;

    private List<String> logList = new ArrayList<String>();
    // private String htmlFormat = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><title></title></head><body>%s<script type=\"text/javascript\">function myrefresh(){window.location.reload();window.scrollTo(0,document.body.scrollHeight);}setTimeout('myrefresh()',10000); </script></body></html>";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("content-type", "text/html;charset=UTF-8");

        String timeStr = req.getParameter("time");
        String name= req.getParameter("name");

        StringBuffer sb = new StringBuffer();
        for (String log : logList) {
            String itemLog=getLogItemHtml(log,name);
            if(itemLog!=null&&itemLog.length()>0){
                sb.append(itemLog);
            }
        }
        String temp = String.format(getHtmlFormat(getInterval(timeStr)), sb.toString());
        PrintWriter out = resp.getWriter();
        out.println(new String(temp.getBytes(), "GBK"));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        InputStream inputStream = req.getInputStream();
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        String result = "";
        try {
            byte[] data = new byte[1024];
            int len = 0;
            result = "";
            if (inputStream != null) {
                while ((len = inputStream.read(data)) != -1) {
                    byteArrayOutputStream.write(data, 0, len);
                }
                result = new String(byteArrayOutputStream.toByteArray(), "UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            byteArrayOutputStream.close();
            inputStream.close();
        }

        if(result!=null&&result.length()>0){
            logList.add(result);
            if (logList.size() > MAX_LOGINFO) {
                logList.remove(0);
            }
        }
    }


    private String getLogItemHtml(String result,String name){
        StringBuffer sb = new StringBuffer();

        try {
            LogInfo info=  JSON.parseObject(result,LogInfo.class);
            if (name != null && name.length() > 0) {
                if(!name.equals(info.getName())){
                    return "";
                }
            }
            sb.append("<span>{</span>");
            sb.append("<ul>");
            sb.append("<li style=\"list-style-type:none\"> \"name\" : \""+info.getName()+"\"</li>");
            sb.append("<li style=\"list-style-type:none\"> \"time\" : \""+info.getTime()+"\"</li>");
            sb.append("<li style=\"list-style-type:none\"> \"level\" : \""+info.getLevel()+"\"</li>");
            sb.append("<li style=\"list-style-type:none\"> \"tag\" : \""+info.getTag()+"\"</li>");
            sb.append("<li style=\"list-style-type:none\"> \"stack\" : \""+info.getStack()+"\"</li>");
            sb.append("<li style=\"list-style-type:none\"> \"msg\" : \""+info.getMsg().replace("\n","</br>")+"\"</li>");
            sb.append("</ul>");
            sb.append("<span>}</span>");
        }catch (JSONException e){
            sb.append(result);
        }
        return  sb.toString();
    }


    /**
     * 计算刷新间隔时间
     * @param timeStr
     * @return
     */
    private int getInterval(String timeStr) {
        int timeNum;
        try {
            timeNum = Integer.parseInt(timeStr);
            if (timeNum < 2) {
                timeNum = 0;
            }
            if (timeNum > 6) {
                timeNum = 6;
            }
        } catch (NumberFormatException e) {
            timeNum = 0;
        }
        return timeNum * 1000;
    }


    /**
     * @param time 刷新间隔时间  毫秒
     * @return
     */
    private String getHtmlFormat(int time) {
        StringBuffer sb = new StringBuffer();
        sb.append("<html>");
        sb.append("<head>");
        sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
        sb.append("<title></title>");
        sb.append("</head>");
        sb.append("<body>");
        sb.append("<div  style=\"padding-left:50px\">");
        sb.append("%s");
        if(time!=0){
            sb.append("<script type=\"text/javascript\">");
            sb.append("function myrefresh(){window.location.reload();window.scrollTo(0,document.body.scrollHeight);}setTimeout('myrefresh()'," + time + "); ");
            sb.append("</script>");
        }
        sb.append("</div>");
        sb.append("</body>");
        sb.append("</html>");
        return sb.toString();
    }


}
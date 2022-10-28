from flask import (
    Flask,
    render_template
)

from views.dev import dev_module
from views.rls import rls_module
from views.apis import apis_module

app = Flask(__name__)
app.register_blueprint(dev_module)
app.register_blueprint(rls_module)
app.register_blueprint(apis_module)

@app.route("/")
def index() :
    return render_template(
        "index/index.html"
    )

if __name__ == "__main__" :
    app.run(debug=True)
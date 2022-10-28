from flask import (
    render_template,
    Blueprint
)

rls_module = Blueprint("rls", __name__)

@rls_module.route("/contents/rls/index")
def rls_index() :
    return render_template(
        "rls/index.html"
    )
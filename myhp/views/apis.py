from flask import (
    render_template,
    Blueprint
)

apis_module = Blueprint("apis", __name__)

@apis_module.route("/contents/apis/index")
def apis_index() :
    return render_template(
        "apis/index.html"
    )
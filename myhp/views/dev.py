from flask import (
    render_template,
    Blueprint
)

dev_module = Blueprint("dev", __name__)

@dev_module.route("/contents/dev/index")
def dev_index() :
    return render_template(
        "dev/index.html"
    )
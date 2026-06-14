from datasette import hookimpl
from datasette.utils.asgi import Response


@hookimpl
def register_routes():
    return [
        (r"^/about$", about_page),
        (r"^/contribute$", contribute_page),
    ]


async def about_page(datasette, request):
    return Response.html(
        await datasette.render_template("about.html", {}, request=request)
    )


async def contribute_page(datasette, request):
    return Response.html(
        await datasette.render_template("contribute.html", {}, request=request)
    )

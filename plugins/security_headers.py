from datasette import hookimpl

SECURITY_HEADERS = [
    (b"x-content-type-options", b"nosniff"),
    (b"x-frame-options", b"DENY"),
    (b"referrer-policy", b"strict-origin-when-cross-origin"),
    (b"permissions-policy", b"geolocation=(), camera=(), microphone=()"),
]


@hookimpl
def asgi_wrapper(datasette):
    def wrap(app):
        async def add_security_headers(scope, receive, send):
            async def patched_send(event):
                if event["type"] == "http.response.start":
                    headers = list(event.get("headers", []))
                    headers.extend(SECURITY_HEADERS)
                    event = {**event, "headers": headers}
                await send(event)
            await app(scope, receive, patched_send)
        return add_security_headers
    return wrap

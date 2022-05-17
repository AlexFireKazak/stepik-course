def app(environ, start_response):
    in_text = environ['QUERY_STRING'].split('&')
    data = '\n'.join(in_text).encode('utf-8')
    start_response("200 OK", [
        ("Content-Type", "text/plain"),
        ("Content-Length", str(len(data)))
    ])
    return iter([data])


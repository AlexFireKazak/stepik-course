def app(environ, start_response):
    in_text = environ['QUERY_STRING'][2:].split('&')
    data = '\n'.join(in_text).encode('utf-8')
    start_response("200 OK", [
        ("Content-Type", "text/plain"),
        ("Content-Length", str(len(data)))
    ])
    return iter([data])

environ = '/?a=1&a=2&b=3'
in_text = environ[2:].split('&')
print(in_text)
out_text = '\n'.join(in_text).encode('utf-8')
print(out_text)
## App1: Python + Flask

<b>App2</b> is built based on Python lightweight WSGI web application framework <b>Flask</b>, running in development mode, that calls <b>App1</b> as HTTP client and returns inverted message.

### Methods
- <b>GET</b>

### Paths

- <b>/</b> - home path, returns:
```sh
dlrow olleH
```
- <b>/health</b> - health path, returns:
```sh
healthy
```

### Ports
- <b>8080</b> from inside the cluster;
- <b>32000</b> from outside the cluster (<b>nodePort</b>).

### TODO:
- graceful shutdown;
- unittests;
- TBD.
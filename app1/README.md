## App1: Python + Flask

App1 is built based on Python lightweight WSGI web application framework <b>Flask</b>, running in development mode.

### Methods
- <b>GET</b>

### Paths

- <b>/</b> - home path, returns:
```sh
{
    “id”: “<REQUEST ID>”,
    “message”: “Hello world”
}
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

## Deployment: Helm + Kubectl apply
For the templates rendering we're using here Helm, where we can split based on the environment (dev, qa, stage, etc) and generate for each stage separate manifests with custom parameters/inputs.
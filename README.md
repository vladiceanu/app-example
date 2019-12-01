## Example project: microK8s + Python
This is a simple project that includes a <b>microK8s</b> deployment and 2 Python applications that run inside <a href="https://microk8s.io/">microK8s</a>.

## Overview
<b>App1</b> is running a HTTP server that returns 
```json
{
    “id”: “1”,
    “message”: “Hello world”
}
```
when called with method <b>GET</b> by any HTTP client.

<b>App2</b> is also running a HTTP server that will call <b>App1</b> with <b>GET</b> method and return inversed message text.

Both applications are running in Kubernetes environment and their deployment/redeployment is fully automated. A few tests are also covered.

## System Requirements
1. One <b>Debian GNU/Linux 9</b> VM; 
2. min: 1CPU; 2Gi Memory; 10Gi Storage;<br>
2. root SSH access to the VM;<br>
3. ports <b>32000 - 32001</b> and <b>8080</b> available.

## Environment preparation
1. Install build-essential and git: 
```sh
sudo apt update
sudo apt install -y build-essential git
```
2. Clone repo:
```sh
git clone https://github.com/vladiceanu/app-example.git
cd app-example/
```
3. Run environment setup:
```sh
make setup
```
4. Re-login order the changes to take effect.
6. Run the test that will check the environment:
```sh
cd app-example/
make test_env
```
## Deployment of applications
In order to deploy an application, you need to:
1. Set environment variable <b>APP</b> to app name you want to deploy and run apply:
```sh
export APP=app1
make apply
```
2. Check your application status in K8s:
```sh
microk8s.kubectl -n app1 get pods
```
3. To redeploy any changes, simply run again <b>step 1</b>, we'll take care of the rest (testing, rendering, redeploying, etc).

## Access the applications
In order to make the applications accessible from outside the node and avoid introduction of any kind of Proxy or LoadBalancers, I've decided to use service type <b>NodePort</b> that will expose each of our applications. Thus, here is what we have:
1. <b>app1</b> uses port <b>32000</b>;
2. <b>app2</b> uses port <b>32001</b>;

Example:
```sh
curl http://<VM_IP>:32000/ # accessing app1
curl http://<VM_IP>:32001/ # accessing app2
```

## TODO
- Add unittests for the Python code; 
- Add more detailed description of the applications;
- Make preparation of the VM environment OS agnostic;
- Improve the env tests;

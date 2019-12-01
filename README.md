## Example project: microK8s + Python
<hr>
This is a simple project that includes a <b>microK8s</b> deployment and 2 Python applications that run inside <a href="https://microk8s.io/">microK8s</a>.

## System Requirements
1. One <b>Debian GNU/Linux 9</b> VM; 
2. min: 1CPU; 4Gi Memory; 10Gi Storage;<br>
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
2. Check your application status:
```sh
microk8s.kubectl -n app1 get pods

and

http://<VM-IP>:32000/health
``` 
This will cover building the image, testing it and deploying to MicroK8s, making it available thru a NodePort:
1. <b>APP1</b>: http://<VM_IP>:32000/ and /health
2. <b>APP2</b>: http://<VM_IP>:32001/ and /health

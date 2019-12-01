## Example project: microK8s + Python
<hr>
This is a simple project that includes a <b>microK8s</b> deployment and 2 Python application that run inside microK8s.

## System Requirements
<hr>
1. One VM with OS <u>Debian GNU/Linux 9</u>; 2CPU; 4Gi Memory; 10Gi Storage.<br>
2. Root SSH access to the VM.<br>
3. Ports `32000-32001` and `8080` available to be bind.

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
4. Set your user permissions for docker and microK8s:
```sh
sudo usermod -a -G microk8s $(whoami)
sudo usermod -a -G docker $(whoami)
```
5. Logout and login in order the changes to take effect.
6. Add `/snap/bin` to environment and run test:
```sh
export PATH="$PATH:/snap/bin"
cd app-example/
make test_env
```

APP?=app1
ENV?=dev
REV?=latest

build:
	@echo "aa"

render:
	microk8s.helm template -f ${APP}/charts/values/${ENV}.yaml --set image.rev=${REV} ${APP}/charts/

apply:
	microk8s.kubectl apply 
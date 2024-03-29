APP?=app1
ENV?=dev
REV?=local

setup: 
	(cd provision/ && ./setup.sh)

test_env:
	(cd provision/ && ./test.sh)

test_app:
	(cd ${APP}/app/ && ./test.sh)

build: 
	docker build -t ${APP}:${REV} ${APP}/.
	docker save ${APP} > ${APP}.tar
	microk8s.ctr --namespace k8s.io image import ${APP}.tar
	rm -rf ${APP}.tar

render:
	microk8s.helm template -f ${APP}/ops/values/${ENV}.yaml \
		--set image.rev=${REV} ${APP}/ops/ \
		--output-dir ${APP}/ops/manifests 

deploy: build test_app render
	microk8s.kubectl apply -f ${APP}/ops/manifests -R
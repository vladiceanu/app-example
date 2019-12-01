#!/usr/bin/env bats

DOCKER_PORT=8080
DOCKER_NAME=app1-test
APP_PORT=8080

@test "is app starting" {
    run docker run -p ${DOCKER_PORT}:${APP_PORT} --name ${DOCKER_NAME} --rm -d ${APP}:local
    [ "$status" -eq 0 ]
}

@test "is app running" {
    run docker ps -a --filter name=${DOCKER_NAME} --filter status=running --format '{{.Status}}'
    [ "$status" -eq 0 ]
    [[ "$output" == "Up"* ]]
}

@test "is app healthy" {
    run sleep 5
    run curl -sSL -q http://localhost:8080/health
    [ $status -eq 0 ]
    [[ "$output" == *"healthy"* ]]

}
@test "is app stopping" {
    run docker stop ${DOCKER_NAME}
    [ "$status" -eq 0 ]
}

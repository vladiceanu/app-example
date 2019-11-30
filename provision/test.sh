#!/usr/bin/env bats

DOCKER_VERSION="19.03.5"
MICROK8S_VERSION="v1.16.3"


@test "is snapd installed" {
    run snap --version
    [ "$status" -eq 0 ]
    [[ "${lines[0]}" == *"snap"* ]]
    [[ "${lines[1]}" == *"snapd"* ]]
}
@test "is snap present in PATH" {
    run echo $PATH
    [ "$status" -eq 0 ]
    [[ "$output" == *"snap/bin"* ]]
}
@test "is microk8s installed" {
    run microk8s.status --wait-ready
    [ "$status" -eq 0 ]
    [[ "$output" == *"microk8s is running"* ]]
}

@test "is microk8s of ${MICROK8S_VERSION} installed" {
    run snap info microk8s
    [ "$status" -eq 0 ]
    [[ "$output" == *"installed:"*"${MICROK8S_VERSION}"* ]]
}

@test "is microk8s.dns enabled" {
    run microk8s.status
    [[ "$output" == *"dns: enabled"* ]]
}

@test "is microk8s.helm enabled" {
    run microk8s.status
    [[ "$output" == *"helm: enabled"* ]]
}

@test "is docker version ${DOCKER_VERSION} present" {
    run docker version
    [ "$status" -eq 0 ]
    [[ "$output" == *"${DOCKER_VERSION}"* ]]
}

@test "is python present" {
    run python --version
    [ "$status" -eq 0 ]
    [[ "$output" == *"Python"* ]]
}

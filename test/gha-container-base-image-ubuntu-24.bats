#!/usr/bin/env bats

@test "gcc version" {
  run bash -c "docker exec gha-container-base-image gcc --version"
  [[ "${output}" =~ "13.2" ]]
}

@test "make version" {
  run bash -c "docker exec gha-container-base-image make --version"
  [[ "${output}" =~ "4.3" ]]
}

@test "curl version" {
  run bash -c "docker exec gha-container-base-image curl --version"
  [[ "${output}" =~ "8.5" ]]
}

@test "wget version" {
  run bash -c "docker exec gha-container-base-image wget --version"
  [[ "${output}" =~ "1.21" ]]
}

@test "unzip version" {
  run bash -c "docker exec gha-container-base-image unzip -v"
  [[ "${output}" =~ "6.0" ]]
}

@test "zip version" {
  run bash -c "docker exec gha-container-base-image zip --version"
  [[ "${output}" =~ "3.0" ]]
}

@test "jq version" {
  run bash -c "docker exec gha-container-base-image jq --version"
  [[ "${output}" =~ "1.7" ]]
}

@test "gnupg version" {
  run bash -c "docker exec gha-container-base-image gpg --version"
  [[ "${output}" =~ "2.4" ]]
}

@test "bash version" {
  run bash -c "docker exec gha-container-base-image bash --version"
  [[ "${output}" =~ "5.2" ]]
}

@test "check locale" {
  run bash -c "docker exec gha-container-base-image locale"
  [[ "${output}" =~ "LC_ALL=en_US.UTF-8" ]]
}

@test "1password version" {
  run bash -c "docker exec gha-container-base-image op --version"
  [[ "${output}" =~ "2.30" ]]
}

@test "teller version" {
  run bash -c "docker exec gha-container-base-image teller version"
  [[ "${output}" =~ "1.5.6" ]]
}

@test "vault version" {
  run bash -c "docker exec gha-container-base-image vault -v"
  [[ "${output}" =~ "1.18" ]]
}

@test "gh version" {
  run bash -c "docker exec gha-container-base-image gh --version"
  [[ "${output}" =~ "2.59" ]]
}

#!/usr/bin/env bats

@test "os-release version" {
  run bash -c "docker exec gha-container-base-image cat /etc/os-release"
  [[ "${output}" =~ "Ubuntu 22.04" ]]
}

@test "gnupg version" {
  run bash -c "docker exec gha-container-base-image gpg --help"
  [[ "${output}" =~ "gpg (GnuPG)" ]]
}

@test "docker version" {
  run bash -c "docker exec gha-container-base-image docker --help"
  [[ "${output}" =~ "Usage:  docker [OPTIONS] COMMAND" ]]
}

@test "1password version" {
  run bash -c "docker exec gha-container-base-image op --help"
  [[ "${output}" =~ "Usage:  op [command] [flags]" ]]
}

@test "teller version" {
  run bash -c "docker exec gha-container-base-image teller --help"
  [[ "${output}" =~ "Usage: teller <command>" ]]
}

@test "vault version" {
  run bash -c "docker exec gha-container-base-image vault --help"
  [[ "${output}" =~ "Usage: vault <command> [args]" ]]
}

@test "gh version" {
  run bash -c "docker exec gha-container-base-image gh --help"
  [[ "${output}" =~ "Work seamlessly with GitHub from the command line." ]]
}

@test "check locale" {
  run bash -c "docker exec gha-container-base-image locale"
  [[ "${output}" =~ "LC_ALL=en_US.UTF-8" ]]
}

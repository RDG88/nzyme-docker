# -------- Variables --------
variable "IMAGE_REGISTRY_PREFIX" {
  # Overridden by GitHub Actions secret (e.g., "docker.io/graafnet" or just "graafnet")
  default = "docker.io/graafnet"
}

variable "NZYME_NODE_DOCKER_IMAGE_NAME" { default = "nzyme-node" }
variable "NZYME_TAP_DOCKER_IMAGE_NAME"  { default = "nzyme-tap" }

# -------- Groups --------
group "all_nzyme_nodes" { targets = ["nzyme_node_v2a15"] }
group "all_nzyme_taps"  { targets = ["nzyme_tap_v2a17"] }

# -------- Nzyme node base --------
target "_nzyme_node" {
  context    = "nzyme_node"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64"]
  contexts = {
    base_image = "docker-image://ubuntu:22.04"
  }
  args = {
    PORT            = 22900
    DOWNLOAD_TARGET = ""
  }
  output = ["type=registry"]
}

target "nzyme_node_v2a13" {
  inherits = ["_nzyme_node"]
  args = {
    OPEN_JDK_PACKAGE = "openjdk-11-jre-headless"
    DOWNLOAD_TARGET  = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.13/nzyme-node_2.0.0-alpha.13.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_NODE_DOCKER_IMAGE_NAME}:v2a13",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_NODE_DOCKER_IMAGE_NAME}:latest"
  ]
}

target "nzyme_node_v2a15" {
  inherits = ["_nzyme_node"]
  args = {
    OPEN_JDK_PACKAGE = "openjdk-17-jre-headless"
    DOWNLOAD_TARGET  = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.15/nzyme-node_ubuntu-2204jammy-noarch-2.0.0-alpha.15.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_NODE_DOCKER_IMAGE_NAME}:v2a15",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_NODE_DOCKER_IMAGE_NAME}:latest"
  ]
}

# -------- Nzyme tap base --------
target "_nzyme_tap" {
  context    = "nzyme_tap"
  dockerfile = "Dockerfile"
  platforms  = ["linux/arm64"]
  contexts = {
    base_image = "docker-image://ubuntu:22.04"
  }
  args = {
    PORT            = 22900
    DOWNLOAD_TARGET = ""
  }
  output = ["type=registry"]
}

target "nzyme_tap_v2a9" {
  inherits = ["_nzyme_tap"]
  args = {
    DOWNLOAD_TARGET = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.9/nzyme-tap_2.0.0-alpha.9_ubuntu2204_amd64.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:v2a9",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:latest"
  ]
}

target "nzyme_tap_v2a10" {
  inherits = ["_nzyme_tap"]
  args = {
    DOWNLOAD_TARGET = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.10/nzyme-tap_2.0.0-alpha.10_ubuntu2204_amd64.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:v2a10",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:latest"
  ]
}

target "nzyme_tap_v2a12" {
  inherits = ["_nzyme_tap"]
  args = {
    DOWNLOAD_TARGET = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.12/nzyme-tap_2.0.0-alpha.12_ubuntu2204_amd64.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:v2a12",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:latest"
  ]
}

target "nzyme_tap_v2a13" {
  inherits = ["_nzyme_tap"]
  args = {
    DOWNLOAD_TARGET = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.13/nzyme-tap_2.0.0-alpha.13_rpios11_arm64.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:v2a13",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:latest"
  ]
}

target "nzyme_tap_v2a17" {
  inherits = ["_nzyme_tap"]
  args = {
    DOWNLOAD_TARGET = "https://github.com/nzymedefense/nzyme/releases/download/2.0.0-alpha.17/nzyme-tap_rpios-12bookworm-arm64-2.0.0-alpha.17.deb"
  }
  tags = [
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:v2a17",
    "${IMAGE_REGISTRY_PREFIX}/${NZYME_TAP_DOCKER_IMAGE_NAME}:latest"
  ]
}

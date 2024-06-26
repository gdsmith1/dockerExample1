# HCL config equal to running "docker buildx bake --file docker-compose.yml --set '*.platform=linux/amd64,linux/arm64' --no-cache --push"

# Sets the default platforms to build for in a variable
variable "releaseplatforms" {
  default = ["linux/amd64", "linux/arm64"]
}

# Overarching group
group "default" {
  targets = ["runner", "nexus"]
}

# Defines the runner target build
target "runner" {
  context = "./runner"
  dockerfile = "./Dockerfile"
  tags = ["gdsmith1/runner:latest"]
  platforms = releaseplatforms
  no-cache = true
  push = true
}

# Defines the nexus target build
target "nexus" {
  context = "./nexus"
  dockerfile = "./Dockerfile"
  tags = ["gdsmith1/nexus:latest"]
  platforms = releaseplatforms
  no-cache = true
  push = true
  args = { # This is the equivalent of making a volume in a docker-compose file
    NEXUS_DATA = "/sonatype-work/nexus3"
  }
}
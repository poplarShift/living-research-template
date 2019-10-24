#!/bin/bash
doc="# An environment_versions.yml file that contains exact version numbers of what is currently installed. We take the pip installs from the original environment file, though, as conda env export does apparently not keep track of the specific source (e.g. commit version) of pip wheel installs. Due to differences in software availability across operating systems, we will have to resort to building Docker images from the manually built environment.yml file to ensure reproducibility. That being said, this file is only to keep track of what is installed locally, which may help tracking down differences between the Docker image and a local environment."

echo $doc > environment_versions.yml
conda env export --no-builds | sed '/- pip:/,$d' >> environment_versions.yml
cat binder/environment.yml | sed -n '/- pip:/,$p' | grep -v '^#' >> environment_versions.yml

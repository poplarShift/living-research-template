#!/bin/bash
image_name_base='living-research'

if [[ $# -eq 0 || $1 == "env" ]]; then
  mount_dir_flag='-v '`pwd`:/home/$image_name_base
elif [[ $1 == "full" ]]; then
  mount_dir_flag=''
fi

if [[ $# -gt 1 ]]; then
  image_name=$2
else
  image_name=$image_name_base':latest'
fi

docker run -it -p 8888:8888  ${mount_dir_flag} ${image_name} /srv/conda/envs/notebook/bin/jupyter-lab --ip=0.0.0.0 --port=8888 --no-browser

#!/bin/bash
image_name_base='living-research'

if [[ $# -eq 0 || $1 == "env" ]]; then
  docker run -it -p 8888:8888 -v $(pwd):/home/$USER ${image_name_base} /srv/conda/envs/notebook/bin/jupyter-lab --ip=0.0.0.0 --port=8888 --no-browser
elif [[ $1 == "full" ]]; then
  docker run -it -p 8888:8888 ${image_name_base}-full /srv/conda/envs/notebook/bin/jupyter-lab --ip=0.0.0.0 --port=8888 --no-browser
else
  echo "Usage: One positional argument out of {'env' (default) or 'full'}"
fi

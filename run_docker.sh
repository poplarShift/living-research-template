#!/bin/bash
if [[ $# -eq 0 || $1 == "env" ]]; then
  docker run -it -p 8888:8888 -v $(pwd):/home/$USER living-research-env /srv/conda/envs/notebook/bin/jupyter-lab --ip=0.0.0.0 --port=8888 --no-browser
elif [[ $1 == "full" ]]; then
  docker run -it -p 8888:8888 living-research-full /srv/conda/envs/notebook/bin/jupyter-lab --ip=0.0.0.0 --port=8888 --no-browser
else
  echo "Usage: One positional argument out of {'env' (default) or 'full'}"
fi

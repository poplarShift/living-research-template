#!/bin/bash
image_name='living-research'

# clone git archive to make sure we only get files into the docker
# that are tracked as part of the repository
tmpdir=_tmp_repo2docker
git clone . $tmpdir
gittag=`git branch --show-current`-`git describe`

if [[ $# -eq 0 || $1 == "env" ]]; then
  # This creates a Docker image based only on the environment instructions
  tag=${gittag}-env
  tmpdir_envfile=_tmp

  # rm -rf $tmpdir $tmpdir_envfile
  mkdir $tmpdir_envfile
  cp $tmpdir/binder/* $tmpdir_envfile/

  cd $tmpdir_envfile
  repo2docker --no-run --image-name=$image_name --user-name=$image_name .
  cd
  rm -rf $tmpdir $tmpdir_envfile

  docker tag $image_name:latest thanksforthefish/$image_name:$tag
  docker tag $image_name:latest thanksforthefish/$image_name:latest-env

elif [[ $1 == "full" ]]; then
  # This includes the entire repository (data, ...)

  tag=${gittag}-full

  ### --- enter archive and create docker image

  # ### export bibliography
  # cd paper
  # export file='paper'
  # export bib='bibliography.bib'
  # export bib_full='bibliographyfull.bib'
  #
  # cd ..

  cd $tmpdir
  repo2docker --no-run --image-name=$image_name .
  cd ..

  rm -rf $tmpdir

  docker tag $image_name:latest thaksforthefish/$image_name:$tag
  docker tag $image_name:latest thaksforthefish/$image_name:latest-full

else
  echo "Usage: One positional argument out of {'env' (default) or 'full'}. Second argument 'push' is optional"
fi

if [[ $2 == "push" ]]; then
  docker push thanksforthefish/${image_name}:${tag}
fi

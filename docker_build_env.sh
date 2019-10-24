#!/bin/bash

source activate nitrateflux

image_name=living-research-env

tmpdir=_tmp_repo2docker
tmpdir_envfile=_tmp

rm -rf $tmpdir $tmpdir_envfile
git clone . $tmpdir
mkdir $tmpdir_envfile
cp $tmpdir/binder/* $tmpdir_envfile/

pushd $tmpdir_envfile
repo2docker --no-run --image-name=$image_name --user-name=$USER .
popd
rm -rf $tmpdir $tmpdir_envfile

source deactivate

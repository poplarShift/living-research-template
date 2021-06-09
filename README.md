[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/poplarShift/living-research-template/master)

# What is "living research"?

Imagine you want to write a scientific article and you want _every_ _single_ _step_, from the data the published journal article, to be:
1. reproducible,
2. reusable, and
3. scalable.

Instead of getting stowed away in a printed journal or in a static pdf, you'd then want your research to be accessible for further modification and critique, either by future you, colleagues, or anyone else, really. This is what I'd call "living research". What's more, you're in luck, because there is a plethora of open-source tools available these days! This repository contains a template for what such a workflow could look like.

This template makes use of python-centered tools. However, none of them strictly require that you code in python and the few custom python scripts that I wrote to handle the workflow could even be replaced by something in your favorite language. The barebones of the workflow are conda for package management, git for versioning, and pandoc for handling documents (and in the future hopefully smoother integration with docker or other containerization software).

# In this document

1. Features
1. Contents of the repository
1. Usage
1. License
1. Wishlist / further work

# Features:

- Fully automated and reproducible

    - operate Everything™️ from simple scripts

    - share complete work environment with colleagues and interested outsiders, using Docker and `repo2docker`

    - enable anyone on the internet to interactively try out your entire workflow, using [mybinder](mybinder.org). (Click on the binder badge at the top of this document!)

- Article/scientific paper output:

    - Bibliography support, using `bibtex`. Even share your bibliography using `bibexport`!
    - Produce different versions of the same article for different audiences, using preprocessors:
        - Static (e.g. for a traditional print journal), using pandoc `cls` templates
        - Interactive (html) versions, using browser-facing plotting libraries such as `Bokeh`
    - Can be formatted to any format you'd like, using pandoc
    - Track and markup changes for the peer review process from one revision to another, using markdown-diff
    - Import figures and cross-reference them in the text, using `pandoc-crossref`
    - In principle, one could write such an article inside a Jupyter notebook. In practice, this becomes cumbersome as the complexity of the project grows. You wouldn't want to bother most of your readers with side stories, supporting material, standard data carpentry code, etc. Hence this is one in a separate markdown file.

- Keep your computation, visualization, and interpretation in one place, using Jupyter notebooks

    - Whatever programming language you like (Python, Julia, R, ...) as long as [there's a kernel for it](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels).
    - Annotate code directly with figures and explaining material
    - Direct output of supplementary material using nbconvert

- Everything is versioned, using git
    - Build on, modify, and discuss others' work
    - Traceable, attributable, and reversible tree of changes


# Usage

There are many ways to explore this template!

## I just want to take a quick look around and not install anything

The easiest way is probably to [follow this link](mybinder-link) or click on the "Binder" badge in the top of this document. This will launch an interactive environment in the cloud (thanks to binderhub) where you can run, modify, and re-run all the code.

## Just give me a docker image to run

If you would like to not download anything but explore the study on your own terms, use the pre-compiled Docker image (which includes this entire repository, built using `./build_docker.sh full`):

> `docker run ...`

## I want to use this as a template for my own research!

For a local copy, you can create one by cloning this repository using:
> `git clone https://github.com/poplarShift/living-research-template.git .`

You will want to change the environment and docker image names, specified for various purposes in `binder/environment.yml`

### How do I write my paper in here?

Go to `paper/paper.md` to find the template for the "paper" (i.e. what you would submit to a journal, put on your website, send to your boss, ...).

`paper.md` is then compiled using `compile_paper.sh`.

The file `nb/analysis` has a template for an analysis notebook. The script `compile_notebooks.sh` takes care of running them, converting them to `html` format, and then clearing all outputs (for version control). As your project grows, you may want to stop versioning the resulting html files.

### So how do I set up the computing environment?

  1. Run the pre-compiled docker image that contains only the computing environment and link this directory to the home folder of the container, provided you have installed (and started) [Docker](https://www.docker.com):
  ```
  $ ./run_docker.sh
  ```
  which gives you access to the entire computing environment with all the dependencies, or

  2. Build the same docker image yourself:
  ```
  $ ./docker_build.sh env
  ```
  for an image with only the software specified in the environment.yml file, or
  ```
    $ ./docker_build.sh full
  ```
  for an image including the entire repository,
  and then run it (see above), or

  3. [Create a local conda environment](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) on your machine containing all necessary dependencies using
  ```
  $ conda env create -f environment.yml
  ```
  If every you find yourself hunting down version differences between the docker images and what is installed locally on your system, you may find the script `binder/export_versions.sh` useful. These versions may differ depending on the conda channel and your operating system.

# License

I've put all of this under GNU-GPL. If you're interested but you'd need another license, feel free to contact me.

# Wishlist / to do

- Allow specification of env name and other environment variables through a setup makefile
- `intake` to handle remote and local data
- Makefile with automatic detection of what's changed
- Automated caching of computation output, e.g. using intake/panel+param and intermediary files
- Automated selective inclusion of source code of custom functions into the repository
- Continuous integration / automated builds with docker
- Docker repo for pre-built images

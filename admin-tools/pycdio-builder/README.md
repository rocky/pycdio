# pycdio-builder

This directory contains tools for building a Docker image that can be used for
building `manylinux2014_x86_64` compliant `pycdio` wheels (as specified by PEP
599).

## Usage

First, build the container. Issue this command in the directory with the
`Dockerfile`:

```txt
docker build --tag pycdio-builder .
```

Tag the image with whatever name you like, `pycdio-builder` is just an example.
Docker engine will pull the PyPA `manylinux2014_x86_64` Docker image, install
all required dependencies (`swig` and `libcdio`, the latter from source), and
copy wheel building script and a configuration file for `pip`.

Once the image is ready, change to the repository root, check out the revision
you want to build wheels for, and start the container, e.g.:

```txt
git checkout 2.1.1
docker run --rm -u 1000:100 -v "$(pwd):/package" pycdio-builder
```

The `-u` parameter is optional, but is recommended to avoid creating files
owned by root user in your repository clone. Substitute the parameters to `-u`
with your actual user and group IDs. Mounting package sources in `/package`
directory inside the container with `-v` option is mandatory. Wheel building
script won't start unless it's available.

The script will iterate through all Python interpreters provided in the
container image, and create `manylinux2014_x86_64` wheels for each of them.
If all goes well, the results will be stored in the `wheelhouse` directory
in the repository root.

# Building OpSim docker images

The overall order of operations is to build the lsst `stack` image,
and then use that as a base image to make a `OpSim` iamge.

These instructions will assume you have clone this repository and it
is your current working directory.

### Building the `stack` image with newinstall.

The newinstall `stack` images can be built from the `build_stack.sh` script
found in the `build_scripts` directory in this repo. Without any
command line options this script will build an image with the `name:tag`,
`opsim4_fbs_py3:stackpy3-YYYYMMDD`. The date information will automatically be filled in by script.
So if today is October, 4th 2018, running this script will produce a Docker image
called `opsim4_fbs_py3:stackpy3-20181004`

To build the `stack` image run the following command:

~~~
build_scripts/buil_stack.sh
~~~

When it is finished note the name and tag of the image because it is needed
for the `OpSim` image.

### Building the `stack` image with lsstsw

The lsstsw `stack` images can be built from the `build_stacksw.sh` script
found in the `build_scripts` directory in this repo. Without any
command line options this script will build an image with the `name:tag`,
`opsim4_fbs_py3:stackswpy3-YYYYMMDD`. The date information will automatically be filled in by script.
So if today is October, 4th 2018, running this script will produce a Docker image
called `opsim4_fbs_py3:stackswpy3-20181004`

To build the `stack` image run the following command:

~~~
build_scripts/buil_stacksw.sh
~~~

### Building the `OpSim` image.

After the `stack` image has finished building, open the `opsim` Docker file found
in `docker/opsim`. You will need to edit the first line of this Docker file to
match the `stack` image you created in the previous step. Again, assuming today
is October, 4th 2018, the first line of this Docker file will need to be

~~~
FROM opsim4_fbs_py3:stack-20181004
~~~

In the `docker/opsim4` directory you will also want to make sure you have the
`libsacpp_scheduler_types.so` and `SALPY_scheduler.so` libraries in the
`docker/opsim4/dds_libs` folder.

See [https://github.com/oboberg/sal_build](https://github.com/oboberg/sal_build)
for a repo showing how to build the topics with Docker.

You also need to go to `docker/opsim4/smallSky/data` directory and run the `data_down.sh`
script to pull at least the 3 day and 30 day sky brightness files.

Finally you will want to look at the Docker file and make sure all of the repository
branches are set to what you would like to be the defaults built into the opsim
Docker image.

Once you have gathered everything and edited the Docker file you are ready to run
the `build_opsim.sh` script.

~~~
build_scripts/build_opsim.sh
~~~

Without any command line options this script will build an image with the `name:tag`,`opsim4_fbs_py3:YYYYMMDD`. So in the case of our date example this would be
`opsim4_fbs_py3:20181004`.

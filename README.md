# Purpose

This docker container was build on purpose to test out the setup of nginx and the configuration of php-fpm. There certainly are similar images available, but this is for testing and customization.

# Details

I have collected a few points that might be of interest.

## Docker

Building a docker container from a base OS image requires the installation of packages. Without customization, one ends up downloading the same packages over and over again. Ideally, one could use a local network drive during installation.

* in `apt.conf.d` the file `docker-clean` needs to be removed/disabled. In that place comes `keep-packages`, which instructs *apt* to keep downloaded packages.
* in `Dockerfile` we have to instruct the *RUN* command to cache 2 directories:
~~~DOCKERFILE
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt \
  apt update && ...
~~~

The cache is only accessible during the docker image build process. The started container might have empty directories.


## PHP-FPM

That installation follows the norm with a few adjustment for error logging.

## Xdebug

Xdebug is configured to be remotely triggered, here by the *ide-key* "vsc". I have an extension in Firefox that allows me to do that. Remember, it is the php-server that contacts the IDE, which in my case is *Visual Studio Code*, where the xdebug-client waits for the connection.

## Visual Studio Code

I am using both "PHP Debug" by FelixFBecker and "phpfmt" by kokororin. The first contains the xdebug-client which needs to be configured and started. 

"Unconfirmed breakpoints" is a sign that the server could not establish breakpoints in the right location. This is an indication that the local path could not be mapped to a remote counterpart. If so, add the correct mapping. Here, I have an nfs-mount of my Xen-machine and debug a script on that server. 
~~~Javascript
"pathMappings": {
    "/live/public": "/net/xen/lvms/nas/docker/ftest/live/public"
    }
~~~

## Networking

I am using the setup (described in my blog), where each docker container appears as a host on the network.

## PHP-FPM pool config and error log

The `error_log` function fulfills my old-style debugging technique for PHP. I can follow the control flow in hindsight like in traditional log-files.

**Chroot** is possible in the configuration of an PHP-FPM pool. This will change the root directory after a worker process has been spawned. All files opened after that need to relate to that path. That is also valid for the error log files. In my case, it failed. Hence, the provided configuration has no active chroot.

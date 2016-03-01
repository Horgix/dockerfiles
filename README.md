This repository contains Dockerfiles, mainly for my own convenience; so don't
be surprised if you often find custom configurations that would not fit someone
else needs/habits.

You'll find 2 directories at the root of this repo :

- arch: contains Dockerfiles based on the base/archlinux image
- debian: contains Dockerfiles based on the official debian image

Mainly the Arch Linux based images will be used/updated since there are the
ones I use the most frequently.

# Availaboe Dockerfiles

At the time of writing, the following Dockerfiles are available :

## Arch Linux based

- ssh: my own configs
    - ssh-uptodate: parent image with updates, allow faster rebuilding
- gitit
- haskell: haskell dev tools
- makepkg: Arch Linux package building tools
- md: pandoc
- pandoc-dev
- py3status: py3status (https://github.com/ultrabug/py3status) development
- weechat

## Debian based

- ssh
- ssh-uptodate
- pandoc

# To infinity and beyond

After taking a look at my images, I noticed that base/archlinux is really
heavier than what I initially thought : is takes 280 MB (thanks
[imagelayers.io](https://imagelayers.io/) for the helpful tool).

Considering this, I'm planning to move some things to a lighter base image,
maybe [alpine](https://hub.docker.com/_/alpine/), we'll see.

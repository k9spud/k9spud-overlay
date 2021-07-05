# k9spud-overlay
A Gentoo overlay for Raspberry Pi 4 software.

NOTE: There is nothing actually here in this overlay yet. This is a Work In Progress.

This project builds upon the work of Gentoo and the GenPi64 project.

How to Use
==========
To add the k9spud-overlay to your system, do the following as root:

```console
# cd /var/db/repos
# git clone https://www.github.com/k9spud/k9spud-overlay.git k9spud
# nano -w /etc/portage/repos.conf/k9spud-overlay.conf
```

Insert the following text into the k9spud-overlay.conf file:

```console
[k9spud]

location = /var/db/repos/k9spud
sync-type = git
sync-uri = https://www.github.com/k9spud/k9spud-overlay.git
priority = 200
auto-sync = yes
clone-depth = 1
sync-depth = 1
sync-gitclone-extra-opts = --single-branch --branch main
```

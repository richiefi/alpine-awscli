alpine-awscli
=============

This is a minimalist [Alpine](http://www.alpinelinux.org/)-based Docker image that includes `/usr/bin/aws`, a PyInstaller-packaged binary copy of aws-cli. That single file is the only difference to a stock alpine image.

The [PyInstaller](http://pyinstaller.readthedocs.io/) Dockerfile is mostly from [pyinstaller-alpine](https://github.com/six8/pyinstaller-alpine). 

As of this writing, the component versions used for this image are:

| Component   | Version  |
|-------------|----------|
| aws-cli     | 1.11.178 |
| Alpine      | 3.6      |
| Python      | 3.6.3    |
| PyInstaller | 3.3      |

The resulting image is about 23MB in size.

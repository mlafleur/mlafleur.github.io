---
title: Ruby & Ubuntu on Windows 10
subtitle: Installing Ruby 2.2.5 into Ubuntu running on Windows 10 and Windows Subsystem for Linux
tags:
  - Windows Subsystem for Linux
  - WSL
  - Ruby
  - Ubuntu
  - Windows 10
  - Bash
categories:
  - WSL
  - Ruby
  - Linux
---

_We recently published Ubuntu to the [Windows Store](https://www.microsoft.com/store/apps/9NBLGGH4MSV6). With the switch from beta to GA, I found myself with a beautifully pristine Ubuntu environment to rebuild. I decided to take advantage of this oportunity and document some of the configuration challenges I faced. I worked around these issues in the beta as well but it happened in drips and drabs making it hard to coherently document._

This post covers getting [Ruby][] 2.2.5 installed and running. I don't do much with Ruby but my blog is built on top of a Ruby package called Jekyll. While most of the heavy lifting is done behind the scenes on GitHub using GitHub pages, I find it extremely helpful to have a local copy. And since [Jekyll][] is notoriously tricky to get up and running on Windows, the Windows Subsystem for Linux is a really elegant solution.

> If you're not already using Ubuntu from the Store, I highly recommend reading Scott Hanselman's [Ubuntu now in the Windows Store: Updates to Linux on Windows 10 and Important Tips](https://www.hanselman.com/blog/UbuntuNow%C4%B0nTheWindowsStoreUpdatesToLinuxOnWindows10AndImportantTips.aspx).

## Default Package Repo

Ruby is included in Ubuntu's default package list but it will install Ruby v1.9.3 which is an outdated version and not supported by GitHub Pages and Jekyll. This isn't an uncommon issue with a distro package repositories so you often find yourself pulling packages direction from the vendor. Ruby however turned out to be a bit trickier to sort out for a lowly Windows Dev like myself. ;)

## Getting Started

We're going to be installing several packages here using `apt`. Before doing that, it is always a good idea to refresh your package index:

```bash
sudo apt-get update
```

Before we can install Ruby 2.2.5, we need to first install some dependencies. Executing the following command line will get that ball rolling:

```bash
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

## Installing rvm

After some poking around, I decided on using the Ruby Version Manager (`rvm`) to install Ruby. There are [several](https://github.com/rbenv/rbenv) [others](https://www.ruby-lang.org/en/documentation/installation) out there but I found most of the `rvm` commands easier to comprehend.

We'll install `rvm` using the following commands:

```bash
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
```

## Installing Ruby 2.2.5

Now what we have all of the prerequisites installed, we can install the actual Ruby package. While some of the previous commands were a bit opaque to me, it is this last bit that I found attractive about `rvm`. This portion is extremely straight forward:

```bash
rvm install 2.2.5
rvm use 2.2.5 --default
```

> Note that this _does_ take a while to download, configure, and compile. It isn't as simple as installing some small binaries.

One aspect about this that I like is how easily I can switch versions. If I decide I would rather use Ruby 2.5.0 then I can simply install it and switch to that as my default:

```bash
rvm install 2.5.0
rvm use 2.5.0 --default
```

One this was done, I was able to get Jekyll installed using `gem install jekyll bundler`

Below is the complete command list as a Gist

{% gist e1d1e5a9cdb9f9eff26e03c614f1dd6f %}

[ruby]: https://www.ruby-lang.org
[jekyll]: http://jekyllrb.com/

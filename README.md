Hostesse
========

Templatable hosts manager
-------------------------

Define multiple hosts files for your machine using a templating engine and easily switch between them.

Installation
------------

### RubyGem (recommended)

Install the gem:

```bash
$ gem install hostesse
```

Create a directory for the hosts definitions:

```bash
$ mkdir hosts
```

### Java

Since 0.0.7 hostesse has support for JRuby. Get the latest version [here](https://www.dropbox.com/sh/8p6cbbcaoyv23u7/4HdIrrxVuQ/hostesse-java).

To execute, run `java -jar hostesse-x.x.x.jar`, where `x.x.x` is the version.

[warbler](https://github.com/jruby/warbler) is used to package it as a jar. If you want to pack it yourself, run `warble` from the base directory of the project.

Usage
-----

In the directory created in previous step, create hosts definition files ending with `.hosts`:

```
hosts
├── production.hosts
├── qa.hosts
└── staging.hosts
```

Start `hostesse` in that directory:

```bash
$ hostesse [target-file]
```

`target-file` is a optional parameter. If passed, it will be used as the target hosts file. The defaults are `/etc/hosts` for UNIX based operating systems and `C:/windows/system32/drivers/etc/hosts` for Windows.

The command line should help you from this moment on.

Templating
----------

In hosts definition files you can use `{ another-hosts-definition }` and hostess will include it in place:

```
# hosts-definition
127.0.0.1 someproject
```

```
# another-hosts-definition

{ hosts-definition }

127.0.0.1 someotherproject
```

will result in:


```
# hosts-definition
127.0.0.1 someproject
```

```
# another-hosts-definition

# hosts-definition
127.0.0.1 someproject

127.0.0.1 someotherproject
```

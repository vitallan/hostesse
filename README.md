Hostesse
========

Templatable hosts manager
-------------------------

Define multiple hosts files for your machine using a templating engine and easily switch between them.

Installation
------------

Install the gem:

```bash
$ gem install hostesse
```

Create a directory for the hosts definitions:

```bash
$ mkdir hosts
```

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
$ hostesse
```

The command line should help you from that.

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

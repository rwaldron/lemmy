## LEMMY: 49% Motherfucker | 51% Son of a Bitch JS/CS Express+Mocha project Boilerplate

No better yet humble hommage to the Godfather of Heavy Metal, __[Lemmy Kilmister][0]__. 
Perhaps you may have heard of him as the trust-worthy roadie of *[Jimi
Hendrix][1]*, the raw base of the 70's space rock powerhouse *[Hawkwind][2]* or, most 
probably, as the relentless force behind the all-mighty *[Motörhead][3]*.

As the remarkable individual, living legend and true rock-star; this
tool aims at emulating all the characteristics that make of __Lemmy__ a
one-of-a-kind person: *simple*, *straight-forward*, *generous*, *smart*, and *practical*.

Designed from scratch to kick-start your *[Express][4]* application in 
either *Javascript* or *[Coffee-Script][5]* in no time and agilize the 
management of the most common tasks during the development, testing, and
deployment of your project by just using Makefile and a couple of Bash commands
available on your OSX system.

### Pre-Requisites

You're required to use a BSD-like system that support Makefiles, uses
[Bash shell][6], have [Git source code management system][7] and [Node.JS][8] installed 
on your machine. That's all you need!

### How to Use

It is very easy to use __Lemmy__. In fact, all you need to do is the
following:

* Fork this project and rename it as you like.

```shell
  git clone https://github.com/rock-n-code/lemmy your_project_name
```

* Setup your project and choose your language of choice

```shell
  cd your_project_name && make setup [APP_LANGUAGE=CS]
```

* Modify the *package.json* file to your requirements with your Text
  Editor of choice.

* Install all the dependencies locally.

```shell
  make dependencies
```

### Available Commands

The commands __Lemmy__ provides you are:

* *setup* : Kick-start your JS/CS Express project for once and for all.
* *dependencies* : Install locally all the dependencies defined on the package JSON file.
* *clean* : Clean-up all the generated code from your Express project.
* *build* : Compiles your CS code into the JS equivalent.
* *watch* : Watches any change on your CS code and automatically compiles it into its JS equivalent.
* *run* : Run your project on Node.JS
* *test* : Test your Express project using Mocha.
* *deploy* : Prepares your Express project for deployment.
* *mit-license* : Generate a MIT license for your Express project.
* *help* : Display the Help menu you're reading right now.

### ToDos

This is the list of all the features are required or would be awesome to
implement on __Lemmy__ in the near future, in random order:

* [HTML5 boilerplate][10] integration on the View's layout.

### Contributors

The following people are helping to make of __Lemmy__ an essential tool
for every [Express][4] developer:

* [Javier Cicchelli][11]

No matter how small or big your contribution to this project, you'll be
added to this list by default.

![Lemmy Kilmister][9]

### MIT License

Copyright (c) 2011-2012 __Javier Cicchelli__ (javier@rock-n-code.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this 
software and associated documentation files (the 'Software'), to deal in the Software 
without restriction, including without limitation the rights to use, copy, modify, 
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject to the following 
conditions:

The above copyright notice and this permission notice shall be included in all copies 
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
OTHER DEALINGS IN THE SOFTWARE. 

[0]: http://en.wikipedia.org/wiki/Lemmy
[1]: http://www.jimihendrix.com
[2]: http://www.hawkwind.com/
[3]: http://www.imotorhead.com
[4]: http://expressjs.com
[5]: http://coffeescript.org
[6]: http://www.gnu.org/software/bash
[7]: http://git-scm.com
[8]: http://nodejs.org
[9]: http://30daysout.files.wordpress.com/2010/12/lemmypublicity1robertjohn_20101130_123211.jpg
[10]: https://github.com/h5bp/html5-boilerplate
[11]: https://github.com/mr-rock


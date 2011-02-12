# Macchiato #

Macchiato is a toolkit for building complex software in JavaScript. It is
designed for use both in the web browser as well as on the server, and just so
happens to be written in [CoffeeScript][homepage-coffeescript].

## Building the Macchiato Library ##

If you have Node.js and CoffeeScript installed, chances are you have Cake - the
CoffeeScript build tool. If so, you should be able to run:

	# Change into the base Macchiato project directory
	cd /somewhere/on/your/disk/Macchiato
	# Use the Cake utility to build the project
	cake build

Cake should display some text on the screen that looks something like:

	Macchiato - The CoffeeScript toolkit.
	Building the complete Macchiato library...
	Done.

The finished library file will be inside of the Macchiato/JavaScript directory,
and should be named "Macchiato.js".

## License ##

Macchiato is, and always will be, free and open source software, both for fun
and for profit.

All files in this repository are released under the terms specified in the file
[LICENSE][repo-license]. For more information, please see the the Wikipedia
article on the MIT License by clicking [here][wikipedia-mit-license].

## Contributing ##

Macchiato needs your help! If you want to be a contributer, of anything, you
are more then welcome to do so. The project guidelines for contributors can be
found in the official project Wiki [here][wiki-guidelines].

## Comments from the Developer(s) ##

> "Macchiato is a personal labor of love. Anything that I have ever found myself
> writing over, and over, and over again will eventually make it into this
> library. The code that gets checked-in here is indispensable to almost every
> significant new JavaScript project that I work on, and hopefully others find
> it as useful as I have found it to be." - [sheatrevor][github-sheatrevor]

If you have any comments that you would like to add, please feel free to do so
by creating your own paragraph and tagging it at the end with your username and
a URL of your choice.

[homepage-coffeescript]: http://jashkenas.github.com/coffee-script/ "CoffeeScript's Homepage"
[repo-license]: ./Macchiato/blob/master/LICENSE "View the file LICENSE in the Macchiato project repository"
[wikipedia-mit-license]: http://en.wikipedia.org/wiki/MIT_License "Wikipedia article for the MIT License"
[wiki-guidelines]: ./Macchiato/wiki/Guidelines-for-Contributors "Macchiato Wiki - Guidelines for Contributors"
[github-sheatrevor]: http://github.com/sheatrevor/ "Shea Trevor's profile on GitHub"

# fb-framework
A framework to develop apps, for FreeBasic 1.07.1+

Currently a WIP, but the public interface is mostly stable by now.

Included so far are:

* A templating framework
* A small set of templatable collections
* An events framework to create classes that can raise and respond to events, VB.NET style
* A Xml framework to deserialize Xml files

To be added:

* A Xml writer (complements the Xml framework)
* A tasks framework to lay out concurrent tasks
* A graphics framework to abstract several graphics backends (SDL2, SFML, FBGFX, Cairo, etc.)
* A math framework
* A windowing framework
* A JSON framework to serialize/deserialize JSON
* Many more

## Install instructions
Just copy/merge the contents of the `/inc` folder into the one of your own FreeBasic installation. The `/examples` folder contains some examples on how to use the different frameworks.

## Usage notes
I'm working heavily on this ATM so it is to be considered 'WIP'. The templating, the collections and the event frameworks are unlikely to change, but I'm working heavily on some of the others (ie they're not yet stable enough to be pushed here or are just barebones).

## Examples
I'll add many more examples as soon as I have a little spare time. The ones included show some of the more basic features and should be enough to get someone started.

## Documentation
WIP, of course.

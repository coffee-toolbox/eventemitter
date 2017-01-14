# eventemitter

EventEmitter in Coffeescript.

EventEmitter is a node.js EventEmitter-like library for browser.

### NOTE
Do NOT download from npm!

Just add the dependency that use https git repo url as a version.

    "@coffee-toolbox/eventemitter": "https://github.com/coffee-toolbox/eventemitter.git"

npm is evil that it limit the publish of more than one project.
And its restriction on version number is terrible for fast development that
require local reference. (npm link sucks!)
[why npm link sucks](https://github.com/webpack/webpack/issues/554)

It ruined my productivity for a whole three days!

For any one who values his life, please be away from npm.

----

## API

### Require:

```coffeescript
    {EventEmitter} = require '@coffee-toolbox/eventemitter'
```

### Create new EventEmitter:

```coffeescript
    ee = new EventEmitter()
    # or
    class MyClass extends EventEmitter
        constructor: ->
            super
            # ...
```

### Listen constantly on an event.

Registering and unregistering.

```coffeescript
    listener = (args...)->
        # do something when 'eventname' happend with args

    ee.on 'eventname', listener

    ee.off 'eventname', listener

    ee.offAll 'eventname'
```

The `listener` is called synchronously when `eventname` is emitted.

If more than one listener is added, they would be called synchronously in the
order as they were registered.

### Listen limited times on an event.

The listener is automatically removed when called given times.

```coffeescript
    listener = (args...)->
        # do something when 'eventname' happend with args

    ee.once 'eventname', listener

    ee.many 'eventname', times, listener
```

### Emit an event:

```coffeescript
    listener = (args...)->
        # do something when 'eventname' happend with args

    ee.emit 'eventname', args...
```

The `args...` are forwarded to the `listener`. All listener of the event are
called in the order as they were registered.

----

## Why another EventEmitter?

I'm using EventEmitter2 on my project until one day I need some internal info
to debug. I found its code is *optimized* for no human being. And I found
EventEmitter3, 4, 5 and saw their 'why anonther'. Then I was confused. Why
complicate such a simple problem by importing codes that you weren't read and
trust? So this version is not a re-invented wheel but a remade wheel for
myself, only implementing APIs that I need.

I believe it is also useful for most people. And its simplicity made it easy to
read and to be trusted.

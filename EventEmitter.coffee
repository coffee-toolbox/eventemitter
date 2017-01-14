'use strict'
WeakMap = require('es6-weak-map')

class EventEmitter
	constructor: ->
		@_events = {}
		@_transient_events_map = new WeakMap()
		Object.defineProperty this, '_events',
			enumerable: false,
			writable: true
		Object.defineProperty this, '_transient_events_map',
			enumerable: false,
			writable: true

	on: (event, listener)->
		@_events[event] ?= []
		@_events[event].push listener
		this

	off: (event, listener)->
		l = @_transient_events_map.get listener
		if l?
			@_events[event] = @_events[event].filter (e)->
				e isnt l
		@_events[event] = @_events[event].filter (e)->
			e isnt listener
		this

	offAll: (event)->
		@_events[event] = []
		this

	once: (event, listener)->
		@many event, 1, listener

	many: (event, n, listener)->
		@_events[event] ?= []
		k = (v...)=>
			n -= 1
			if n is 0
				@_events[event] = @_events[event].filter (e)->
					e isnt k
			listener v...
		@_transient_events_map.set listener, k
		@_events[event].push k
		this

	emit: (event, v...)->
		console.assert event?, 'event can\'t be null/undefined'
		@_events[event] ?= []
		for f in @_events[event]
			do (f)->
				f v...

module.exports =
	EventEmitter: EventEmitter

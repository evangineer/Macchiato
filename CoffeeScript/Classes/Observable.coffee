# This file defines the Observable class, and exposes it to the outside world.
#
# Observable is an implementation of the observer pattern, which is a
# simplified subset of the publish/subscribe or pub/sub pattern. Observable
# notification messages are sent to all of the observer functions in the
# observers collection.
class Observable

	# Creates the class variable to store the observers.
	constructor: ->
		# Create a place for the observer functions to go
		@observers = []

	# Adds a single Observer function to the list of observers.
	#
	# param   function  observer  A reference to the observer function to add.
	# return  object              A reference to this class instance.
	addObserver: (observer) ->
		# Add the observer function to the universal channel
		@observers.push observer
		# Return a reference to this class instance
		return @

	# Simple alias for addObserver.
	subscribe: (observer) ->
		# Return the result of the addObserver method, passing the same
		# argument value
		return @addObserver observer

	# Issues an event to all of the observer functions in the observers
	# collection on this class instance.
	#
	# param   mixed   message  optional  The message that we want to notify all
	#                                    of the observers with.
	# return  object                     A reference to this class instance.
	notifyObservers: (message = null) ->
		# Notify all of the observer functions in the observers collection
		observer message for observer in @observers if @observers.length > 0
		# Return a reference to this class instance
		return @

	# Simple alias for notifyObservers.
	publish: (message = null) ->
		# Return the result of the notifyObservers method, passing the same
		# argument value
		return @notifyObservers message

# Expose this class to the parent scope
Meta.expose 'Observable', Observable

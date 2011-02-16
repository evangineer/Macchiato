# This file defines the PublishSubscribe class, and exposes it to the outside
# world.
#
# PublishSubscribe is an implementation of the publish/subscribe or pub/sub
# pattern. This implementation supports topic-based "message filtering" by
# creating named topic channels that are each separate instances of Observable.
#
# This implementation also has a single universal topic channel which is named
# '*'. It behaves as a catch-all channel. Subscribers to the universal channel
# are notified for all notifications to all of the other named topic queues.
#
# Subscribers are expected to subscribe to either the named topic channel, or
# the universal channel. Subscribers cannot subscribe to both.
class PublishSubscribe

	# Creates the universal observable channel and initializes the class
	# variable for named topic channels. If an array of topic channels is
	# passed in, these channels are added.
	#
	# param   array  names  optional  An array of topic channel names to
	#                                 create. Defaults to an empty array.
	constructor: (names = []) ->
		# Create an instance of Observable for the universal channel
		@universalChannel = new Observable()
		# Create a place for any named topic channels to go
		@namedChannels = {}
		# Add any topic channels that were passed in
		@addChannels names if names.length > 0

	# Create a way to add a named topic channel where event messages can be
	# published.
	#
	# param   string  name  The name of the new channel to create.
	# return  object        A reference to this class instance.
	addChannel: (name) ->
		# Create the new channel
		@namedChannels[name] = new Observable()
		# Return a reference to this class instance
		return @

	# Accepts an array of strings which should each be a named topic channel
	# to be created.
	#
	# param   array  names  An array of topic channel names to create.
	# return  object        A reference to this class instance.
	addChannels: (names) ->
		# If we have topic channel names to add, add them
		@addChannel name for name in names if names.length > 0
		# Return a reference to this class instance
		return @

	# Adds an Observer to either the universal channel or a named topic
	# channel.
	#
	# param   string    name      The name of the channel to add this observer
	#                             to.
	# param   function  observer  A reference to the observer function to add.
	# return  object              A reference to this class instance.
	addObserver: (name, observer) ->
		# If a channel name was passed in
		if name isnt "*"
			# Add the observer function to the named topic channel, if a named
			# topic channel was passed in and it exists
			@namedChannels[name]?.addObserver observer
			# Return a reference to this class instance
			return @
		# Add the observer function to the universal channel
		@universalChannel.addObserver observer
		# Return a reference to this class instance
		return @

	# Simple alias for addObserver.
	subscribe: (name, observer) ->
		# Return the result of the addObserver method, passing the same
		# argument values
		return @addObserver name, observer

	# Issues an event to all of the observers on both the unnamed universal
	# channel, and, if a named topic channel is provided, the named topic
	# channel as well.
	#
	# param   string  name                         The named topic channel that
	#                                              we want to notify. If the
	#                                              name is "*", only the
	#                                              universal channel is issued
	#                                              the notification. Otherwise,
	#                                              both the named topic channel
	#                                              as well as the universal
	#                                              channel are notified.
	# param   array   observerArguments  optional  Any arguments that we want to
	#                                              forward to all of the
	#                                              observer functions. Defaults
	#                                              to an empty array if nothing
	#                                              is passed in.
	# return  object                               A reference to this class
	#                                              instance.
	notifyObservers: (name, observerArguments = []) ->
		# If a channel name was passed in
		if name isnt "*"
			# Notify the observers on the named topic channel, if the named
			# topic channel exists
			@namedChannels[name]?.notifyObservers observerArguments
		# Notify the observers on the universal channel no matter what
		@universalChannel.notifyObservers observerArguments
		# Return a reference to this class instance
		return @

	# Simple alias for notifyObservers.
	publish: (name, observerArguments = []) ->
		# Return the result of the notifyObservers method, passing the same
		# arguments
		return @notifyObservers name, observerArguments

# Expose this class to the parent scope
Meta.expose "PublishSubscribe", PublishSubscribe

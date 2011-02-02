# Define a class for a Debounced Task
class DebouncedTask extends DelayedTask

	# Takes the task function and any options then assigns them to this object
	#
	# param function taskFunction The task function itself
	# param int delay optional The amount of delay, in milliseconds
	# param object runScope optional If set, the task function runs on it
	constructor: (taskFunction) ->
		# Assign the value of the optional delay parameter to this object if it
		# is set, otherwise, default to 1 millisecond
		delay = if arguments[1]? then arguments[1] else 1
		# Grab the value of the optional runScope parameter if it is set,
		# otherwise, default to the current class scope
		runScope = if arguments[2]? then arguments[2] else @
		# Invoke the parent constructor, forwarding the arguments
		super taskFunction, delay, runScope

	# Runs the delayed task using the passed arguments, automatically resetting
	# it if needed
	#
	# param array taskArguments optional Arguments to forward to the task
	#                                    function itself
	# return object A reference to this class instance
	run: ->
		# Grab the optional taskArguments parameter if it is set, otherwise
		# default it to an empty array
		taskArguments = if arguments[0]? then arguments[0] else []
		# Automatically reset the timeout if it has already been started
		@cancel()
		# Call the parent run method
		super taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'DebouncedTask', DebouncedTask

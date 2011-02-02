# Define a class for a single Delayed Task
class DelayedTask extends Task

	# Takes the task function and any options then assigns them to this object
	#
	# param function taskFunction The task function itself
	# param int delay optional The amount of delay, in milliseconds
	# param object runScope optional If set, the task function runs on it
	constructor: (taskFunction) ->
		# Assign the value of the optional delay parameter to this object if it
		# is set, otherwise, default to 1 millisecond
		@delay = if arguments[1]? then arguments[1] else 1
		# Grab the value of the optional runScope parameter if it is set,
		# otherwise, default to the current class scope
		runScope = if arguments[2]? then arguments[2] else @
		# Invoke the parent constructor
		super taskFunction, runScope
		# Set the instance variables to their initial state
		@reset()

	# Resets the state variables on this class instance
	#
	# return object A reference to this class instance
	reset: ->
		# Reset the value of the timeout reference instance variable
		@timeoutReference = null
		# Reset the variable that tells us if we have executed the task
		@timeoutExecuted = no
		# Return a reference to this class instance
		return @

	# Cancels the execution of the delayed task, assuming that it has not
	# already been run.
	#
	# return object A reference to this class instance
	cancel: ->
		# If we have a timeout that we can cancel
		if @timeoutReference isnt null and @timeoutExecuted is no
			# Reset the timeout if we have not already executed it
			clearTimeout @timeoutReference
		# Reset the state back to its initial values
		@reset()
		# Return a reference to this class instance
		return @

	# Runs this task using the passed arguments
	#
	# param array taskArguments optional Arguments to forward to the task
	#                                    function itself
	# return object A reference to this class instance
	run: ->
		# Grab the optional taskArguments parameter if it is set, otherwise
		# default it to an empty array
		taskArguments = if arguments[0]? then arguments[0] else []
		# Store a reference to the Timeout
		@timeoutReference = setTimeout =>
			# Inform the class that this timeout function has been run
			@timeoutExecuted = yes
			# Run the task function at the desired scope
			@taskFunction.apply @runScope, taskArguments
		# Forward the desired delay to setTimeout
		, @delay
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'DelayedTask', DelayedTask

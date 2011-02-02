# Define a class to manage a single Idempotent Task
class IdempotentTask extends Task

	# Take the task that gets passed in and assign it to this object
	#
	# param function taskFunction The task function itself
	# param object runScope optional If set, the task function runs on it
	constructor: (taskFunction) ->
		# Grab the the value of the optional runScope parameter if it is set
		runScope = if arguments[1]? then arguments[1] else @
		# Call the parent constructor, forwarding the function and scope
		super taskFunction, runScope
		# Reset the run count to its initial state
		@reset()

	# Resets the run count for this task
	reset: ->
		# Reset the run count
		@runCount = 0
		# Return a reference to this class instance
		return @

	# Runs this task using the passed arguments
	#
	# param array taskArguments optional Arguments to forward to the task
	#                                    function itself
	# return object A reference to this class instance
	run: ->
		# Do nothing if we have already run once
		return if @runCount > 0
		# Increment the number of times we have run
		@runCount++
		# Grab the optional taskArguments parameter if it is set, otherwise
		# default it to an empty array
		taskArguments = if arguments[0]? then arguments[0] else []
		# Run this task using the run scope object as the function scope
		super taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'IdempotentTask', IdempotentTask

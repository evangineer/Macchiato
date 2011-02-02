# Define a class for a single Task
class Task

	# Take the task that gets passed in and assign it to this object
	#
	# param function taskFunction The task function itself
	# param object runScope optional If set, the task function runs at this
	#                                scope
	constructor: (taskFunction) ->
		# Assign the passed task function to this object
		@taskFunction = taskFunction
		# Assign the value of the optional runScope parameter to this object if
		# it is set, otherwise, default to the current class scope
		@runScope = if arguments[1]? then arguments[1] else @

	# Runs this task using the passed arguments
	#
	# param array taskArguments optional Arguments to forward to the task
	#                                    function itself
	# return object A reference to this class instance
	run: ->
		# Grab the optional taskArguments parameter if it is set, otherwise
		# default it to an empty array
		taskArguments = if arguments[0]? then arguments[0] else []
		# Run this task using the run scope object as the function scope
		@taskFunction.apply @runScope, taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'Task', Task

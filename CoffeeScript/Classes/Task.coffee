# Define a class that represents a single Task
class Task

	# Takes the task function and any options, then assigns them to this
	# object.
	#
	# param  function  taskFunction            The task function itself.
	# param  object    runScope      optional  The scope to run the task
	#                                          function at. Defaults to @.
	constructor: (taskFunction, runScope = @) ->
		# Assign the passed task function to this object
		@taskFunction = taskFunction
		# Assign the value of the optional runScope parameter to this object
		@runScope = runScope

	# Runs the task function using the passed arguments.
	#
	# param   array   taskArguments  optional  Arguments to forward to the task
	#                                          function itself.
	# return  object                           A reference to this class
	#                                          instance.
	run: (taskArguments = []) ->
		# Run this task using the run scope object as the function scope
		@taskFunction.apply @runScope, taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'Task', Task

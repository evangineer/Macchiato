# Define a class for a Debounced Task
class DebouncedTask extends DelayedTask

	# Takes the task function and any options, then assigns them to this
	# object.
	#
	# param  function  taskFunction            The task function itself.
	# param  integer   delay         optional  The amount of delay, in
	#                                          milliseconds. Defaults to 1.
	# param  object    runScope      optional  The scope to run the task
	#                                          function at. Defaults to @.
	constructor: (taskFunction, delay = 1, runScope = @) ->
		# Invoke the parent constructor, forwarding the arguments
		super taskFunction, delay, runScope

	# Runs the task function using the passed arguments, automatically
	# resetting the previous timeout if there is one.
	#
	# param   array   taskArguments  optional  Arguments to forward to the task
	#                                          function itself.
	# return  object                           A reference to this class
	#                                          instance.
	run: (taskArguments = []) ->
		# Automatically reset the timeout if it has already been started
		@cancel()
		# Call the parent run method
		super taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'DebouncedTask', DebouncedTask

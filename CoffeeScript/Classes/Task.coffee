# Define a class that represents a single Task
class Task extends PublishSubscribe

	# After calling the parent constructor, this method takes the task function
	# and optional run scope, then assigns the values of these arguments to
	# class variables that can be referenced later. After that, the observable
	# named topic channels "run" and "exception" are defined for this task.
	#
	# param  function  taskFunction            The task function itself.
	# param  object    runScope      optional  The scope to run the task
	#                                          function at. Defaults to @.
	constructor: (taskFunction, runScope = @) ->
		# Call the parents
		# Assign the passed task function to this object
		@taskFunction = taskFunction
		# Assign the value of the optional runScope parameter to this object
		@runScope = runScope
		# Define the observable named topic channels for this class
		@addChannels ["run", "exception"]

	# Runs the task function using the passed arguments.
	#
	# param   array   taskArguments  optional  Arguments to forward to the task
	#                                          function itself.
	# return  object                           A reference to this class
	#                                          instance.
	run: (taskArguments = []) ->
		# Wrap this run attempt in a try/catch so we can capture exceptions
		try
			# Notify any observers attached to the "run" channel
			@notifyObservers "run", [@]
			# Run this task using the run scope object as the function scope
			@taskFunction.apply @runScope, taskArguments
		# If an exception is thrown, catch it
		catch exception
			# Notify any observers attached to the "exception" channel
			@notifyObservers "exception", [@, exception]
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose "Task", Task

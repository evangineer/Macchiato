# This file defines the Task class, and exposes it to the outside world.
#
# Task is a simple wrapper for a single function. This function can be executed
# at any time using the "run" method. The return value of the task function is
# intentionally prevented from being visible. This restriction helps encourage
# asynchronous design patterns. The desired scope for the task function to run
# at can be passed as an argument to the class constructor.
#
# The Task class extends PublishSubscribe. Calls to the "run" method result in
# a notification on the "run" topic channel. Likewise, exceptions thrown by the
# task function are absorbed by a try/catch block and are forwarded as
# notifications into the "exception" topic channel.
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
		# Call the parent constructor
		super()
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
		# Notify any observers attached to the "run" channel
		@notifyObservers "run", [@]
		# Wrap this run attempt in a try/catch so we can capture exceptions
		try
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

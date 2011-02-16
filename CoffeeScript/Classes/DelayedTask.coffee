# This file defines the DelayedTask class, and exposes it to the outside world.
#
# DelayedTask wraps the actual running of the task function in JavaScript
# timeout using the setTimeout function. This makes the execution of the "run"
# method on this class detached from the eventual execution of the task function
# itself.
class DelayedTask extends Task

	# Takes the task function and any options, then assigns them to this
	# object.
	#
	# param  function  taskFunction            The task function itself.
	# param  integer   delay         optional  The amount of delay, in
	#                                          milliseconds. Defaults to 1.
	# param  object    runScope      optional  The scope to run the task
	#                                          function at. Defaults to @.
	constructor: (taskFunction, delay = 1, runScope = @) ->
		# Invoke the parent constructor
		super taskFunction, runScope
		# Set the instance variables to their initial state
		@reset()

	# Resets the state of this class instance by initializing all of the class
	# variables.
	#
	# return  object  A reference to this class instance.
	reset: ->
		# Reset the value of the timeout reference class variable
		@timeoutReference = null
		# Reset the variable that tells us if we have executed the task
		@timeoutExecuted = no
		# Return a reference to this class instance
		return @

	# Cancels the execution of the delayed task, assuming that it has not
	# already been run. If the delayed task function has already been run or
	# was never run, this method does nothing.
	#
	# return  object  A reference to this class instance.
	cancel: ->
		# If we have a timeout that we can cancel
		if @timeoutReference isnt null and @timeoutExecuted is no
			# Reset the timeout if we have not already executed it
			clearTimeout @timeoutReference
		# Reset the state back to its initial values
		@reset()
		# Return a reference to this class instance
		return @

	# Runs the task function using the passed arguments.
	#
	# param   array   taskArguments  optional  Arguments to forward to the task
	#                                          function itself.
	# return  object                           A reference to this class
	#                                          instance.
	run: (taskArguments = []) ->
		# Store a reference to the Timeout
		@timeoutReference = setTimeout =>
			# Notify any observers attached to the "run" channel
			@notifyObservers "run", [@]
			# Inform the class that this timeout function has been run
			@timeoutExecuted = yes
			# Wrap this run attempt in a try/catch so we can capture exceptions
			try
				# Run the task function at the desired scope
				@taskFunction.apply @runScope, taskArguments
			# If an exception is thrown, catch it
			catch exception
				# Notify any observers attached to the "exception" channel
				@notifyObservers "exception", [@, exception]
		# Forward the desired delay to setTimeout
		, @delay
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose "DelayedTask", DelayedTask

# This file defines the IdempotentTask class, and exposes it to the outside
# world.
class IdempotentTask extends Task

	# Calls the parent constructor, forwarding the task function and optional
	# run scope arguments. After that, we call the reset method to initialize
	# the run count class variable.
	#
	# param  function  taskFunction            The task function itself.
	# param  object    runScope      optional  The scope to run the task
	#                                          function at. Defaults to @.
	constructor: (taskFunction, runScope = @) ->
		# Call the parent constructor, forwarding the function and scope
		super taskFunction, runScope
		# Reset the run count to its initial state
		@reset()

	# Reinitializes the run count class variable, allowing the task function to
	# be run, even if it has already been run once.
	#
	# return  object  A reference to this class instance.
	reset: ->
		# Reset the run count
		@runCount = 0
		# Return a reference to this class instance
		return @

	# Runs the task function using the passed arguments.
	#
	# param   array   taskArguments  optional  Arguments to forward to the task
	#                                          function itself.
	# return  object                           A reference to this class
	#                                          instance.
	run: (taskArguments = []) ->
		# Do nothing if we have already run once
		return if @runCount > 0
		# Increment the number of times we have run
		@runCount++
		# Run this task using the run scope object as the function scope
		super taskArguments
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose "IdempotentTask", IdempotentTask

# This file defines the Test class, and exposes it to the outside world. This
# class is designed to manage the state of a single unit test.
#
# The Test class is designed to be used in such a way that each unit test can be
# run asynchronously from all other tests. To support this behavior, the test
# function is passed a single argument. This argument is the instance of the
# Test class instance that is managing the test.
#
# From within the test function, the methods "assert", "assertEqual" and
# "assertNotEqual" are used to make assertions. After all of the assertions have
# been made, the method "complete" is used to indicate that the test is
# finished.
class Test extends PublishSubscribe

	# After calling the parent constructor, we register the topic channels for
	# assertions and test completion, and create the class variables to track
	# the state of this test, and store the assertions.
	#
	# param  string    name                    The name of the test that this
	#                                          class instance is responsible for
	#                                          managing.
	# param  function  testFunction            A reference to the test function.
	# param  object    testScope     optional  The scope to run the test
	#                                          function at. Defaults to @.
	constructor: (name, testFunction, testScope = @) ->
		# Call the parent constructor
		super()
		# Create the "start", "assertion", "complete", and exception named topic
		# channels
		@addChannels ["start", "assertion", "complete", "exception"]
		# Create the flag that indicates if this test has started
		@started = false
		# Create the flag that indicates if this test is complete
		@complete = false
		# Create the flag that indicates if this test threw an exception
		@exception = false
		# Create the flag that indicates if this test was generally successful
		# or not
		@successful = null
		# Create a place for all of the assertions to go
		@assertions = []
		# Define a new instance of Task for the test function
		task = new Task testFunction, testScope
		# Add an observer function to the task to watch for exceptions
		task.addObserver "exception", (task, exception) =>
			# Mark this test as failed
			@successful = false
			# Mark this test as having had an exception
			@exception = true
			# Forward the exception along to any observers
			@notifyObservers "exception", [@, exception]
		# Hold on to a reference to the task object
		@task = task

	# Starts the test.
	#
	# return  object  A reference to this class instance.
	run: ->
		# This test has started
		@started = true
		# Issue the start notification
		@notifyObservers "start", [@]
		# Execute the test function
		@task.run [@]
		# Return a reference to this class instance
		return @

	# Asserts that the value passed in the result parameter is boolean true.
	#
	# param   string   description  A human-readable description for this
	#                               assertion.
	# param   boolean  subject      The subject of the assertion, either true or
	#                               false.
	# return  object                A reference to this class instance.
	assert: (description, subject) ->
		# If the assertion is true
		if subject is true
			# The assertion is a successful one
			assertion = new AssertionSuccess description
		# Otherwise
		else
			# If any assertions fail, that means that this test was not
			# successful
			@successful = false
			# The assertion is a failure
			assertion = new AssertionFailure description
		# Add this assertion to the local assertions collection
		@assertions.push assertion
		# Forward the assertion class instance to any observers
		@notifyObservers "assertion", [@, assertion]
		# Return a reference to this class instance
		return @

	# Asserts that the value passed in for the left-hand side of the comparison
	# is exactly equal to the value passed in for the right-hand side of the
	# comparison, then forwards the result of this test to the assert function.
	#
	# param   string   description  A human-readable description for this
	#                               assertion.
	# param   mixed    left         The value for the left-hand side of the
	#                               equality comparison.		
	# param   mixed    right        The value for the left-hand side of the
	#                               equality comparison.
	# return  object                A reference to this class instance.
	assertEqual: (description, left, right) ->
		# Compare the left to the right and then forward the result of the test
		# along with the human-readable description to the assert function.
		return @assert description, left is right

	# Asserts that the value passed in for the left-hand side of the comparison
	# is not equal to the value passed in for the right-hand side of the
	# comparison, then forwards the result of this test to the assert function.
	#
	# param   string   description  A human-readable description for this
	#                               assertion.
	# param   mixed    left         The value for the left-hand side of the
	#                               equality comparison.		
	# param   mixed    right        The value for the left-hand side of the
	#                               equality comparison.
	# return  object                A reference to this class instance.
	assertNotEqual: (description, left, right) ->
		# Compare the left to the right and then forward the result of the test
		# along with the human-readable description to the assert function.
		return @assert description, left isnt right

	# Sets the boolean class variable that indicates that this test is
	# complete, then issues the "complete" notification to any observers.
	#
	# return  object  A reference to this class instance.
	complete: ->
		# Mark this test as being complete
		@complete = true
		# Indicate that this test was successful if none of the assertions
		# indicated an assertion failure
		@successful = true if @successful is null
		# Issue the "complete" notification to any observers, forwarding a
		# reference to this class instance
		@notifyObservers "complete", [@]
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose "Test", Test

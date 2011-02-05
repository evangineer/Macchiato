# This file defines the Test class, and exposes it to the outside world.
class Test extends PublishSubscribe

	# After calling the parent constructor, we register the topic channels for
	# assertions and test completion, and create the class variables to track
	# the state of this test, and store the assertions.
	constructor: ->
		# Call the parent constructor
		super()
		# Create the "assertion" and "complete" topic channels
		@addChannels ["assertion", "complete"]
		# Create the flag that indicates if this test is complete or not
		@complete = false
		# Create the flag that indicates if this test was successful or not
		@successful = null
		# Create a place for all of the assertions to go
		@assertions = []

	# Asserts that the value passed in the result parameter is boolean true.
	#
	# param   string   description  A human-readable description for this
	#                               assertion.
	# param   boolean  result       The result of a test, either true or false.
	# return  object                A reference to this class instance.
	assert: (description, result) ->
		# If the assertion is true
		if result is true
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
		@notifyObservers "assertion", assertion
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
		@assert description, left is right
		# Return a reference to this class instance
		return @

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
		@assert description, left isnt right

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
		@notifyObservers "complete", @
		# Return a reference to this class instance
		return @

# Expose this class to the parent scope
Meta.expose 'Test', Test

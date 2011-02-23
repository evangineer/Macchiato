# This file defines the Tests class, and exposes it to the outside world.
#
# This class is not intended to be instantiated directly. Instead, child
# classes should be created that have collections of unit test methods.
#
# A method created on the child class that is intended to be a test should be
# prefixed with "test". For example "test1Plus1Equals2" would be considered
# a unit test method.
#
# Other methods that are not tests can also be added and called. Also, complex
# inheritance schemes can be used to ease the creation of the application
# state for a particular unit test.
#
# Because of the asynchronous way that the tests are run, the developer must
# assume that each test method on the child class may be run in a completely
# random order. Because of this, creating any reliance on external state during
# any test is not recommended. Avoid class instance variables at all costs!
class Tests

	# Accepts the name of this test suite as the first argument, and stores it
	# as a class variable for future reference.
	#
	# param  string  name  The name of the test suite that this class instance
	#                      class instance is responsible for.
	constructor: (name) ->
		# Store the name of this test suite on this class instance
		@name = name

	# Resets all of the class variables to their initial state.
	#
	# return  object  A reference to this class instance.
	reset: ->
		# Initialize the local tests collection to an empty object
		@tests = {}
		# Initialize the class variable that tracks the grand total of
		# successful unit tests
		@successfulTests = 0
		# Initialize the class variable for tracking the grand total of
		# failed unit tests
		@failedTests = 0
		# Return a reference to this class instance
		return @

	# After resetting, this method runs all of the unit test methods defined on
	# this class instance.
	#
	# return  object  A reference to this class instance.
	run: ->
		# Resets all of the class variables to their initial values
		@reset()
		# Loop over all of the members of this class, searching for test
		# methods
		for name, method of @
			# Move on if the name does not match what is expected
			continue if not name.match /^test[a-z0-9_]*$/i
			# Move on if the data type is not a function
			continue if typeof method isnt "function"
			# Create a new instance of the Test class for managing this test
			# function, and set it up to run at this class instances scope
			test = new Test name, method, @
			# Attach the test observer function on this class instance to listen
			# for notifications on the universal topic channel of the test
			test.addObserver "*", (channel, test, reference = null) =>
				# Forward the arguments that were passed in to the test observer
				@observer channel, test, reference
			# Add this Test class instance to the tests collection on this
			# class instance
			@tests[name] = test
			# Run the test
			test.run()
		# Return a reference to this class instance
		return @

	# Listens for notifications on the universal channel of every test, and
	# outputs summary information for failed tests.
	#
	# param   string  channel              The name of the observable topic
	#                                      channel where this notification was
	#                                      issued.
	# param   object  test                 A reference to the Test class
	#                                      instance that the notification was
	#                                      issued from.
	# param   object  reference  optional  An optional reference to an instance
	#                                      of either AssertionSuccess,
	#                                      AssertionFailure, or an exception.
	# return  object                       A reference to this class instance.
	observer: (channel, test, reference = null) ->
		# Grab a reference to the name of the test
		testName = "#{@name}.#{test.name}"
		# Determine what to do based on the observable topic channel
		switch channel
			# If this was an assertion
			when "assertion"
				# Determine if the assertion was successful or not
				successful = reference instanceof AssertionSuccess
				# If this assertion was not successful
				if not successful
					# Grab a reference to the description of the assertion
					description = reference.description
					# Output the fact that this assertion failed
					console.log "#{testName}: Failed to assert that " +
						"#{description}"
			# If this was a completed test or an exception
			when "exception" or "complete"
				# Grab a shortcut to the flag that indicates if this test had
				# an exception or not
				exception = test.exception
				# Grab a shortcut variable to the flag that indicates if this
				# test was successful or not
				successful = test.successful
				# If the test had an exception
				if exception
					# Output the fact that this test threw an exception
					console.log "#{testName} threw an exception"
					# Increment the total number of failed tests
					@failedTests++
				# If the test was otherwise not successful
				else if not successful
					# Output the fact that this test failed
					console.log "#{testName} failed"
					# Increment the total number of failed tests
					@failedTests++
				else
					# Increment the total number of successful tests
					@successfulTests++

# Expose this class to the parent scope
Meta.expose "Tests", Tests

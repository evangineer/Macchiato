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

	# Resets all of the class variables to their initial state.
	#
	# return  object  A reference to this class instance.
	reset: ->
		# Reset the local tests collection

	# After resetting, this method runs all of the unit test methods defined on
	# this class instance.
	#
	# return  object  A reference to this class instance.
	run: ->
		# Resets all of the class variables to their initial values
		@reset()
		# Loop over all of the members of this class, searching for test
		# methods
		for own name, method of @
			# Move on if the name does not match what is expected
			continue if not name.match /^test[a-z0-9_]*$/i
			# Move on if the data type is not a function
			continue if typeof method isnt "function"
			# Create a new instance of the Test class for managing this test
			# function, and set it up to run at this class instances scope
			test = new Test name, method, @
			# Add this Test class instance to the tests collection on this
			# class instance
		# Return a reference to this class instance
		return @
			

# Expose this class to the parent scope
Meta.expose "Tests", Tests

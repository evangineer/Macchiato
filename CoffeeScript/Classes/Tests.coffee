# This file defines the Tests class, and exposes it to the outside world. This
# class is designed to be the base class for collections of unit tests intended
# to be run by the TestSuite class.
#
# This class is not intended to be instantiated directly. Instead, child
# classes should be created that are collections of unit tests.
#
# A method created on the child class that is intended to be a test should be
# prefixed with "test". For example "test1Plus1Equals2" would be considered
# a unit test method.
#
# Other methods that are not tests can also be added and called. Also, complex
# inheritance schemes can be used to ease the creation of the application
# state.
#
# Tests are intended to be fully asynchronous, and self-contained. When a test
# function is called by [Tests].run(), the test function is passed a single
# argument. This argument will be an instance of the Test class, and this
# instance is used to track the state of the current test that is running.
#
# From within the test function, [Test].assert() is used to make the individual
# assertions. After all of the tests have finished running, use
# [Test].complete() to indicate that there is no further processing to be done
# as part of that test.
#
# Because of the asynchronous way that the tests are run, the developer must
# assume that each test method on the child class may be run in a completely
# random order. Because of this, creating any reliance on external state during
# any test is not recommended. Avoid class instance variables at all costs!
class Tests extends PublishSubscribe

	# Defines the events that this class exposes
	constructor: ->
		# TODO: Write the body of the constructor

	# Generates a list of all of the test functions that are defined on this
	# class instance, and runs them in the order we find them.
	#
	#
	run: ->
		# TODO: Write the body of the run function

# Expose this class to the parent scope
Meta.expose 'Tests', Tests

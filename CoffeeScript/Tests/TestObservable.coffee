# This file defines the TestObservable test suite, and queues it for execution.
class TestObservable extends Tests

	# Add a single observer to the Observable class instance, and sends it one
	# notification.
	#
	# param  object  test  A reference to the Test object.
	testSimpleObserver: (test) ->
		# Create a fresh Observable class instance to play with
		observable = new Observable()
		# Attempt to add a single observer
		observable.subscribe (message) ->
			# Assert that the message is the letter T
			test.assertEqual "the message is 'T'", "T", message
			# Mark this test as complete
			test.complete()
		# Attempt to trigger the observer function by issuing a notification
		observable.publish ["T"]

# Add this test class to the tests collection
Meta.test "TestObservable", TestObservable

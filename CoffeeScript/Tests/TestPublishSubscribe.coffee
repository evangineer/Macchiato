# Define the actual test class itself
class TestPublishSubscribe extends Tests

	# Creates a new instance of the PublishSubscribe class, adds several named
	# topic queues to it, and returns it.
	createTestInstance: ->
		# Create a new instance of the PublishSubscribe class
		instance = new PublishSubscribe()
		# Add 3 named topic queues to it
		instance.addChannels ["channel-a", "channel-b", "channel-c"]
		# Return a reference to the new test object
		return instance

	# Attempt to add a single observer to channel-a and then publish a single
	# notification message to it.
	#
	# param  object  test  A reference to the Test object.
	testSimpleObserver: (test) ->
		# Create a fresh test PublishSubscribe class instance to play with
		instance = @createTestInstance()
		# Attempt to add the observer function to the channel-a topic
		instance.subscribe 'channel-a', (message) ->
			# Assert that the message is the number 11
			test.assertEqual 11, message
			# Mark this test as complete
			test.complete()
		# Attempt to trigger the observer function by issuing a notification in
		# the channel-a topic, passing the number 11 as the message
		instance.publish 'channel-a', 11

# Define the actual test class itself
class TestPublishSubscribe extends Tests

	# Creates a new instance of the PublishSubscribe class, adds several named
	# topic queues to it, and returns it.
	createTestInstance: ->
		# Create a new instance of the PublishSubscribe class, add 3 named
		# topic queues to it, and return it
		return new PublishSubscribe([
			"channel-a",
			"channel-b",
			"channel-c"
		])

	# Attempt to add a single observer to channel-a and then publish a single
	# notification message to it.
	#
	# param  object  test  A reference to the Test object.
	testNamedTopicChannelObserver: (test) ->
		# Create a fresh test PublishSubscribe class instance to play with
		instance = @createTestInstance()
		# Attempt to add the observer function to the channel-a topic
		instance.subscribe "channel-a", (message) ->
			# Assert that the message is the number 11
			test.assertEqual "the message is 11", 11, message
			# Mark this test as complete
			test.complete()
		# Attempt to trigger the observer function by issuing a notification in
		# the channel-a topic, passing the number 11 as the message
		instance.publish "channel-a", [11]

	# Attempts to add an observer to the universal channel and tests to make
	# sure that the universal channel sees notifications on all of the
	# channels.
	#
	# param  object  test  A reference to the Test object.
	testUniversalObserver: (test) ->
		# Create a fresh test PublishSubscribe class instance to play with
		instance = @createTestInstance()
		# Create a counter variable to watch how many times the observer
		# function gets notified
		counter = 0
		# Attempt to add the observer function to the universal channel
		instance.subscribe "*", (channel, message) ->
			# Increment the counter
			counter++
			# Assert that the message is the same as the counter
			test.assertEqual "the message is #{counter}", counter, message
			# If this is the 3rd call, mark this test as complete
			test.complete() if counter is 3
		# Attempt to trigger the universal channel a total of 3 times using
		# channel-a, then channel-b, then channel-c
		instance.publish "channel-a", [1]
		instance.publish "channel-b", [2]
		instance.publish "channel-c", [3]

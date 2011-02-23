# This file defines the TestPublishSubscribe test suite, and queues it for
# execution.
class TestPublishSubscribe extends Tests

	# Creates a new instance of the PublishSubscribe class, adds several named
	# topic queues to it, and returns it.
	createTestInstance: ->
		# Create a new instance of the PublishSubscribe class, add 3 named
		# topic queues to it, and return it
		return new PublishSubscribe [
			"channel-a",
			"channel-b",
			"channel-c"
		]

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
			# Define the expected channel array
			expectedChannels = ["channel-a", "channel-b", "channel-c"]
			# Grab a shortcut reference to the current expected channel
			expectedChannel = expectedChannels[counter - 1]
			# Assert that the passed channel is the same as the expected channel
			test.assertEqual "the channel is '#{expectedChannel}'", channel,
				expectedChannel
			# If this is the 3rd call, mark this test as complete
			test.complete() if counter is 3
		# Attempt to trigger the universal channel a total of 3 times using
		# channel-a, then channel-b, then channel-c
		instance.publish "channel-a", [1]
		instance.publish "channel-b", [2]
		instance.publish "channel-c", [3]

	# Confirms that notifications issued on specific topic channels do not
	# get picked up by the other named topic channels.
	#
	# param  object  test  A reference to the Test object.
	testSilenceFromUnrelatedChannels: (test) ->
		# Create a fresh test PublishSubscribe class instance to play with
		instance = @createTestInstance()
		# Attempt to add an observer function to the channel-a topic
		instance.subscribe "channel-a", (message) ->
			# Assert that the message is the number 1
			test.assertEqual "the message is 1", 1, message
		# Attempt to add an observer function to the channel-b topic
		instance.subscribe "channel-b", (message) ->
			# Assert that the message is the number 2
			test.assertEqual "the message is 2", 2, message
		# Attempt to add an observer function to the channel-c topic
		instance.subscribe "channel-c", (message) ->
			# Assert that the message is the number 3
			test.assertEqual "the message is 3", 3, message
			# Mark this test as complete
			test.complete()
		# Attempt to trigger each of the individual observer functions, first
		# the universal channel, then channel-a, then channel-b, then channel-c
		instance.publish "*"
		instance.publish "channel-a", [1]
		instance.publish "channel-b", [2]
		instance.publish "channel-c", [3]

# Add this test class to the tests collection
Meta.test "TestPublishSubscribe", TestPublishSubscribe

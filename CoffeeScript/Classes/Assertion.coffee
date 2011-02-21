# This file defines the Assertion class, which is not exposed. This class should
# not be instantiated directly. Instead, only the child classes AssertionSuccess
# or AssertionFailure should be used.
class Assertion

	# Accepts the description string and attaches it to this class instance.
	#
	# param  string  description  The description for this assertion.
	constructor: (description) ->
		# Assign the description to a class variable
		@description = description

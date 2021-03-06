# This file defines the AssertionSuccess class, and exposes it to the outside
# world.
class AssertionSuccess extends Assertion

	# Accepts the description string and forwards it to the parent constructor.
	#
	# param  string  description  The description for this assertion.
	constructor: (description) ->
		# Call the parent constructor, passing in the description
		super description

# Expose this class to the parent scope
Meta.expose "AssertionSuccess", AssertionSuccess

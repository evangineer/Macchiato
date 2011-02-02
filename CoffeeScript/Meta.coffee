# Contains methods designed to help manage code organization and visibility.
Meta = {
	# Exposes the passed function or object reference to the parent scope using the passed name
	expose: ((exposeScope) ->
		# Return a function to assign to Meta.expose
		return (name, reference) ->
			# Attach the passed reference to the parent scope
			exposeScope[name] = reference
			# Return a reference to the Meta object
			return @
	# Execute the outer function immediately, passing in a reference to the
	# parent scope
	)(if exports? then exports else @)
}

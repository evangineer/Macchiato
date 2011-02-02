Meta = {
	# Exposes the passed function or object reference to the parent scope using the passed name
	expose: ((exposeScope) ->
		return (name, reference) ->
			# Attach the passed reference to the parent scope
			exposeScope[name] = reference
			# Return a reference to the Meta object
			return @
	)(if exports? then exports else @)
}

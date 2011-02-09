# Contains functions designed to help manage code organization and visibility.
Meta = {
	# Holds a collection of all of the object and function references that get
	# exposed.
	exposed: {}

	# Exposes the passed function or object reference to the parent scope using
	# the passed name, and adds the name/reference pair to the exposed
	# references collection.
	#
	# param   string  name       The name that should be used to expose the
	#                            function or object reference.
	# param   mixed   reference  A reference to the function or object that
	#                            will be exposed.
	# return  object             A reference to the Meta object.
	expose: ((exposeScope) ->
		# Return a function to assign to Meta.expose
		return (name, reference) ->
			# Add the passed name and reference to the exposed references
			# collection
			@exposed[name] = reference
			# Attach the passed reference to the parent scope
			exposeScope[name] = reference
			# Return a reference to the Meta object
			return @
	# Execute the outer function immediately, passing in a reference to the
	# parent scope
	)(if exports? then exports else @)

	# Overlays all of the named function and object references in the exposed
	# objects collection onto the passed object.
	#
	# param   object  destination  The object on which to overlay the named
	#                              references.
	# return  object               A reference to the destination object.
	overlay: (destination) ->
		# Clone the exposed references collection onto the destination object
		destination[name] = reference for own name, reference of @exposed
		# Return a reference to the destination object
		return destination
}

# Expose the overlay function itself
Meta.expose 'overlay', Meta.overlay

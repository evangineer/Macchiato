# Grab the node File System and Child Process libraries
fs     = require 'fs'
{exec} = require 'child_process'

# Shortcuts to common functions and variables
echo = console.log
exit = process.exit

# String utilities
trim = (value) ->
	# Return the trimmed value of the string
	value.replace /^\s+|\s+$/g, ''

# Define the list of files that make up the Core
sourceFiles = [
	'Meta'
	'Classes/Task'
	'Classes/Tasks'
	'Classes/IdempotentTask'
	'Classes/DelayedTask'
	'Classes/DebouncedTask'
]

# Returns the contents of the specified filename
read = (filename) ->
	# Read the file and return it
	fs.readFileSync filename, 'ascii'

# Grab the name, version, and taglines for the library
libraryName    = trim read 'NAME'
libraryVersion = trim read 'VERSION'
libraryTagline = trim read 'TAGLINE'

# Define a place for the source file data to go
sourceFileData = []

# Define the filename for the concatenated CoffeeScript source code
concatenatedSourceFilename = "#{libraryName}.coffee"

# Define the filename for the finished JavaScript file
outputFilename = "#{libraryName}.js"

# Reads a file from the specified filename, pushing into the source file data array
loadSourceFile = (filename) ->
	# Read the source file contents into the source file data array
	sourceFileData.push fs.readFileSync "CoffeeScript/#{filename}.coffee", 'ascii'

# Writes a single file containing all of the data in the source file data array
writeConcatenatedSourceFile = ->
	# Write a single CoffeeScript file in the same directory as this Cakefile
	fs.writeFileSync concatenatedSourceFilename, sourceFileData.join "\n\n"

# Helper function to standardize the way we handle unexpected errors
handleError = (err) ->
	# If the error has a message member, we display it
	if err.message?
		# Display the message
		echo err.message
		# Exit with a failure
		exit 1
	# ...so we just throw
	throw err

# Start building the string that shows up as the first line of output
nameAndVersion = trim "#{libraryName} #{libraryVersion}"

# Show some information about this library on screen
echo "#{nameAndVersion} - #{libraryTagline}"

# Define the main build task
task 'build', "Build the complete #{libraryName} library", ->
	# Loop over each of the files in the source file array
	loadSourceFile filename for filename in sourceFiles
	# Compile all of the data in all of the source files into a single CoffeeScript file
	writeConcatenatedSourceFile()
	# Run the shell command to compile the concatenated CoffeeScript file into JavaScript
	exec "cat #{concatenatedSourceFilename} | coffee -sc > JavaScript/#{outputFilename}", (err, stdout, stderr) ->
		# If we have an error throw it
		handleError err if err
		# Delete the Macchiato.coffee file
		fs.unlink concatenatedSourceFilename, (err) ->
			# If we have an error throw it
			handleError err if err

# Define the task that resets everything
task 'clean', 'Removes everything that build creates', ->
	# Delete the Macchiato.js file
	fs.unlink "JavaScript/#{outputFilename}"

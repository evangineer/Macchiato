# Grab the node File System and Child Process libraries
fs = require "fs"
{exec} = require "child_process"

# Shortcuts to common functions and variables
echo = console.log
exit = process.exit

# Global variable that tells us if we should run the unit tests or not
runTests = no

# String utilities
trim = (value) ->
	# Return the trimmed value of the string
	value.replace /^\s+|\s+$/g, ""

# Define the list of files that make up the Core
sourceFiles = [
	"Meta"
	"Classes/Observable"
	"Classes/PublishSubscribe"
	"Classes/Task"
	"Classes/IdempotentTask"
	"Classes/DelayedTask"
	"Classes/DebouncedTask"
	"Classes/Tasks"
	"Classes/Assertion"
	"Classes/AssertionSuccess"
	"Classes/AssertionFailure"
	"Classes/Test"
	"Classes/Tests"
]

# Define the list of files that make up the Unit Tests
unitTestSourceFiles = [
	"Tests/TestPublishSubscribe"
]

# Returns the contents of the specified filename
read = (filename) ->
	# Read the file and return it
	fs.readFileSync filename, "ascii"

# Grab the name, version, and taglines for the library
libraryName = trim read "NAME"
libraryVersion = trim read "VERSION"
libraryTagline = trim read "TAGLINE"

# Define a place for the source file data to go
sourceFileData = []

# Define the filename for the concatenated CoffeeScript source code
concatenatedSourceFilename = "#{libraryName}.coffee"

# Define the filename for the finished JavaScript file
outputFilename = "#{libraryName}.js"

# Reads a file from the specified filename, pushing into the source file data
# array
loadSourceFile = (filename) ->
	# Read the source file contents into the source file data array
	sourceFileData.push read "CoffeeScript/#{filename}.coffee"

# Writes a single file containing the joined data in the source file data array
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
	# Otherwise we just throw
	throw err

# Start building the string that shows up as the first line of output
nameAndVersion = trim "#{libraryName} #{libraryVersion}"

# Show some information about this library on screen
echo "#{nameAndVersion} - #{libraryTagline}"

# Define the main build task
task "build", "Build the complete #{libraryName} library", ->
	# Echo the fact that we are doing something
	echo "Building the complete #{libraryName} library..."
	# Loop over each of the files in the source file array
	loadSourceFile filename for filename in sourceFiles
	# Compile all of the data in all of the source files into a single
	# CoffeeScript file
	writeConcatenatedSourceFile()
	# Define the shell command to compile the concatenated CoffeeScript file
	# into a single JavaScript file
	compileCommand = "cat #{concatenatedSourceFilename} | " +
		"coffee -sc > JavaScript/#{outputFilename}"
	# Run the compile command string
	exec compileCommand, (err, stdout, stderr) ->
		# If we have an error throw it
		handleError err if err
		# Delete the Macchiato.coffee file
		fs.unlink concatenatedSourceFilename, (err) ->
			# Echo the fact that we are done now
			echo "Done."
			# Run the unit tests if we should
			if runTests
				# Echo the fact that we are going to run all of the unit tests
				echo "Running tests..."
				# Define the shell command to execute the unit tests
				testCommand = "node JavaScript/#{outputFilename}"
				# Execute the tests
				exec testCommand, (err, stdout, stderr) ->
					# If we have an error, throw it
					handleError if err
					# Forward all of the output
					echo stdout
					# Echo the fact that we are done now
					echo "Done."

# Define the task that runs all of the unit tests
task "test", "Run all of the unit tests", ->
	# Add the unit tests source files array
	sourceFiles = sourceFiles.concat unitTestSourceFiles
	# Set the flag that tells the build task to run all of the unit tests
	runTests = yes
	# Build the project
	invoke "build"

# Define the task that resets everything
task "clean", "Removes everything that build creates", ->
	# State that we are doing something
	echo "Cleaning everything up..."
	# Delete the Macchiato.js file
	fs.unlink "JavaScript/#{outputFilename}", (err) ->
		# Echo the fact that we are done now
		echo "Done."

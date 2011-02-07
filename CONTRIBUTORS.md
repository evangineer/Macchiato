Notes for Macchiato Contributors
================================
What differentiates a successful project from an unsuccessful one is clear
communication, and that's exactly what this document is for. If someone pointed
you to this document, it's not because they are attacking you or beating your
contributions down. It's the opposite - it's because they really actually do
want your contributions to be a part of this project.

So, before contributing to the Macchiato project, maybe you could take a few
minutes to read these guidelines.

Code Formatting Guidelines
--------------------------
Languages that use whitespace indentation as an integral part of application
logic tend to help developers agree on how source code should be formatted.
Alas, some of the age-old source code formatting holy wars still manage to
resurrect themselves from the dead. They then rampage around the project doing
nothing but damage to the sense of community, unity, and camaraderie that any
software project needs order to thrive and be great!

So, in the spirit of not wasting time debating things that can never be agreed
upon, here is the not very heavy-handed code formatting guidelines:

### CoffeeScript ###

1. Code will use a mixed scheme of both tabs and spaces for indentation. Tabs
   are to be used to indent code up to the first non-whitespace character. From
   there to the end of the line, spaces are to be used for any indentation.
2. While writing code, it should be a goal to keep individual lines within 80
   characters in length. This is not because of some antiquated attachment to
   80-column displays. This is because text is more readable when lines fit
   into a narrow visual column. However, sometimes CoffeeScript's syntax will
   make it desirable to write lines that are longer then 80 characters, or
   there may be significant JavaScript performance improvements if instructions
   are placed upon the same line. In general, the vast majority of the code in
   this project should be able to comply with the 80 character line length
   without any trouble.
3. All classes, class methods, object methods and stand-alone functions should
   have comments that describe the purpose of the function, as well as any
   input parameters, return values, and exceptions that can be thrown. The
   guidelines for these comments are outlined in the area titled "CoffeeScript
   Source Code Documentation" below.
4. Source code comments should appear often and express exactly what the
   developers intentions are in simple human terms. Comments should be added
   until the point where adding comments would reduce the readability of the
   code. In practice, this will almost never happen, unless the commenter is
   intentionally trying to make a point against code comments. But if your goal
   is to create useful code comments, you'll find a way.
5. These guidelines can be added to, but once a guideline is accepted, making
   changes to that guideline should be avoided at almost all costs. In the
   rare event that a developer chooses to suggest a change to one of these
   guidelines, and that change is accepted, that developer will also take on
   the personal responsibility to make sure that all existing code is made
   compliant with the change they suggested.

#### CoffeeScript Source Code Documentation ####

Valid data types that can be used to describe the function input and output
parameters are:

Git Commit Comments
-------------------

Unit Tests
----------

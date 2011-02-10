What differentiates a successful project from an unsuccessful one is clear
communication, and that's exactly what this Wiki is for. If someone pointed you
to one of these pages, it's not because they are attacking you or beating your
contributions down (usually.) It's because everyone really does want your
contributions to be included in this project!

So, before doing anything else, please take a few minutes to get familiar with
these guidelines. If you find yourself confused by something that is written
here, feel free to ask questions about it. Or, if you know how to make the
information better, change it. This is a Wiki, after all.

Code Formatting Guidelines

Languages that use whitespace indentation as an integral part of application
logic tend to help developers agree on how source code should be formatted.
Alas, some of the age-old source code formatting holy wars still manage to
resurrect themselves from the dead. They then rampage around the project doing
nothing but damage to the sense of community, unity, and camaraderie that any
software project needs order to thrive and be great!

So, in the spirit of not wasting time debating things that can never be agreed
upon, here are the code formatting guidelines:

### For CoffeeScript ###

1. Code will use a mixed scheme of both tabs and spaces for indentation. Tabs
   are to be used to indent code up to the first non-whitespace character. From
   there to the end of the line, spaces are to be used for any indentation.

2. When working on code, your code editor should be configured so that your
   visible tab width is 4. Also, watch out for editors that try to "help" you
   by automatically expanding your tabs to spaces.

3. While writing code, it should be a goal to keep individual lines 80
   characters in length.

   This desire does not spring from some sort of antiquated attachment to 80-
   column displays. This desire simple comes from the proven fact that text is
   more readable when lines fit into a narrow visual column.
 
   However, sometimes CoffeeScript's syntax will make it desirable to write
   lines that are longer then 80 characters, or there may be significant
   JavaScript performance improvements if instructions are placed upon the same
   line. In general, however, the vast majority of the CoffeeScript code in
   this project should be able to comply with this guideline.

4. All classes, class methods, object methods and stand-alone functions should
   have comments that describe the purpose of the function, as well as any
   input parameters, return values, and exceptions that can be thrown. The
   specific guidelines for these comments is discussed on the
   [[CoffeeScript Source Code Documentation]] page.

5. Source code comments should appear often, and express exactly what the
   developers intentions are in simple human terms. In other words, code
   comments should be written as if the reader is not actually familiar with
   CoffeeScript.

   Comments should be added until the point where adding comments would reduce
   the readability of the code. In practice, this will almost never happen,
   unless the commenter is intentionally trying to make a point against code
   comments. But if the goal is to create useful code comments, the commenter
   will find a way.

6. These guidelines can be added to, but once a guideline is accepted, making
   changes to that guideline should be avoided at almost all costs.

   In the rare event that a developer chooses to suggest a change to one of
   these guidelines, and that change is accepted, that same developer will also
   take on the personal responsibility to make sure that all existing code is
   made compliant with the change that they suggested.

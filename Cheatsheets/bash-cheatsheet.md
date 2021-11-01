# Resources


#Lexical scoping rather than Dynamic scoping by using foo() () instead of foo() {}
https://cuddly-octo-palm-tree.com/posts/2021-10-31-better-bash-functions/
Subshell awesomeness

Now, say we define our functions with a slightly different syntax:

my_func() (
    # code
)

All we've done is replace the {} with (). It may look like a benign change, but now, whenever that function is invoked, it will be run within a subshell. What does that mean? Well, it means that:

    Variables are lexically scoped. You can read variables from the outer shell from within a subshell, but you cannot write to them. Variables defined within a subshell are invisible to the outer shell. In short, local variables within a subshell-function work exactly like you'd expect function-local variables to work in most languages. They're also not dynamically scoped.
    Subfunctions work just like you would expect, too: functions defined within a subshell are local to that subshell. They can still see the variables defined in the outer shell, but not modify them (again, lexical scope). This nesting works on as many levels as you need, provided you keep using parentheses to define your functions.
    Subshells are, as the name suggests, running in a subshell. They don't strictly have to be OS subprocesses (because it can be more efficient for them not to be), but they have to behave as if they were. This means that they get their own EXIT trap if they need one. When the subshell exits, normally or due to a crash, it will run its own EXIT handler, then pass on its exit code to the parent, which may at that point still run its own EXIT handler. It all nests as you'd want.

# Using Bash Scrict Mode
http://redsymbol.net/articles/unofficial-bash-strict-mode/
Use Bash Strict Mode (Unless You Love Debugging)

Let's start with the punchline. Your bash scripts will be more robust, reliable and maintainable if you start them like this:

    #!/bin/bash
    set -euo pipefail
    IFS=$'\n\t'

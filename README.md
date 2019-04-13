# Clean Bash - Leveling up your shell scripting skills

Slides and supporting material for my talk "Clean Bash" at [Loadays 2019](https://loadays.org/).

## Talk description

Bash: the scripting language everyone loves to hate. The syntax is arcane and hard to read. Some concepts, e.g. booleans and exit status, are fundamentally different than other scripting or programming languages, which confuses novice users. Bash is not really suited for large, complex scripts.  Bash scripts are usually one-offs: written once, and rarely touched afterwards.

Consequenty, coding style, testability and maintainability are way down on (or absent from) a sysadmin's priority list.

However, Bash is ubiquitous. It's in every Linux and UNIX distribution, on every Mac laptop and, nowadays, even on Windows (when Git is installed). Even in the leanest, minimal, stripped down box, you at least have Bash. There are no dependencies. It's impossible to underestimate how useful it is for automating tedious tasks involving files or text. So there is definitely value in learning and using Bash.

Let's say you have written shell scripts before. When you look at them again after months or even years, do you still understand how they work? If running a script fails, would you know what went wrong and how to look for bugs in the code? Does your script continue to work correctly if you run it multiple consecutive times? If you answered "no" to any of these questions, this talk is for you.

Topics include:

- Debugging and testing scripts
- Improving readability
- Robert C. Martin's "Clean code" applied to Bash
- Idempotence

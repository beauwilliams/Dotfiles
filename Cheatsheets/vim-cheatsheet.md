
# S&R

Case sensitive S&R with global confirmation, using \C

`:%s/old\C/new/gc`

R takes you into replace mode — it’s a quicker option in cases where you want to replace part of a word with something else of the same length. Try it!
* # — go to next/previous occurrence of word under cursor [handy!];
% — go to matching paren, tag, or delimiter
f F t T — go to, i.e. (f)ind next/previous or find un(t)il next/previous occurrence of <character> in the current line, forwards or Backwards
; , — go to next/previous occurrence of last in-line search (e.g. f or t)


J join lines — I use this one often!

Change case — g~ (for single characters or selections, you can just use ~ as a shorthand)
Lowercase — gu
Uppercase — gU

Vim also keeps track of the locations of the “changes” that you make in the file, allowing you to navigate places you’ve been in your recent editing activity:

    Go to previous/next edit location — g; g, (I use these often, e.g. “What was I doing before this?”)

Observe how g; and g, mirror a similar idea in ; and , which are used in f t searches, so you can think of them in the same way.

And finally, Vim also keeps track of recent cursor positions, prior to any “jumps”:

    Jump back (o)ut to previous location / Jump back (i)n / Jump to definition — C-o C-i C-] (useful for navigating code)

xp — swap character forwards (very common, e.g. to fix simple typos)
Xp — swap character backwards
dbwP — swap word backwards (sometimes also dBWP or daWBP)
dwwP — swap word forwards (sometimes also dWWP or daWWP)
ddp — swap line forwards
ddkP — swap line backwards

The pattern for swapping is the same for any noun, so paragraphs may be swapped in the same manner as words or letters. More phrases:

yyp — duplicate line
ywP or ywwP or yaWP etc. — duplicate word
yapP — duplicate paragraph (and so on to duplicate anything)
0d^ – delete leading whitespace, i.e. at the start of the line (or ^d0)
g_lD – delete trailing whitespace, i.e. at the end of the line (that’s an “l” as in London)

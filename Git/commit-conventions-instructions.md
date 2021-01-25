# How to

To add the template to your global git config is enter the following:

`git config --global commit.template path/to/your/file.txt`

*Now whenever you’re making a commit, instead of the typical git commit -m "A brief commit message", just enter git commit to open your default editor with the template in place. You’ll automatically have a guide to choose conventions from to create a structured message.*

The “header” of the commit message notes the type of the commit as docs and a brief description that does not exceed 60 characters to ensure readability (the commented lines are 60 characters long and act as guides for when to use a line break). The “body” optionally elaborates on the changes made, and the “footer” optionally notes any issue/PR the commit is related to. The final message will simply look like this:

*The final message will look like this*

```
docs: Update README with contributing instructions

Adds a CONTRIBUTING.md with PR best practices, code style
guide, and code of conduct for contributors.

Closes #9
```
# Vim Setup

*If you use Vim or Neovim, and you want to speed up the process even more, you can add this to your git config:*

```
# Neovim
git config --global core.editor "nvim +16 +startinsert"

# Vim
git config --global core.editor "vim +16 +startinsert"
```

This sets the default editor to Neovim (or Vim), and places the cursor on line 16 in Insert Mode as soon the editor opens. Now whenever you’re committing, when you type git commit, Neovim opens the template, places your cursor, and accepts typing input immediately. Also note that you can still use git commit -m "Your message" exactly as you did before, but the configuration will default to the template setup when you just type git commit.



# **CREATE**

# From existing data,

    git init creates new repository in current directory
    git add . add all latest changes to the next commit

Cd ~/projects/my project
git inti
git add .

# From existing repo

    git clone is used to clone a repositroy from a remote server

git clone ~/existing/repo ~new/repo
git clone you@host:dir/project.git (default protocol is ssh)

# Remote repository for existing local data

mkdir repo.git && cd repo.git
git init --bare[--shared=group]






# **UPDATE**

# Fetch latest changes from origin

git fetch (this does not merge them)

# Pull latest changes from origin

git pull (does a fetch followed by a merge)

# Apply a patch that someone sent you

git am -3 patch.mbox (In case of conflict, resolve the conflict and)
git am --resolve





# **PUBLISH**

# Commit all local changes

git commit -a

# Commit previously staged changes

git commit -m "descriptive message"

# Prepare a patch for other developers

git format-patch origin

# Push changes to origin

git push [origin][branch]

# Make a version or a milestone

git tag <version_name>







# **STASH**

# Stash uncommitted changes before moving to another branch
git stash

# Give the stash a name for easy reference
git stash push -m

# Return local copy of branch back to how it was when you stashed it earlier
git stash pop





# **BRANCH**

# Switch to the BRANCH branch

git checkout <BRANCH>

# Merge branch B1 into branch B2

git checkout <B2>
git merge <B1>

# Create branch based on HEAD

git branch <BRANCH>

# Create branch based on another

git checkout <new><base>

# Delete a branch

git branch -d <branch>





# **REBASE**

# Rebase with git

git debase origin/master

    Which would apply all the changes in master, below your branch, to make your commits grouped together and more organized.

# Interactive rebase

git rebase -i HEAD~2

    Which runs your debase in interactive mode for the most recent 2 commits (which is really helpful for squashing and renaming your commits), making it more readable.






# **REVERT**

# Return to the last committed state

git checkout -F | git reset --hard (you cannot undo a hard reset)

# Revert the last commit

git revert HEAD (Creates a new commit)

# Revert specific commit

git revert $id (Creates a new commit)

# Fix the last commit

git commit -a --amend (after editing the broken files)

# Checkout the ID version of a file

git checkout <ID><file>

# **SHOW**

# Files changed in working directory

git status

# Changes to tracked files

git diff

# Changes between Ida and Ida

git diff <ID1><ID2>

# History of changes

git log

# History of changes with files changed

git whatchanged

# Who changed what and when in a file

git blame <file>

# A commit identifies by ID

git show <ID>

# A specific file from a specific ID

git diff <ID>:<file>

# All local branches

git branch (star "*" marks the current branch)

# Search for patterns

git grep<pattern>[path]






# FYI

    master is the default development branch
    origin is the default upstream repository
    HEAD is the current branch



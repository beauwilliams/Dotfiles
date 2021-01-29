------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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



------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **UPDATE**

# Fetch latest changes from origin

git fetch (this does not merge them)

# Pull latest changes from origin

git pull (does a fetch followed by a merge)

# Apply a patch that someone sent you

git am -3 patch.mbox (In case of conflict, resolve the conflict and)
git am --resolve



------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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






------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **STASH**

# Stash uncommitted changes before moving to another branch
git stash

# Give the stash a name for easy reference
git stash push -m

# Return local copy of branch back to how it was when you stashed it earlier
git stash pop




------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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




------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **REBASE**

# Rebase with git

git debase origin/master

    Which would apply all the changes in master, below your branch, to make your commits grouped together and more organized.

# Interactive rebase

git rebase -i HEAD~2

    Which runs your debase in interactive mode for the most recent 2 commits (which is really helpful for squashing and renaming your commits), making it more readable.





------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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










------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **CHANGES**

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







------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **CONFIG**

    Define author name to be used for all commits in current repo. Developers commonly use --global flag to set config options for current user.

git config user.name <name>

    Define the author name to be used for all commits by the current user

git config --global user.name <name>

    Define the author email to be used for all commits by the current user.

git config --global user.email <email>

    Create shortcut for a Git command.

git config --global alias. <alias-name> <git-command>

    Set text editor used by commands for all users on the machine. <editor> arg should be the command that launches the desired editor (e.g. vi).

git config --system core.editor <editor>

    Open the global configuration file in a text editor for manual editing.

git config --global --edit



------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# **PGP SIGNATURE FOR COMMITS**

## Set up GPG

    First you have to install GPG, if you don’t already have it. You can verify your installation (i.e. with Windows Power Shell) like this:

gpg --version
gpg (GnuPG) 2.2.17
libgcrypt 1.8.4

    If your system doesn't know them yet, you have to import your public and private keys (I assume you have them stored in files called public.key and private.key). If you don’t have a key pair, you can generate a new one. In that case, you can skip the import and directly jump to Set up Git. It's also possible to use your Keybase GPG key, if you have one (Stephen Rees-Carter wrote a nice article about it).

gpg --import public.key
gpg --import private.key

    Note: when importing the private key, a GUI window appears that asks for the corresponding passphrase you set when creating your key pair.

# Set up Git

    Now you can tell Git your signing key ID. It’s a 16-digit alphanumeric string that can be found with gpg --list-signatures (look for lines starting with “sig”).

git config --global user.signingkey 26A64778F76A7911

    If you want, you can tell Git to sign commits per default (since Git 2.0), so you don’t always have to add the -s flag in the command line:

git config --global commit.gpgsign true

    Note, that I use the --global flag here to apply these settings to all my local repositories. Of course you can apply these settings only to the current repository without it.

# Set up GitHub

    Now you have to give GitHub (or whatever Git server you’re using) your public key. You can print it with mpg --armor --export or get-content -path public.key (or open it with your favorite text editor) and copy it to your clipboard. Now go to GitHub, click on the top right menu, go to Settings > SSH and GPG keys > New GPG key and paste your key — it should look like this:

-----BEGIN PGP PUBLIC KEY BLOCK-----
...a lot of characters...
-----END PCP PUBLIC KEY BLOCK-----


# Error: secret key not available

    Well, would have been too easy if it worked at first try… unfortunately I had to deal with the following weird error message, that appeared always when I tried to commit using the -s flag:

git commit -am "a message" -s
gpg: skipped "26A64778F76A7911": secret key not available
gpg: signing failed: secret key not available
error: gpg failed to sign the data
fatal: failed to write commit object

    After some research, I found, that I had to tell Git the path to the GPG executable (for whatever reason) using the git config pgp.program setting:

git config --global gpg.program "C:\Program Files (x86)\gnupg\bin\gpg.exe"

    Note that the path may be a different one on your system.



------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# FYI

    master is the default development branch
    origin is the default upstream repository
    HEAD is the current branch



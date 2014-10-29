dot-git
=======

git configuration files

gitconfig
---------

The configuration file `.gitconfig` contains all default configuration for the 
git system.

gitignore
---------

The `.gitignore` contains a list of generally ignored files and directories 
from git.

Attach a pull request to an existing issue
------------------------------------------

Sometimes, an issue already exists on a project and you find a solution.  You
create a pull request but with the default behaviour of Github, it will appear
as a new issue.

To associate a pull request to an existing issue, 2 ways exists.  You can use
the `hub` program.

    $ hub pull-request -i 4

Or you can directly use the API of Github.  First, fork the project (let's call
it myproject) on your Github web interface.  Then clone the project `myproject`
on your computer.

    $ git clone git@github.com:woshilapin/myproject.git

Create a new branch explicitly for the pull request, for
example, `mybranch`.

    $ cd myproject/
    $ git checkout -b mybranch

Do the modifications that need to be done (bug fixing, new feature, etc.),
commit it and then push it by explicitly push the new branch.

    $ git add *
    $ git commit -m "bug fix of issue #42"
    $ git push -u origin mybranch

Now, we can call the Github API to use this new branch to create a pull request
associated with the existing issue (which is the issue #42).

    $ curl \
        --user "me" \
        --request POST \
        --data '{"issue":"42","head":"me:mybranch","base":"master"}' \
        https://api.github.com/repos/theguy/myproject/pulls

Let's explain a bit this command.  The `--user` is your Github login.  In
`--data` field, you give the number of the issue (42).  You also give the branch
you want to merge by prefixing your Github login.  Then you give the branch on
top of which you want to merge.  Finally, you give a link to the repository to which
you want to make a pull request (in this case, the repository is `myproject`
created by a name whose login is `theguy`).

See http://stackoverflow.com/questions/4528869/how-do-you-attach-a-new-pull-request-to-an-existing-issue-on-github for more information.

# Prerequisites

1) PHP 8.1+
2) [Composer](https://getcomposer.org/)

Composer is a memory hog. You will likely need to set a high(er) memory_limit in your php.ini file.

You will also need to store your GitHub credentials in Composer's authentication store, thus:

`composer -g config http-basic.github.gatech.edu username password`

# Install process

1) Download and unzip the gt_installer (this repo).
2) At the command line, navigate to the gt_installer directory.
3) Make sure the file 'install.sh' is executable.
4) Do `./install.sh` and follow the prompts.

# Command flags

There are several command flags you can use if you don't want to keep entering redundant information on multiple installs or whatever. 

-d : **Project path**. The fully qualified path to your project from the server root
-n : **Database name**. The name of the database. Note that any data in the database will be overwritten.
-u : **Database user**. The database username
-h : **Database host**. The database host (e.g. localhost)
-r : **Database port**. The database port (e.g. 3306)
-s : **Site name**. The site name (e.g. Office of Officework). This will go in the top banner of the site.
-e : **Email**. The site email address
-l : **Local**. Set this flag to install with a loose (e.g. 777) set of files permissions.

# Manual installation
Alternately, you can do the install process manually:

3) After step 2 above, do `composer create-project --repository-url=packages.json --remove-vcs gt/gt_installer {path-to-your-project-directory}`
5) Do `cd {path-to-your-project-directory}`
6) Do `drush site-install --db-url=mysql://{username}:{password}@{database-host}/{database} --site-name="{Your Site Name}" --account-mail={your-email@gatech.edu}`

Note that in the event that a new profile is released between multiple installs, you may need to do `composer clearcache` to pick up the changes.

## Note for users with 2FA on GitHub

If you use two-factor authentication for your GitHub account, you will need to generate an access token. Instructions can be found here: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line. The token must be made available to composer thusly:

`composer config -g github-oauth.github.gatech.edu paste-your-token-here`

At this time Institute Communications cannot offer support for this feature, but we'll be happy to include revisions to the above documentation if any of it proves to be incorrect.

+++

Please report any issues with the installer at https://github.gatech.edu/ICWebTeam/gt_installer/issues

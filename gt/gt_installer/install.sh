#!/bin/bash

# WARNING: This script is somewhat experimental and will probably fail on your machine and maybe
# take out all your music and family photos in the process. Use with caution.

while getopts d:n:u:t:r:s:e:-:lh option
do

  # support long options: https://stackoverflow.com/a/28466267/519360
  if [ "${option}" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`

    case "$OPT" in
      h | help )     showhelp=true ;;
      ??* )          die "Illegal option --$OPT" ;;  # bad long option
      ? )            exit 2 ;;  # bad short option (error reported via getopts)
    esac

    if [ "$showhelp" = true ]; then
      cat <<"EOF"

  The following options are available:
    -d      The absolute path to your project
    -n      The name of your project database
    -u      The database user
    -t      The database host; defaults to localhost
    -r      The database port; defaults to 3306
    -s      The name of your site; This will appear as the site title.
    -e      The email address for the site.
    -l      Include this flag if you are establishing a local site and want the
            files directory permissions to be set to 777.

EOF

      exit 0;
    fi
  fi

  case "${option}"
    in
      d) PROJECTPATH=${OPTARG};;
      n) DBNAME=${OPTARG};;
      u) DBUSER=${OPTARG};;
      t) DBHOST=${OPTARG};;
      r) DBPORT=${OPTARG};;
      s) SITENAME=${OPTARG};;
      e) EMAIL=${OPTARG};;
      l) LOCAL=true;;
  esac

done

if [[ $OSTYPE == 'msys' ]]; then
  DIRECTORY_SEPARATOR='\'
else
  DIRECTORY_SEPARATOR='/'
fi

# Project path?
if [ -z "$PROJECTPATH" ]; then
	echo -n "Enter the full path to your project directory: "
	read -e PROJECTPATH
fi

# Check whether path exists; ask whether to create it if it does not.
if [ ! -d "$PROJECTPATH" ]; then
  while true; do
    read -p "$PROJECTPATH does not exist. Create it? [y/n] " yn
    case $yn in
        [Yy]* ) mkdir -p $PROJECTPATH; break;;
        [Nn]* ) echo -n "Exiting."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
fi

if [ "$(ls -A $PROJECTPATH)" ]; then
  echo -e "$PROJECTPATH is not empty. Exiting."
  exit
fi

# DB username?
if [ -z "$DBUSER" ]; then
	echo -n "Enter your database username: "
	read -e DBUSER
fi

# DB password?
# DB password?
echo -n "Enter your database password: "
read -se DBPASS
# DB password?
echo -ne "\n"

# DB host?
if [ -z "$DBHOST" ]; then
	echo -n "Enter your database host [localhost]: "
	read -e DBHOST
  if [ -z "$DBHOST" ]; then
    DBHOST="localhost"
  fi
fi

# DB port?
if [ -z "$DBPORT" ]; then
	echo -n "Enter the database port [3306]: "
	read -e DBPORT
  if [ -z "$DBPORT" ]; then
    DBPORT="3306"
  fi
fi

# DB?
if [ -z "$DBNAME" ]; then
	echo -n "Enter the name of the database: "
	read -e DBNAME
fi

# Site name
if [ -z "$SITENAME" ]; then
	echo -n "Enter the site name: "
	read -e SITENAME
fi

# Email
if [ -z "$EMAIL" ]; then
	echo -n "Enter the site email: "
	read -e EMAIL
fi

echo "Starting..."

# Clear the composer cache!
composer clearcache

# Next composer assembles all the site files.
yes | composer create-project --repository-url=packages.json --remove-vcs gt/gt_installer $PROJECTPATH
if [ ! "$?" = "0" ]; then
  echo 'A massive error has occurred. Composer was unable to create your project. It was fun while it lasted.'
  exit
else
  echo 'Project created successfully...'
fi

# Head to the web directory to finish up.
cd ${PROJECTPATH}${DIRECTORY_SEPARATOR}web
if [ ! "$?" = "0" ]; then
  echo 'A massive error has occurred. Composer failed to generate a web directory. Perhaps it was sunspots.'
  exit
fi

# Then Drush installs the database
yes | ${PROJECTPATH}${DIRECTORY_SEPARATOR}vendor${DIRECTORY_SEPARATOR}bin${DIRECTORY_SEPARATOR}drush site-install --db-url=mysql://$DBUSER:$DBPASS@$DBHOST:$DBPORT/$DBNAME --site-name="$SITENAME" --account-mail=$EMAIL
if [ ! "$?" = "0" ]; then
  echo 'A massive error has occurred. Drush failed to install the site. Drush is funny that way.'
  exit
else
	# Set basic secure permissions
	chmod 755 "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default"                                            # The father of the bane of Composer's existence.
	chmod 770 "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}default.services.yml"    # The bane of Composer's existence.
	chmod 644 "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}settings.php"            # Drupal community's general consensus.
  if [ "$LOCAL" = true ]; then
      find "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}files" -type d -print0 | xargs -0 chmod 777  # Local dev is loose
  else
    find "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}files" -type d -print0 | xargs -0 chmod 755    # Directories are 755
  fi
	find "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}files" -type f -print0 | xargs -0 chmod 644      # Files are 644

	# Fix issue with re-hardened permissions causing `composer update` failure
	echo '' >> "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}settings.php"    # Spacing
	echo '# Skip permissions hardening to prevent Composer Update failure in Plesk environment' >> "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}settings.php"
	echo '$settings['\''skip_permissions_hardening'\''] = TRUE;' >> "${PROJECTPATH}${DIRECTORY_SEPARATOR}web${DIRECTORY_SEPARATOR}sites${DIRECTORY_SEPARATOR}default${DIRECTORY_SEPARATOR}settings.php"

  echo 'Site installed successfully...'
fi

exit 0

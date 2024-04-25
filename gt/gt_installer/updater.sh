#!/usr/bin/env bash

### Options ###
while getopts d:t option
do
case "${option}"
in
d) PROJECTPATH=${OPTARG};;
t) DRYRUN=true;;
esac
done



### Project path? ###
if [ -z "$PROJECTPATH" ]; then
	echo -n "Enter the full path to your project's root directory: "
	read -e PROJECTPATH
fi

cd $PROJECTPATH



### Simple XML Site Map will screw everything up ###
enabled=$(drush pml | grep "simple_sitemap" | grep "Enabled    3")
if [ ! -z "$enabled" ]; then
  echo "The Simple XML sitemap must be upgraded *prior* to starting this process."
  echo "Not so simple after all..."
  echo "Please upgrade this module to version 4.x and then start the updater again."
  exit 1
fi



### Uninstall back_to_top temporarily
enabled=$(drush pml | grep "back_to_top" | grep "Enabled")
if [ ! -z "$enabled" ]; then
  echo "Temporarily uninstalling back_to_top."
  drush pmu back_to_top
  BTT=true
fi



### Uninstall incompatible modules ###
echo "Uninstalling incompatible modules."

# Got to do this ridiculous dance because hashes don't exist in Bash 3
blacklist=(
  "Advanced Aggregation"
  "Block Blacklist"
  "Calendar"
  "Calendar Datetime"
  "CKEditor Entity Link"
  "Collapse Text"
  "Console"
  "Content Type Clone"
  "Image Field Caption"
  "jQuery UI Effects"
  "SEO Checklist"
  "Simple Image Rotate"
  "Simple Timeline"
  "Superfish"
  "Views Templates"
  "Checklist API"
  "Webform Migrate"
)
blacklist_keys=(
  "advagg"
  "block_blacklist"
  "calendar"
  "calendar_datetime"
  "ckeditor_entity_link"
  "collapse_text"
  "console"
  "content_type_clone"
  "image_field_caption"
  "jquery_ui_effects"
  "seo_checklist"
  "simple_image_rotate"
  "simple_timeline"
  "superfish"
  "views_templates"
  "checklistapi"
  "webform_migrate"
)
for i in ${!blacklist_keys[@]}; do
  enabled=$(drush pml | grep ${blacklist_keys[$i]} | grep "Enabled")
  if [ ! -z "$enabled" ]; then
    echo "Uninstalling incompatible module: ${blacklist[$i]}"
    drush pmu ${blacklist_keys[$i]}
  fi
done

# Also uninstall GT_Footerdaemon if need be. We'll do this separately because we
# don't want composer to try removing it.
enabled=$(drush pml | grep "gt_footerdaemon" | grep "Enabled")
if [ ! -z "$enabled" ]; then
  echo "Uninstalling incompatible module: gt_footerdaemon"
  drush pmu gt_footerdaemon
fi


### Remove composer lock file ###
if test -f "composer.lock"; then
  echo "Removing composer lock file."
  rm composer.lock
fi



### Remove incompatible modules from manifest ###
echo "Removing incompatible module entries from composer.json."
for i in ${!blacklist_keys[@]}; do
  installed=$((composer show --ansi "drupal/${blacklist_keys[$i]}") 2>&1)
  if [[ $installed != *"not found"* ]]; then
    echo "Removing ${blacklist[$i]}"
    composer remove --ansi "drupal/${blacklist_keys[$i]}" --no-update
  fi
done



### Update module constraints ###
echo "Updating module constraints for D10 compatibility."

# More Bash 3 compatiblity workarounds
declare modules=(
  "drupal/addtoany"
  "drupal/addtocal"
  'drupal/admin_toolbar'
  "drupal/back_to_top"
  "drupal/better_exposed_filters"
  "drupal/cas"
  "drupal/captcha"
  "drupal/colorbox"
  "drupal/content_access"
  "drupal/core-composer-scaffold"
  "drupal/core-project-message"
  "drupal/core-recommended"
  "drupal/custom_add_another"
  "drupal/devel"
  "drupal/entity_clone"
  "drupal/entity_type_clone"
  "drupal/devel_entity_updates"
  "drupal/focal_point"
  "drupal/genpass"
  "drupal/imce"
  "drupal/jquery_ui_accordion"
  "drupal/jquery_ui_datepicker"
  "drupal/jquery_ui_slider"
  "drupal/layout_builder_styles"
  "drupal/linkit"
  "drupal/migrate_plus"
  "drupal/migrate_tools"
  "drupal/migrate_upgrade"
  "drupal/module_filter"
  "drupal/simple_sitemap"
  "drupal/twig_vardumper"
  "drupal/pathologic"
  "drupal/video"
  "drupal/views_block_filter_block"
  "drupal/views_infinite_scroll"
  "drush/drush"
  "gt/gt_editor"
  "gt/gt_profile"
  "gt/gt_theme"
  "gt/gt_tools"
  "gt/hg_reader"
)
declare constraints=(
  "2.0"
  "3.0@beta"
  "3.0"
  "3.0"
  "6.0"
  "2.0"
  "2.0"
  "2.0"
  "2.0@RC"
  "10.0"
  "10.0"
  "10.0"
  "2.0@beta"
  "5.0"
  "2.0@beta"
  "4.0"
  "4.0"
  "2.0@alpha"
  "2.0"
  "3.0"
  "2.0"
  "2.0"
  "2.0"
  "2.0"
  "6.0"
  "6.0"
  "6.0"
  "4.0"
  "4.0"
  "4.0"
  "3.0"
  "2.0@alpha"
  "3.0"
  "2.0"
  "2.0"
  "11.0"
  "dev-4.x-dev"
  "4.0"
  "4.0"
  "4.0"
  "4.0"
)

for u in ${!modules[@]}; do
  installed=$((composer show --ansi "${modules[$u]}") 2>&1)
  if [[ $installed != *"not found"* ]]; then
    echo "Updating ${modules[$u]}"
    if [[ ${modules[$u]} == *'gt_editor'* ]]; then
      composer require --ansi "${modules[$u]}: ${constraints[$u]}" --no-update
    else
      composer require --ansi "${modules[$u]}:^${constraints[$u]}" --no-update
    fi
  fi
done



### Adding core module replacements ###
echo "Adding replacements for deprecated core modules."

composer require 'drupal/ckeditor_lts:^1.0' 'drupal/classy:^1.0' 'drupal/color:^1.0' 'drupal/externalauth:^2.0' 'drupal/jquery_ui_slider:^2.0' 'drupal/quickedit:^1.0' 'drupal/rdf:^2.0' 'drupal/seven:^1.0' 'drupal/stable:^2.0' --no-update --ansi

### Install ###
echo "Installing Drupal 10 and dependencies."

if [ "$DRYRUN" = true ]; then
  installation=$((composer update --dry-run --ansi --with-all-dependencies) 2>&1 | tee /dev/tty)
else
  installation=$((composer update --ansi --with-all-dependencies) 2>&1 | tee /dev/tty)
fi
if [[ "$installation" == *"Your requirements could not be resolved to an installable set of packages."* ]]; then
  echo "As you can see, composer is not happy about something. Most likely your installation includes a module that we haven't anticipated. Please copy the error message above and send it to webteam@gatech.edu."
  echo
  exit 1
fi



### DB update ###
echo "Updating database."
drush updb



### Re-enable back_to_top if needed ###
if [ "$BTT" = true ]; then
  echo "Re-enabling back_to_top."
  drush en back_to_top
fi



### DONE ###
echo "Finished."

echo "Before proceeding, make sure ALL of the following modules are UNINSTALLED from your production site:"
delim=""
for item in "${blacklist[@]}"; do
  printf "%s" "$delim$item"
  delim=", "
done
echo

if [ "$BTT" = true ]; then
  echo "N.B.: You will need to uninstall Back to Top *before* uninstalling jQuery UI Effects. It can be re-enabled after the upgrade is complete and pushed to production."
fi
echo

echo "Once this is done, you may commit your files and run update.php. Most sites will WSOD until update.php is run; don't be frightened."

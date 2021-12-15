# GT Theme

`gt_theme` is the official Georgia Tech theme (https://theme.gatech.edu) for the Drupal 8+ content management system.

This theme package is compatible with Drupal 8.0.0 and above (including Drupal 9).

## Requirements

The GT Theme requires:
* [GT Tools (gt_tools)](https://github.gatech.edu/ICWebTeam/gt_tools-8.x)

## Installation

This theme is best installed using the [Georgia Tech Drupal 8+ installer, gt_installer](https://github.gatech.edu/ICWebTeam/gt_installer). Manual installation of this theme may result in degraded functionality.

## Theme design
The GT theme is composed of packaged theme bundles for easy use.

<table style="width: 100%">
<tr><th>Theme package</th><th>Usage</th><th>Status</th></tr>
<tr>
	<td>Archimedes</td>
	<td>Georgia Tech header and footer design.</td>
	<td>End of Life / Unsupported</td>
</tr>
<tr>
	<td>Babbage</td>
	<td>The work of Archimedes plus basic content design (headers, font).</td>
	<td>End of Life / Unsupported</td>
</tr>
<tr>
	<td>Curie</td>
	<td>The work of Babbage plus per-page customizations and design via Drupal's Layout Builder.</td>
	<td>Supported</td>
</tr>
</table>

## Curie package
The **Curie theme package** contains the most up-to-date Georgia Tech design elements and allows for full page customizations. [The Georgia Tech Theme website](http://theme.gatech.edu/) contains documentation and training videos.

### Configuration
As an administrative user, navigate to *'Appearance - Curie (or Curie subtheme) - Settings* (also located from admin/appearance/settings/curie ).

On the theme settings page, configure:

* **GT (CAS) login options**: Enable or disable single-sign on through Georgia Tech authentication.
* **Header options**: Enable header and subheader text links.
* **Breadcrumbs options**: Enable or disable breadcrumbs.
* **Superfooter options**: Configure the display of the superfooter.
* **Custom CSS**: Add custom CSS.
* **Contact information**: Customize the contact address in the footer.

### Extending Curie
Curie can be easily extended through a subtheme. See [theme_coe_podcast](https://github.gatech.edu/coe-web/theme_coe_podcast) for an example of a Curie subtheme.

## Need help?
The Georgia Tech community provides the following support:

* [Georgia Tech theme tutorials, training, and videos](http://theme.gatech.edu/)
* The Georgia Tech web community: Reach out to the Georgia Tech Drupal community via the [listserv](https://drupal.gatech.edu/about-us/gt-drupal-mailing-list) and [Microsoft Team](https://drupal.gatech.edu/about-us/ms-team).
* Submit bug reports via the [gt_theme issue queue](https://github.gatech.edu/ICWebTeam/gt_theme-8.x/issues).
* Contact Institute Communications Web Team at webteam@gatech.edu.
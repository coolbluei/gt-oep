Welcome to version 3.x of the Drupal 9 edition of Mercury Reader. Please report issues in GitHub.

INSTALLATION

If you used the gt_installer you will already have the module and it will already be enabled.

CONFIGURATION

Extreme caveat: hg_reader looks for a text format named limited_html and uses that as its default. If you don't have such a format, it will use plain text, which is not good unless you like to see your pages decorated with HTML tags. Before you make any importers, go to admin/config/hg-reader/settings and select a text format. A future version of the module will create -- if the user approves -- a default text format upon installation.

The other fields on the configuration page are mostly useful for development. You can stick with the defaults.

USAGE

Once the reader is installed and configured, you'll need to make an IMPORTER. For folks that have used the Feeds module, hg_reader works a lot like that, except there's no field assignments required -- it's all in the module. For folks that think Feeds is something you give to cows, here's how hg_reader works:

1) You create an Importer; You supply it with the ID of a Mercury feed.
2) hg_reader periodically checks the feed for content, creates appropriate pages on your system -- e.g. events, news, etc.

Easy peasy.

Content types for each Mercury type are provided by default, and can be modified like any other content type (though if you delete fields to which hg_reader is mapping information, you'll be in a world of hurt). In practice, this means you can create your own fields and taxonomies if you have something special you want to do with the content once it's on your site. Also provided by default: news and events pages (and blocks), located at /hg/events and /hg/news respectively. These too can be modified -- they are produced by Views, so you can do with them what you would do with any view. Furthermore, you can make your own views, slicing and dicing content as you see fit.

Everything in hg_reader is node-based, so all node-based facilities pertain. You can integrate with Pathauto, Rules, whatever. Go nuts.

THEMING

Since the output of this module is all nodes and pages and blocks, theming boils down to what you'd be doing if you weren't using hg_reader, so no biggie. Note that the module includes a stylesheet. It's a bare-bones stylesheet, aimed solely at preventing a trainwreck. It works best with the GT theme.

BUGS

Should you encounter a bug, go to https://github.gatech.edu/ICWebTeam/hg_reader/issues and give us the details.

CODA

Kudos may be expressed in the form of beer. Criticism may be expressed in the form of silent meditation.

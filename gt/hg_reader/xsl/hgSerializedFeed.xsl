<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">
    <xsl:output method="text" encoding="utf-8" indent="no"/>
    <xsl:param name="author" select="'webteam@gatech.edu'"/>
    <xsl:param name="version" select="'1.0'"/>

    <xsl:template match="/nodes">
        <xsl:variable name="total" select="count(/nodes/node)"/>

        <xsl:text>a:</xsl:text>
        <xsl:value-of select="$total"/>
        <xsl:text>:{</xsl:text>

        <xsl:for-each select="node">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:if test="type = 'news'">
                <xsl:text>a:31:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('subtitle')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="subtitle" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('sentence')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="sentence" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('summary')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="summary" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('teaser')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="teaser" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('location')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="location" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('sidebar')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="sidebar" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('contact')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="contact" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('email')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="email" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('author')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="author" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('dateline')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="dateline" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('release')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="release" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('expire')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="expire" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('image')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="image" />
                </xsl:call-template>

                <xsl:call-template name="related_links" />

                <xsl:call-template name="boilerplate" />

                <xsl:call-template name="flags" />

                <xsl:call-template name="hg_media" />

                <xsl:call-template name="files" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="categories" />

                <xsl:call-template name="news_terms" />

                <xsl:call-template name="news_room_topics" />

                <xsl:call-template name="core_research_areas" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'event'">
                <xsl:text>a:33:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('sentence')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="sentence" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('summary')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="summary" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('teaser')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="teaser" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('phone')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="phone" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('event_url_title')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="location_url/title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('event_url')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="url" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('event_email')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="email" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('event_fee')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="fee" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('event_location')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="location" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('start')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="start" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('end')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="end" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('contact')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="contact" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('author')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="author" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('release')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="release" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('expire')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="expire" />
                </xsl:call-template>

                <xsl:call-template name="related_links" />

                <xsl:call-template name="event_extras" />

                <xsl:call-template name="event_audience" />

                <xsl:call-template name="times" />

                <xsl:call-template name="boilerplate" />

                <xsl:call-template name="flags" />

                <xsl:call-template name="hg_media" />

                <xsl:call-template name="files" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="categories" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'hgTechInTheNews'">
                <xsl:text>a:17:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('teaser')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="teaser" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('publication')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="publication" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('article_dateline')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="article_dateline" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('article_url')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="article_url" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('author')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="author" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="hg_media" />

                <xsl:call-template name="flags" />

                <xsl:call-template name="files" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'feature'">
                <xsl:text>a:18:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('dateline')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="dateline" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('release')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="release" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('expire')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="expire" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('author')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="author" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('url')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="url" />
                </xsl:call-template>

                <xsl:call-template name="flags" />

                <xsl:call-template name="media" />

                <xsl:call-template name="hg_media" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="news_terms" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'image'">
                <xsl:text>a:14:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('image_name')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="image_name" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('image_path')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <!-- We have to cheat a bit here because the image path, stupidly, is unencoded. -->
                    <xsl:with-param name="element_value" select="image_full_path" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('image_body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="flags" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="categories" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'profile'">
                <xsl:text>a:43:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('summary')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="summary" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('firstname')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="firstname" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('middlename')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="middlename" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('lastname')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="lastname" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nickname')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="nickname" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('college_school')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="college_school" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('department')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="department" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('specialty')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="specialty" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('degree')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="degree" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('address')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="address" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('city')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="city" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('state')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="state" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('zipcode')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="zipcode" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('primaryemail')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="primaryemail" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('secondaryemail')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="secondaryemail" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('url')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="url" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('url_title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="url_title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('phone')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="phone" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('fax')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="fax" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('cell')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="cell" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('jobtitle')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="jobtitle" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('alttitle')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="alttitle" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('research')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="research" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('teaching')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="teaching" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('author')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="author" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('release')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="release" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('expire')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="expire" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('image')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="image" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('linkedin')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="linkedin/link/url" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('twitter')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="twitter/link/url" />
                </xsl:call-template>

                <xsl:call-template name="areas_of_expertise" />

                <xsl:call-template name="classifications" />

                <xsl:call-template name="recent_news" />

                <xsl:call-template name="hg_media" />

                <xsl:call-template name="files" />

                <xsl:call-template name="related_links" />

                <xsl:call-template name="groups" />

                <xsl:text>}</xsl:text>
            </xsl:if>

            <xsl:if test="type = 'video'">
                <xsl:text>a:13:{</xsl:text>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('nid')" />
                    <xsl:with-param name="element_format" select="string('numeric')" />
                    <xsl:with-param name="element_value" select="@id" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('type')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="type" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('title')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="title" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('body')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="body" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('created')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="created" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('changed')" />
                    <xsl:with-param name="element_format" select="string('string')" />
                    <xsl:with-param name="element_value" select="changed" />
                </xsl:call-template>

                <xsl:call-template name="general_element">
                    <xsl:with-param name="element_name" select="string('youtube_id')" />
                    <xsl:with-param name="element_format" select="string('base64')" />
                    <xsl:with-param name="element_value" select="youtube_id" />
                </xsl:call-template>

                <xsl:call-template name="flags" />

                <xsl:call-template name="primary" />

                <xsl:call-template name="groups" />

                <xsl:call-template name="categories" />

                <xsl:call-template name="news_terms" />

                <xsl:call-template name="keywords" />

                <xsl:text>}</xsl:text>
            </xsl:if>

        </xsl:for-each>
        <xsl:text>}</xsl:text>

    </xsl:template>

    <xsl:template name="classifications">
        <xsl:text>s:15:"classifications";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(classifications/classification)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="classifications/classification">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="areas_of_expertise">
        <xsl:text>s:18:"areas_of_expertise";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(areas_of_expertise/area)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="areas_of_expertise/area">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="recent_news">
        <xsl:text>s:11:"recent_news";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(recent_news/item)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="recent_news/item">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_numeric" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(nid)"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="nid"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="format_numeric">
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>
    </xsl:template>

    <xsl:template name="format_string">
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>
    </xsl:template>

    <xsl:template name="format_base64">
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
    </xsl:template>

    <xsl:template name="general_element">
        <xsl:param name="element_name" />
        <xsl:param name="element_format" />
        <xsl:param name="element_value" />
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length($element_name)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="$element_name"/>
        <xsl:text>";</xsl:text>
        <xsl:text>a:2:{</xsl:text>
        <xsl:if test="$element_format='numeric'">
            <xsl:call-template name="format_numeric"/>
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length($element_value)"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="$element_value"/>
        </xsl:if>
        <xsl:if test="$element_format='string'">
            <xsl:call-template name="format_string"/>
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length($element_value)"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="$element_value"/>
        </xsl:if>
        <xsl:if test="$element_format='base64'">
            <xsl:call-template name="format_base64"/>
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',$element_value))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',$element_value)"/>
        </xsl:if>
        <xsl:text>";</xsl:text>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="flags">
        <xsl:text>s:5:"flags";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(flags/flag)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="flags/flag">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('type')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="type" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('value')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="value" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="hg_media">
        <xsl:text>s:8:"hg_media";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(hg_media/item)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="hg_media/item">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:22:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('nid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="nid" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('type')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="type" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('title')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="title" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('body')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="body" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('image_name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="image_name" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('image_path')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <!-- Cheating. Full path uses encoded file name. -->
                <xsl:with-param name="element_value" select="image_full_path" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('image_mime')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="image_mime" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="video_name" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_fid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="video_fid" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_path')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="video_path" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_mime')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="video_mime" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('flv_name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="flv_name" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('flv_fid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="flv_fid" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('flv_path')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="flv_path" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('flv_mime')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="flv_mime" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_thumb_name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="video_thumb_name" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_thumb_fid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="video_thumb_fid" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_thumb_path')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="video_thumb_path" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_thumb_mime')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="video_thumb_mime" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_width')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="video_width" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('video_height')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="video_height" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('youtube_id')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="youtube_id" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="media">
        <xsl:text>s:5:"media";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(media/item)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="media/item">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_numeric" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(self::node())"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="self::node()"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="primary">
        <xsl:text>s:7:"primary";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(primary_group)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="primary_group">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('gid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="@id" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="self::node()" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="groups">
        <xsl:text>s:6:"groups";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(groups/group)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="groups/group">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('gid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="@id" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('name')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="self::node()" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="news_terms">
        <xsl:text>s:10:"news_terms";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(news_terms/term)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="news_terms/term">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="news_room_topics">
        <xsl:text>s:16:"news_room_topics";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(news_room_topics/topic)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="news_room_topics/topic">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="core_research_areas">
        <xsl:text>s:19:"core_research_areas";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(core_research_areas/area)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="core_research_areas/area">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="keywords">
        <xsl:text>s:8:"keywords";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(keywords/keyword)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="keywords/keyword">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="categories">
        <xsl:text>s:10:"categories";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(categories/category)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="categories/category">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="related_links">
        <xsl:text>s:13:"related_links";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(related/link)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="related/link">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('url')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="url" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('title')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="title" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="event_extras">
        <xsl:text>s:12:"event_extras";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(extras/extra)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="extras/extra">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:1:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('extra')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="self::node()" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="event_audience">
        <xsl:text>s:14:"event_audience";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(event_audience/term)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="event_audience/term">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>

            <xsl:text>a:2:{</xsl:text>
            <xsl:call-template name="format_base64" />
            <xsl:text>s:5:"value";</xsl:text>
            <xsl:text>s:</xsl:text>
            <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
            <xsl:text>:"</xsl:text>
            <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
            <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="times">
        <xsl:text>s:5:"times";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(times/item)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="times/item">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:4:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('startdate')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="value" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('daterule')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="rrule" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('timezone')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="timezone" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('stopdate')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="value2" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="boilerplate">
        <xsl:text>s:11:"boilerplate";</xsl:text>
        <xsl:text>a:2:{</xsl:text>

        <xsl:call-template name="general_element">
            <xsl:with-param name="element_name" select="string('nid')" />
            <xsl:with-param name="element_format" select="string('numeric')" />
            <xsl:with-param name="element_value" select="boilerplate" />
        </xsl:call-template>

        <xsl:call-template name="general_element">
            <xsl:with-param name="element_name" select="string('text')" />
            <xsl:with-param name="element_format" select="string('base64')" />
            <xsl:with-param name="element_value" select="boilerplate_text" />
        </xsl:call-template>

        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template name="files">
        <xsl:text>s:5:"files";</xsl:text>
        <xsl:text>a:</xsl:text>
        <xsl:value-of select="count(files/file)"/>
        <xsl:text>:{</xsl:text>
        <xsl:for-each select="files/file">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:5:{</xsl:text>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('fid')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="@id" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('filename')" />
                <xsl:with-param name="element_format" select="string('base64')" />
                <xsl:with-param name="element_value" select="name" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('filesize')" />
                <xsl:with-param name="element_format" select="string('numeric')" />
                <xsl:with-param name="element_value" select="size" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('mime')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="mime" />
            </xsl:call-template>

            <xsl:call-template name="general_element">
                <xsl:with-param name="element_name" select="string('filepath')" />
                <xsl:with-param name="element_format" select="string('string')" />
                <xsl:with-param name="element_value" select="full_path" />
            </xsl:call-template>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
        <xsl:text>}</xsl:text>
    </xsl:template>

</xsl:stylesheet>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">
<xsl:output method="text" encoding="utf-8" indent="no"/>
<xsl:param name="author" select="'webteam@gatech.edu'"/>
<xsl:param name="version" select="'1.0'"/>

  <xsl:template match="/node">





  <xsl:if test="type = 'news'">
    <xsl:text>a:24:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"subtitle";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_subtitle/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_subtitle/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"dateline";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_dateline/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_dateline/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"location";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_location/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_location/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"summary";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_summary/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"sentence";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_summary_sentence/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary_sentence/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"contact";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_contact/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_contact/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:13:"contact_email";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_contact_email/item/email))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_contact_email/item/email)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"sidebar";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_sidebar/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_sidebar/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"boilerplate";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_boilerplate/item/nid/node/body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_boilerplate/item/nid/node/body)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>
            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>
            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"keywords";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_keywords/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_keywords/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>
            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:10:"categories";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_categories/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_categories/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>
            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:19:"core_research_areas";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_core_research_areas/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_core_research_areas/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>
            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:16:"news_room_topics";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_news_room_topics/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_news_room_topics/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>
            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"hg_media";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_media/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_media/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:12:{</xsl:text>

            <xsl:text>s:3:"nid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/nid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/nid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"type";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/type)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/type"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"title";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/title)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"body";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/body))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/body)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_image/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_image/item/filename"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_path";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_image/item/file_full_path)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_image/item/file_full_path"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_mime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_image/item/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_image/item/filemime"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"video_name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/title)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"video_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/nid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/nid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"youtube_id";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_youtube/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_youtube/item/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:11:"video_width";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_width/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_width/item/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:12:"video_height";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_height/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_height/item/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>
        <xsl:text>}</xsl:text>
      </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"files";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(files/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="files/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:6:{</xsl:text>

            <xsl:text>s:3:"fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="fid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filename";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:11:"description";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',description))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',description)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filepath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"mime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filemime"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filesize";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filesize)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filesize"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"links";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(links_related/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="links_related/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:9:"linktitle";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',link_title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',link_title)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:7:"linkurl";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',url))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',url)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'event'">
    <xsl:text>a:26:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"location";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_location/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_location/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:13:"locationphone";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_phone/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_phone/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:13:"locationemail";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_email/item/email))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_email/item/email)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"locationurl";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_url/item/url))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_url/item/url)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:16:"locationurltitle";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_url/item/title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_url/item/title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:3:"fee";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_fee/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_fee/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"extras";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(extras/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="extras/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:9:"extratype";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"event_audience";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_audience/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_audience/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:8:"audience";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"times";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_time/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_time/item">
            <xsl:text>i:</xsl:text>
            <xsl:value-of select="(position() - 1)"/>
            <xsl:text>;</xsl:text>
            <xsl:text>a:4:{</xsl:text>

              <xsl:text>s:9:"startdate";</xsl:text>
              <xsl:text>a:2:{</xsl:text>

                <xsl:text>s:6:"format";</xsl:text>
                <xsl:text>s:6:"string";</xsl:text>

                <xsl:text>s:5:"value";</xsl:text>
                <xsl:text>s:</xsl:text>
                <xsl:value-of select="string-length(value)"/>
                <xsl:text>:"</xsl:text>
                <xsl:value-of select="value"/>
                <xsl:text>";</xsl:text>

              <xsl:text>}</xsl:text>

              <xsl:text>s:8:"daterule";</xsl:text>
              <xsl:text>a:2:{</xsl:text>

                <xsl:text>s:6:"format";</xsl:text>
                <xsl:text>s:6:"string";</xsl:text>

                <xsl:text>s:5:"value";</xsl:text>
                <xsl:text>s:</xsl:text>
                <xsl:value-of select="string-length(rrule)"/>
                <xsl:text>:"</xsl:text>
                <xsl:value-of select="rrule"/>
                <xsl:text>";</xsl:text>

              <xsl:text>}</xsl:text>

              <xsl:text>s:8:"timezone";</xsl:text>
              <xsl:text>a:2:{</xsl:text>

                <xsl:text>s:6:"format";</xsl:text>
                <xsl:text>s:6:"string";</xsl:text>

                <xsl:text>s:5:"value";</xsl:text>
                <xsl:text>s:</xsl:text>
                <xsl:value-of select="string-length(timezone)"/>
                <xsl:text>:"</xsl:text>
                <xsl:value-of select="timezone"/>
                <xsl:text>";</xsl:text>

              <xsl:text>}</xsl:text>

              <xsl:text>s:8:"stopdate";</xsl:text>
              <xsl:text>a:2:{</xsl:text>

                <xsl:text>s:6:"format";</xsl:text>
                <xsl:text>s:6:"string";</xsl:text>

                <xsl:text>s:5:"value";</xsl:text>
                <xsl:text>s:</xsl:text>
                <xsl:value-of select="string-length(value2)"/>
                <xsl:text>:"</xsl:text>
                <xsl:value-of select="value2"/>
                <xsl:text>";</xsl:text>

              <xsl:text>}</xsl:text>

              <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"summary";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_summary/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"sentence";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_summary_sentence/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary_sentence/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"contact";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_contact/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_contact/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"keywords";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_keywords/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_keywords/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:16:"event_categories";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_event_categories/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_event_categories/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"media";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_media/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_media/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:18:{</xsl:text>

            <xsl:text>s:6:"nodeid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/nid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/nid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"type";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/type)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/type"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"title";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/title)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"body";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/body))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/body)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"video";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"video_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/fid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"videomime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/filemime"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"videopath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"flash";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_flash/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_flash/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"flash_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_flash/item/fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_flash/item/fid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"flashpath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_flash/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_flash/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"videothumb";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumb_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/fid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbpath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbmime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filemime"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:7:"youtube";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_youtube/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_youtube/item/value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"width";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_width/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_width/item/value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:6:"height";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_height/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_height/item/value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"files";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(files/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="files/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:6:{</xsl:text>

            <xsl:text>s:3:"fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="fid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filename";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:11:"description";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',description))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',description)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filepath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"mime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filemime"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filesize";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(filesize)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="filesize"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"links";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(links_related/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="links_related/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:9:"linktitle";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',link_title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',link_title)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:7:"linkurl";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',url))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',url)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"boilerplate";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_boilerplate/item/nid/node/body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_boilerplate/item/nid/node/body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'external_news'">
    <xsl:text>a:13:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"teaser";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',teaser))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',teaser)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"publication";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_publication/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_publication/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"article_url";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_article_url/item/url))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_article_url/item/url)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"dateline";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_dateline/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_dateline/item/value)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"taxonomy";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(taxonomy/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="taxonomy/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"vid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(vid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="vid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',name))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',name)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'hgFeature'">
    <xsl:text>a:13:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"dateline";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_dateline/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_dateline/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"release";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_release/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_release/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"expire";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_expire/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_expire/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:3:"url";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_url/item/url)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_url/item/url"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"media";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_media/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_media/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:13:{</xsl:text>

            <xsl:text>s:6:"nodeid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/nid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/nid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"type";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/type)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/type"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"title";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/title)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"body";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',nid/node/body))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',nid/node/body)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"video";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"videopath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"flash";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_flash/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_flash/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"flashpath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_flash/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_flash/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"videothumb";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filename"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbpath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filepath"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbmime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/item/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/item/filemime"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"width";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_width/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_width/item/value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:6:"height";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_height/item/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_height/item/value"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'profile'">
    <xsl:text>a:40:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"summary";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_summary/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"firstname";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_first_name/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_first_name/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:10:"middlename";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_middle_name/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_middle_name/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"lastname";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_last_name/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_last_name/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"nickname";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_nickname/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_nickname/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"college_school";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_college_school))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_college_school)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:10:"department";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_department/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_department/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"specialty";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_specialty/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_summary_specialty/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"degree";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_degree/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_degree/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"address";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_address/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_address/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"city";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_city/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_city/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"state";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_state/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_state/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"zipcode";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_zip_code/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_zip_code/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:12:"primaryemail";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_primary_email/item/email))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_primary_email/item/email)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"secondaryemail";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_secondary_email/item/email))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_secondary_email/item/email)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:3:"url";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_profile_url/item/url))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_profile_url/item/url)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"phone";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_phone_number/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_phone_number/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:3:"fax";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_fax_number/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_fax_number/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"cell";</xsl:text>
      <xsl:text>a:2:{</xsl:text>
        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>
        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_cell_phone/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_cell_phone/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"jobtitle";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_job_title/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_job_title/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"alttitle";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_alt_job_title/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_alt_job_title/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"research";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_research/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_research/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"teaching";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_teaching/item/value))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_teaching/item/value)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"linkedin";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',links_linkedin/item/url))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',links_linkedin/item/url)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"twitter";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',links_twitter/item/url))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',links_twitter/item/url)"/>
        <xsl:text>";</xsl:text>
      <xsl:text>}</xsl:text>

      <xsl:text>s:15:"classifications";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_classification/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_classification/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"expertise";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_areas_of_expertise/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_areas_of_expertise/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:12:"affiliations";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_affiliations/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="field_affiliations/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"tid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(tid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="tid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode', value))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode', value)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"hg_media";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(hg_media/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="hg_media/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:18:{</xsl:text>

            <xsl:text>s:6:"nodeid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"type";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(type)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="type"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"title";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',title)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"body";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',body)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',image_name))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',image_name)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_path";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',image_full_path))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',image_full_path)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"image_mime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',image_mime))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',image_mime)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"video";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/filename"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"video_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/fid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"videomime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/filemime"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:9:"videopath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_video/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_video/filepath"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:10:"videothumb";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/filename)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/filename"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumb_fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/fid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/fid"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbpath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/filepath)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/filepath"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:14:"videothumbmime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_thumbnail/filemime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_thumbnail/filemime"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:7:"youtube";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_youtube/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_youtube/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:5:"width";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_width/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_width/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:6:"height";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(nid/node/field_height/value)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="nid/node/field_height/value"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

        <xsl:text>}</xsl:text>
      </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:11:"recent_news";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(field_previous_events/item)"/>
      <xsl:text>:{</xsl:text>
      <xsl:for-each select="field_previous_events/item">
        <xsl:text>i:</xsl:text>
        <xsl:value-of select="(position() - 1)"/>
        <xsl:text>;</xsl:text>
        <xsl:text>a:2:{</xsl:text>
          <xsl:text>s:6:"format";</xsl:text>
          <xsl:text>s:7:"numeric";</xsl:text>
          <xsl:text>s:5:"value";</xsl:text>
          <xsl:text>s:</xsl:text>
          <xsl:value-of select="string-length(nid)"/>
          <xsl:text>:"</xsl:text>
          <xsl:value-of select="nid"/>
          <xsl:text>";</xsl:text>
        <xsl:text>}</xsl:text>
      </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"files";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(files/file)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="files/file">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:5:{</xsl:text>

            <xsl:text>s:3:"fid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(@id)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="@id"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filename";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(name)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="name"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filepath";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(full_path)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="full_path"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"mime";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"string";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(mime)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="mime"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:8:"filesize";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(size)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="size"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"links";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(links_related/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="links_related/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>
            <xsl:text>s:5:"title";</xsl:text>
            <xsl:text>a:2:{</xsl:text>
              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>
              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',link_title))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',link_title)"/>
              <xsl:text>";</xsl:text>
            <xsl:text>}</xsl:text>

            <xsl:text>s:3:"uri";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',url))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',url)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'image'">
    <xsl:text>a:9:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"taxonomy";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(taxonomy/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="taxonomy/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"vid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(vid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="vid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',name))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',name)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





  <xsl:if test="type = 'video'">
    <xsl:text>a:24:{</xsl:text>

      <xsl:text>s:3:"nid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(@id)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"type";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(type)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="type"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"title";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',title))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',title)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"body";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',body))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',body)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"created";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(created)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="created"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"changed";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(changed)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="changed"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:7:"youtube";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_youtube/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_youtube/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"video";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_video/item/filename))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_video/item/filename)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"video_fid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_video/item/fid)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_video/item/fid"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"videopath";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_video/item/filepath))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_video/item/filepath)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"videomime";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_video/item/filemime)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_video/item/filemime"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"flash";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_flash/item/filename))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_flash/item/filename)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"flash_fid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_flash/item/fid)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_flash/item/fid"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"flashpath";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_flash/item/filepath))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_flash/item/filepath)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:9:"flashmime";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"string";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_flash/item/flashmime)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_flash/item/flashmime"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:10:"videothumb";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_thumbnail/item/filename))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_thumbnail/item/filename)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"videothumb_fid";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_thumbnail/item/fid)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_thumbnail/item/fid"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"videothumbpath";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"base64";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(php:functionString('base64_encode',field_thumbnail/item/filepath))"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="php:functionString('base64_encode',field_thumbnail/item/filepath)"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:14:"videothumbmime";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:6:"strong";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_thumbnail/item/filemime)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_thumbnail/item/filemime"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:5:"width";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_width/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_width/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"height";</xsl:text>
      <xsl:text>a:2:{</xsl:text>

        <xsl:text>s:6:"format";</xsl:text>
        <xsl:text>s:7:"numeric";</xsl:text>

        <xsl:text>s:5:"value";</xsl:text>
        <xsl:text>s:</xsl:text>
        <xsl:value-of select="string-length(field_height/item/value)"/>
        <xsl:text>:"</xsl:text>
        <xsl:value-of select="field_height/item/value"/>
        <xsl:text>";</xsl:text>

      <xsl:text>}</xsl:text>

      <xsl:text>s:4:"gids";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:3:"gid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(self::node())"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="self::node()"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:6:"groups";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(og_groups_both/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="og_groups_both/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:1:{</xsl:text>

            <xsl:text>s:4:"name";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',self::node()))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',self::node())"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

      <xsl:text>s:8:"taxonomy";</xsl:text>
      <xsl:text>a:</xsl:text>
      <xsl:value-of select="count(taxonomy/item)"/>
      <xsl:text>:{</xsl:text>
        <xsl:for-each select="taxonomy/item">
          <xsl:text>i:</xsl:text>
          <xsl:value-of select="(position() - 1)"/>
          <xsl:text>;</xsl:text>
          <xsl:text>a:2:{</xsl:text>

            <xsl:text>s:3:"vid";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:7:"numeric";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(vid)"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="vid"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

            <xsl:text>s:4:"term";</xsl:text>
            <xsl:text>a:2:{</xsl:text>

              <xsl:text>s:6:"format";</xsl:text>
              <xsl:text>s:6:"base64";</xsl:text>

              <xsl:text>s:5:"value";</xsl:text>
              <xsl:text>s:</xsl:text>
              <xsl:value-of select="string-length(php:functionString('base64_encode',name))"/>
              <xsl:text>:"</xsl:text>
              <xsl:value-of select="php:functionString('base64_encode',name)"/>
              <xsl:text>";</xsl:text>

            <xsl:text>}</xsl:text>

          <xsl:text>}</xsl:text>
        </xsl:for-each>
      <xsl:text>}</xsl:text>

    <xsl:text>}</xsl:text>
  </xsl:if>





</xsl:template>
</xsl:stylesheet>

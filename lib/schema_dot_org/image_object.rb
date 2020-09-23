# frozen_string_literal: true

module SchemaDotOrg
  class ImageObject < SchemaType
    attr_accessor :author,
                  :content_url,
                  :name,
                  :thumbnail_url,
                  :identifier,
                  :license,
                  :acquire_license_page

    def _to_json_struct
      struct = {
        'author' => author.to_json_struct,
        'contentUrl' => content_url,
        'name' => name,
        'thumbnailUrl' => thumbnail_url,
        'license' => license,
        'acquireLicensePage' => acquire_license_page
      }
      struct['identifier'] = identifier if identifier

      struct
    end
  end
end

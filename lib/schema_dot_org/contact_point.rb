# frozen_string_literal: true

require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org Thing > Intangible > StructuredValue > ContactPoint.  See http://schema.org/ContactPoint
  class ContactPoint < SchemaType
    attr_accessor :area_served,
                  :available_language,
                  :contact_type,
                  :email,
                  :telephone

    validates :area_served,         type: String, presence: true
    validates :available_language,  type: String, presence: true
    validates :contact_type,        type: String, presence: true
    validates :email,               type: String, presence: true
    validates :telephone,           type: String, presence: true

    def _to_json_struct
      {
        'areaServed'        => area_served,
        'availableLanguage' => available_language,
        'contactType'       => contact_type,
        'email'             => email,
        'telephone'         => telephone,
      }
    end
  end
end

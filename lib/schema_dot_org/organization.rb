# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/place'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :address,
                  :contact_points,
                  :email,
                  :founder,
                  :founding_date,
                  :founding_location,
                  :logo,
                  :name,
                  :same_as,
                  :telephone,
                  :url

    # TODO create postal address class
    # validates :address,           type: SchemaDotOrg::PostalAddress
    validates :contact_points,    type: Array, allow_nil: true
    validates :email,             type: String
    validates :founder,           type: SchemaDotOrg::Person, allow_nil: true
    validates :founding_date,     type: Date, allow_nil: true
    validates :founding_location, type: SchemaDotOrg::Place, allow_nil: true
    validates :logo,              type: String, allow_nil: true
    validates :name,              type: String
    validates :same_as,           type: Array, allow_nil: true
    validates :url,               type: String

    def _to_json_struct
      struct = {
        "address"   => address,
        "email"     => email,
        "logo"      => logo,
        "name"      => name,
        "telephone" => telephone,
        "url"       => url,
        # "address" => address.is_a?(SchemaDotOrg::PostalAddress) ? address.to_json_struct : address,
      }
      struct["contactPoint"]      = contact_points.collect{|cp| cp.to_json_struct} if contact_points && contact_points.any?
      struct["founder"]           = founder.to_json_struct if founder
      struct["foundingDate"]      = founding_date.to_s if founding_date
      struct["foundingLocation"]  = founding_location.to_json_struct if founding_location
      struct["sameAs"]            = same_as if same_as

      struct
    end
  end
end

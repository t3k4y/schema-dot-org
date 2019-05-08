# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/organization'
require 'schema_dot_org/person'
require 'schema_dot_org/place'
require 'schema_dot_org/contact_point'

Organization = SchemaDotOrg::Organization
Person       = SchemaDotOrg::Person
Place        = SchemaDotOrg::Place
ContactPoint = SchemaDotOrg::ContactPoint


RSpec.describe Organization do
  describe "#new" do
    it 'will not create with an unknown attribute' do
      expect do
        Organization.new(
          snack_time:       'today',
          name:             'Public.Law',
          founder:           Person.new(name: 'Robb Shecter'),
          founding_date:     Date.new(2009, 3, 6),
          founding_location: Place.new(address: 'Portland, OR'),
          email:            'say_hi@public.law',
          url:              'https://www.public.law',
          logo:             'https://www.public.law/favicon-196x196.png',
          same_as:          [
            'https://twitter.com/law_is_code',
            'https://www.facebook.com/PublicDotLaw'
          ]
        )
      end.to raise_error(NoMethodError)
    end

    it 'creates correct json correctly' do
      public_law = Organization.new(
        name:             'Public.Law',
        founder:           Person.new(name: 'Robb Shecter'),
        founding_date:     Date.new(2009, 3, 6),
        founding_location: Place.new(address: 'Portland, OR'),
        email:            'say_hi@public.law',
        url:              'https://www.public.law',
        logo:             'https://www.public.law/favicon-196x196.png',
        same_as:          [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )

      expect(public_law.to_json_struct).to eq(
        "@type" => "Organization",
        'name' => "Public.Law",
        'email' => "say_hi@public.law",
        'url' => "https://www.public.law",
        'logo' => "https://www.public.law/favicon-196x196.png",
        'foundingDate' => "2009-03-06",
        'founder' => {
          "@type" => "Person",
          'name' => "Robb Shecter"
        },
        'foundingLocation' => {
          "@type" => "Place",
          'address' => "Portland, OR"
        },
        'sameAs' => [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )
    end

    it 'uses contact points correctly' do
      cp1 = ContactPoint.new(
        area_served:        'ES',
        available_language: 'en, es',
        contact_type:       'Sales ES',
        email:              'info@holiday.pix',
        telephone:          '+40 40 40401',
      )
      cp2 = ContactPoint.new(
        area_served:        'DE',
        available_language: 'en, de',
        contact_type:       'Sales DE',
        email:              'info@holiday.pix.de',
        telephone:          '+49 40 40401',
      )
      public_law = Organization.new(
        name:             'Public.Law',
        founder:           Person.new(name: 'Robb Shecter'),
        founding_date:     Date.new(2009, 3, 6),
        founding_location: Place.new(address: 'Portland, OR'),
        email:            'say_hi@public.law',
        url:              'https://www.public.law',
        contact_points:   [
          cp1,
          cp2
        ],
        logo:             'https://www.public.law/favicon-196x196.png',
        same_as:          [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )

      expect(public_law.to_json_struct).to eq(
        "@type" => "Organization",
        'name' => "Public.Law",
        'email' => "say_hi@public.law",
        'url' => "https://www.public.law",
        "contactPoint" => [
          { "@type" => "ContactPoint",
            "areaServed" => "ES",
            "availableLanguage" => "en, es",
            "contactType" => "Sales ES",
            "email" => "info@holiday.pix",
            "telephone" => "+40 40 40401"
          },
          { "@type" => "ContactPoint",
            "areaServed" => "DE",
            "availableLanguage" => "en, de",
            "contactType" => "Sales DE",
            "email" => "info@holiday.pix.de",
            "telephone" => "+49 40 40401"
          }],
        'logo' => "https://www.public.law/favicon-196x196.png",
        'foundingDate' => "2009-03-06",
        'founder' => {
          "@type" => "Person",
          'name' => "Robb Shecter"
        },
        'foundingLocation' => {
          "@type" => "Place",
          'address' => "Portland, OR"
        },
        'sameAs' => [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )
    end

  end
end
# rubocop:enable Metrics/BlockLength

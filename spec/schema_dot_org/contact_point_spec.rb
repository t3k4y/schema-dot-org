# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/contact_point'


RSpec.describe SchemaDotOrg::ContactPoint do # rubocop:disable Metrics/BlockLength
  let(:home) { SchemaDotOrg::ContactPoint.new(
    area_served:        'ES',
    available_language: 'en, es',
    contact_type:       'Sales ES',
    email:              'info@holiday.pix',
    telephone:          '+40 40 40401',
    ) }

  describe "#new" do
    it 'will not create a ContactPoint without an properties' do
      expect { SchemaDotOrg::ContactPoint.new }.to raise_error(ArgumentError)
    end


    it 'will not create a ContactPoint with an unknown attribute' do
      expect do
        SchemaDotOrg::ContactPoint.new(
          area_served:        'ES',
          author:             'Hemmingway', # XX
          available_language: 'en, es',
          contact_type:       'Sales ES',
          email:              'info@holiday.pix',
          telephone:          '+40 40 40401',
        )
      end.to raise_error(NoMethodError)
    end
  end

  describe "#to_json_struct" do
    it "has exactly the correct attributes and values" do
      expect(home.to_json_struct).to eq(
        '@type' => 'ContactPoint',
        'areaServed' => 'ES',
        'availableLanguage' => 'en, es',
        'contactType' => 'Sales ES',
        'email' => 'info@holiday.pix',
        'telephone' => '+40 40 40401',
      )
    end
  end
end

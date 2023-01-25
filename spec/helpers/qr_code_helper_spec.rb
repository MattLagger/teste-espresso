# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the QrCodeHelper. For example:
#
# describe QrCodeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe(QrCodeHelper, type: :helper) do
  context 'generate qr code' do
    it 'generates svg qrcode' do
      user = create(:user)
      qr_code_uri = user.two_factor_qr_code_uri
      qr_svg = qr_code_as_svg(qr_code_uri)
      expect(qr_svg.present?).to(eq(true))
    end
  end
end

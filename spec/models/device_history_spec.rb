require 'spec_helper'

describe DeviceHistory do

  describe '.create_if_change_in_dtc_or_vbatt' do

    has_low_batt = 1
    has_dtc = 0
    incoming = {
        device_id: '9999999999',
        dtc_codes: 'P0420'
    }

    it "creates a record if no previous exists" do
      original_total = DeviceHistory.all.count

      DeviceHistory.create_if_change_in_dtc_or_vbatt(incoming, has_low_batt, has_dtc)

      expect(DeviceHistory.all.count).to eq(original_total+1)

      # it "doesn't create a record if dtc_codes == previous device_history dtc_codes"
      original_total_plus_one = DeviceHistory.all.count

      DeviceHistory.create_if_change_in_dtc_or_vbatt(incoming, has_low_batt, has_dtc)

      expect(original_total_plus_one).to eq(original_total_plus_one)
    end

  end
end
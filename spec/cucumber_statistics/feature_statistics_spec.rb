require 'spec_helper'

module CucumberStatistics
  describe FeatureStatistics do

    subject(:feature_statistics) { FeatureStatistics.new }
    subject(:overall_statistics) { OverallStatistics.new } #not sure if really need

    describe 'record' do
      it 'should create a record' do
        record 'my feature', 50, 'features/admin_cancel_account.feature'

        expect(feature_statistics.all.count).to eq 1
        expect(feature_statistics.all['features/admin_cancel_account.feature'][:duration]).to eq 50
      end

      it 'should support multiple scenarios with the same name' do
        record 'my feature', 50, 'admin_cancel_account.feature'
        record 'my feature', 75, 'noise/features/super_admin/admin_cancel_account.feature'

        expect(feature_statistics.all.count).to eq 2
        expect(feature_statistics.all['admin_cancel_account.feature'][:duration]).to eq 50
        expect(feature_statistics.all['features/super_admin/admin_cancel_account.feature'][:duration]).to eq 75
      end

      it 'chops off file path up to features/' do
        record 'my feature', 50, '/User/some/file/path/that/doesnt/matter really/features/admin_cancel_account.feature'
        expect(feature_statistics.all.keys.first).to eq 'features/admin_cancel_account.feature'
      end

      it 'uses the whole string if the filepath doesnt include the features folder' do
        record 'my feature', 50, 'admin_cancel_account.feature'
        expect(feature_statistics.all.keys.first).to eq 'admin_cancel_account.feature'
      end
    end

    describe 'all' do
      before(:each) do
        record 'my feature', 24, 'admin_cancel_account.feature'
        record 'my feature', 50, 'admin_edit_account.feature'
      end

      it 'should return all records' do
        expect(feature_statistics.all.count).to eq 2
        feature_statistics.all.each_with_index do |file_colon_line, data, index|
          case index
            when 1
              expect(file_colon_line).to eq 'admin_cancel_account.feature'
            when 2
              expect(file_colon_line).to eq 'admin_edit_account.feature'
          end
        end
      end
    end

    describe 'set operations' do
      before(:each) do
        record 'a', 25, 'admin_cancel_account.feature'
        record 'c', 51, 'view_account.feature'
        record 'b', 75, 'edit_account.feature'
      end

      describe 'sort_by_property' do
        context 'should sort all records by any property' do
          it { expect(feature_statistics.sort_by_property(:feature_name).first[0]).to eq 'admin_cancel_account.feature' }
          it { expect(feature_statistics.sort_by_property(:feature_name).last[0]).to eq 'view_account.feature' }

          it { expect(feature_statistics.sort_by_property(:duration).first[0]).to eq 'admin_cancel_account.feature' }
          it { expect(feature_statistics.sort_by_property(:duration).last[0]).to eq 'edit_account.feature' }
        end
      end
    end

    def record(feature_name, duration, file)
      feature_statistics.record feature_name, duration, file
    end
  end
end
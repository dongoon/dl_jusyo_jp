require 'spec_helper'
require 'active_record'
require 'csv'

require 'generators/dl_jusyo_jp/templates/initializers/dl_jusyo_jp'
require 'generators/dl_jusyo_jp/templates/migrations/create_jusyos'
require 'generators/dl_jusyo_jp/templates/models/jusyo_jp_address'

describe DlJusyoJp::Import do

  describe '::execute' do
    subject{ DlJusyoJp::Import.execute }

    before do
      ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => ':memory:')
      ActiveRecord::Migration.verbose = false
      allow(DlJusyoJp::Download).to receive(:csv).and_return(File.new(File.expand_path('../', __FILE__) + '/fixtures/address.csv'))
      allow(DlJusyoJp::Import).to receive(:chunk_size).and_return 10
      CreateJusyos.up
      expect(JusyoJpAddress.count).to eq 0
    end

    after do
      CreateJusyos.down
    end

    it 'should import all rows' do
      subject
      expect(JusyoJpAddress.count).to eq 29
    end

    it 'should bulk insert by chunk_size' do
      expect_any_instance_of(ActiveRecord::ConnectionAdapters::SQLite3Adapter).to receive(:exec_insert).exactly(3)
      subject
    end

    it 'should omit csv header row' do
      subject
      expect(JusyoJpAddress.pluck(:address_code).grep(/[^0-9]+/)).to be_blank
    end

    it 'should import all columns' do
      subject
      address = JusyoJpAddress.find_by_address_code '400004100' 
      expect(address.prefecture_code).to eq '19'
      expect(address.city_code).to eq '19201'
      expect(address.town_code).to eq '192010025'
      expect(address.zip_code).to eq '400-0041'
      expect(address.is_place).to eq '1'
      expect(address.is_deleted).to eq '0'
      expect(address.prefecture_name).to eq '山梨県'
      expect(address.prefecture_name_kana).to eq 'ヤマナシケン'
      expect(address.city_name).to eq '甲府市'
      expect(address.city_name_kana).to eq 'コウフシ'
      expect(address.town_name).to eq '上石田'
      expect(address.town_name_kana).to eq 'カミイシダ'
      expect(address.town_name_plus).to eq '町域補足確認'
      expect(address.kyoto_name).to eq '京都通り名確認'
      expect(address.town_detail).to eq '字丁目確認'
      expect(address.town_detail_kana).to eq 'アザチョウメカナカクニン'
      expect(address.memo).to eq '補足確認'
      expect(address.place_name).to eq '事業所名確認'
      expect(address.place_name_kana).to eq 'ジギョウショカナカクニン'
      expect(address.place_address).to eq '事業所住所確認'
      expect(address.new_address_code).to eq 'new_code_001'
    end
  end

  describe '::chunk_size (without stub)' do
    subject{ DlJusyoJp::Import.chunk_size }

    it{ is_expected.to eq 1000 }
  end
end

require 'spec_helper'
require 'csv'

describe DlJusyoJp::Download do

  describe '::csv (download & unzip)' do
    # テスト目的としてはダウンロードリンクの存在程度なので簡素に.
    subject{ DlJusyoJp::Download.csv }

    before do
      # 全国のDLが重いので、一番ファイルサイズの小さい山梨県を利用
      allow(DlJusyoJp::Download).to receive(:download_url).
                                     and_return('http://jusyo.jp/downloads/new/csv/csv_19yamana.zip')
    end

    it 'should download zip & extract. The extracted file is csv' do
      expect{ subject }.to_not raise_error
      header = CSV.read(subject.path, encoding: "Shift_JIS:UTF-8").first
      expect(header).to be_a Array
      expect(header[0]).to eq '住所CD'
    end
  end

  describe '::download_url (without stub)' do
    subject{ DlJusyoJp::Download.download_url }

    it{ is_expected.to eq 'http://jusyo.jp/downloads/new/csv/csv_zenkoku.zip' }
  end
end

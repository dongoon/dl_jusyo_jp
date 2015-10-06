module DlJusyoJp

  module Download
    require 'open-uri'
    require 'zip'

    def self.csv
      csv = Tempfile.new ['address', '.csv']

      Zip::File.open(download_zip.path) do |z|
        z.each do |entry|
          z.extract(entry, csv.path){ true }
        end
      end

      csv
    end

    def self.download_zip
      tmpfile = Tempfile.new ['address', '.zip']

      File.open(tmpfile.path, 'wb') do |local|
        open(download_url, 'rb') do |jusyo_jp|
          local.write(jusyo_jp.read)
        end
      end

      tmpfile
    end

    def self.download_url
      'http://jusyo.jp/downloads/new/csv/csv_zenkoku.zip'
    end
  end
end

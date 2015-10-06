module DlJusyoJp

  module Import
    require 'csv'

    def self.execute
      CSV.foreach(Download.csv.path, encoding: "Shift_JIS:UTF-8", write_headers: false).each_slice(chunk_size) do |rows|
        insert = "INSERT INTO #{DlJusyoJp::ADDRESS_DOWNLOAD_TABLE} VALUES "
        values = rows.map do |row|
          next unless row[0].match(/^\d+$/) # skip header
          '(NULL,' + row.map{|col| "'#{col}'"}.join(',') + ')'
        end.compact.join(',')
        ActiveRecord::Base.connection.exec_insert("#{insert}#{values}", 'jusyo.jp bulk insert', [])
      end
    end

    def self.chunk_size
      1000
    end
  end
end

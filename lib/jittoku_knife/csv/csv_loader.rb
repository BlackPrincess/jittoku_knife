require 'nkf'
require 'csv'

module JittokuKnife::CSV
  module CSVLoader
    CODES = {
      NKF::JIS      => "JIS",
      NKF::EUC      => "EUC",
      NKF::SJIS     => "SJIS",
      NKF::UTF8     => "UTF8",
      NKF::BINARY   => "BINARY",
      NKF::ASCII    => "ASCII",
      NKF::UNKNOWN  => "UNKNOWN",
    }

    def self.detect_encoding(path)
      begin
        f = File.open(path)
        NKF.guess(f.gets)
      ensure
        f.close
      end
    end

    def self.get_encoding_option(encoding)
      mode = 'r'
      int_enc = 'UTF-8'

      case encoding
        when NKF::SJIS
          "#{mode}:cp932:#{int_enc}"
        when NKF::EUC
          "#{mode}:EUC-JP:#{int_enc}"
        when NKF::JIS
          "#{mode}:ISO-2022-JP:#{int_enc}"
        when NKF::UTF8, NKF::ASCII
          "#{mode}:BOM|#{int_enc}"
        when NKF::BINARY, NKF::UNKNOWN
          raise UnsupportedEncodingException.new
      end
    end

    def self.using_csv(path, options: {undef: :replace, invalid: :replace, universal_newline: true}, csv_options: {:headers => :first_row}, &block)
      encoding = detect_encoding(path)
      enc_option = get_encoding_option(encoding)
      
      Kernel.open(path, enc_option, options) do |f|
        csv = CSV.new(f, csv_options)
        block.call(csv)
      end
    end
  end

  class UnsupportedEncodingException < Exception
  end
end
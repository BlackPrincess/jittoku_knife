require 'test_helper'
require 'tempfile'

module JittokuKnife::CSV
  class CSVLoaderTest < Test::Unit::TestCase
    def setup      
    end

    def teardown
    end

    def test_detect_encoding
      file = Tempfile.open('sjis') 
      file.puts('項目1,項目2,項目3'.encode(Encoding::SJIS))
      file.close
      assert_equal JittokuKnife::CSV::CSVLoader.detect_encoding(file.path), NKF::SJIS
      file.delete
    end

    def test_get_encoding_option
      assert_equal JittokuKnife::CSV::CSVLoader.get_encoding_option(NKF::UTF8), "r:BOM|UTF-8"
      assert_equal JittokuKnife::CSV::CSVLoader.get_encoding_option(NKF::SJIS), "r:cp932:UTF-8"
    end
    
    def test_using_csv
      [Encoding::SJIS, Encoding::UTF_8, Encoding::EUC_JP, Encoding::ISO_2022_JP].each do | enc |
        file = Tempfile.open(enc.to_s)
        file.puts '項目1,項目2,項目3'.encode(enc)
        file.puts 'データ1,データ2,データ3'.encode(enc)
        file.close      
  
        JittokuKnife::CSV::CSVLoader.using_csv(file.path, csv_options: {:headers => false}) do |csv|
          assert_equal csv.readline.first, '項目1'
        end
        file.delete
      end
    end
  end
end
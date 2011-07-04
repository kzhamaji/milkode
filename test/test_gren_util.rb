require 'test_helper'
require 'common/util'
require 'common/grensnip'

class TestGrenSnip < Test::Unit::TestCase
  def setup
  end
  
  def test_snip
    str = "abcdefghijkmlnopqrstuvwxyz"
    assert_equal(str, GrenSnip::snip(str, nil))

    str = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|12345678901234567890123456789012345678901234567890123456"
    assert_equal(str, GrenSnip::snip(str, nil))

    str = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234561"
    match_datas = []
    match_datas << str.match(/123456789\|/)
    assert_equal("12345678901234567890123456789012<<snip>>90123456789012345678901234567890123456789|123456789012345678901234567890123<<snip>>67890123456789012345678901234561", GrenSnip::snip(str, match_datas))

    str = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234561"
    match_datas = []
    match_datas << str.match(/123456789\|/)
    match_datas << str.match(/34567/)
    assert_equal("12345678901234567890123456789012<<snip>>90123456789012345678901234567890123456789|123456789012345678901234567890123<<snip>>67890123456789012345678901234561", GrenSnip::snip(str, match_datas))

    str = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789|123456789012345678901234567890123456789012345678901234561"
    match_datas = []
    match_datas << str.match(/123456789\|/)
    match_datas << str.match(/01234561/)
    assert_equal("12345678901234567890123456789012<<snip>>90123456789012345678901234567890123456789|123456789012345678901234567890123<<snip>>8901234567890123456789012345678901234561", GrenSnip::snip(str, match_datas))

  end
end
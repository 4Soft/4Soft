# -*- encoding : utf-8 -*-
require 'test_helper'

class MemberMailerTest < ActionMailer::TestCase
  test "tell_user" do
    mail = MemberMailer.tell_user
    assert_equal "Tell user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

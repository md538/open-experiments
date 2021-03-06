#!/usr/bin/env ruby

require 'sling/test'
require 'sling/search'
require 'test/unit.rb'
require 'test/unit/ui/console/testrunner.rb'
include SlingSearch

class TC_Kern254Test < SlingTest

  def test_modify_user_after_group_join
    u = create_user("testuser")
    g1 = create_group("g-testgroup")
    g1.add_member(@s, u.name, "user")
    g2 = create_group("g-testgroup2")
    g2.add_member(@s, u.name, "user")
    g2.add_member(@s, g1.name, "group")
    details = g2.details(@s)
    members = details["members"]
    assert_not_nil(members, "Expected a list of members")
    assert_equal(1, members.select{|m| m == "testuser"}.size, "Expected no dupes")
  end

end

Test::Unit::UI::Console::TestRunner.run(TC_Kern254Test)


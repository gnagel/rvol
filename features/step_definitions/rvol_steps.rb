#
#run rvol
#
Given /^I run: "([^"]*)"$/ do |arg1|
  @io = IO.popen(arg1)
  @io.each do |line|
    puts line
  end
end

Then /^I should see "([^"]*)"$/ do |arg1|


end

Then /^I should see: "([^"]*)"$/ do |arg1|
  @io.each { |line|

    if line.include? arg1
      break
    else
      flunk('nope didnt see that')
    end
  }

end

Then /^I should not see: "([^"]*)"$/ do |arg1|
  @io.each { |line|
    if line.include? arg1
      flunk('nope didnt see that')
    end
  }


@io.each { |line|
  puts line
  }
end

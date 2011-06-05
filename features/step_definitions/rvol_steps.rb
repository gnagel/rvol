Given /^I run rvol$/ do
  begin
  @test = %x{rvol}
  rescue
    flunk('not installed')
  end
end

Then /^I should see "([^"]*)"$/ do |arg1|
  if not @test.include? arg1
    flunk 'not working'
  end
end

Then /^I should not see "([^"]*)"$/ do |arg1|
    if @test.include? arg1
      flunk 'not working its not installed rvol!'
    end
end


Given /^I run "([^"]*)"$/ do |arg1|
   begin
  @test2 = %x{rvol -p}
  rescue
    flunk('not installed')
  end
end

Then /^I should see: "([^"]*)"$/ do |arg1|
  if not @test.include? arg1
    flunk 'not working'
  end
end


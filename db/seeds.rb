# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Project.create(:name => 'testproject01', :environment => 'stage').jmeter_runs.create(:description => 'first testrun', :jmx_source => 'http://here/is/my/code/1')
Project.first.jmeter_runs.create(:description => '2nd testrun', :jmx_source => 'http://here/is/my/code/1')
Project.first.jmeter_runs.create(:description => '3rd testrun', :jmx_source => 'http://here/is/my/code/1')
Project.create(:name => 'testproject02', :environment => 'stage').jmeter_runs.create(:description => 'second testrun', :jmx_source => 'http://here/is/my/code/2')
Project.create(:name => 'testproject03', :environment => 'live').jmeter_runs.create(:description => 'third testrun', :jmx_source => 'http://here/is/my/code/3')
Project.create(:name => 'testproject04', :environment => 'integration').jmeter_runs.create(:description => '4th testrun', :jmx_source => 'http://here/is/my/code/4')


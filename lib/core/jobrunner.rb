class JobRunner

#
# Class to run download jobs 
#
def jobThread
  while true
    puts "Started job at: #{Time.now}"
    sleep(60*60)
	begin
	runJob
	rescue
	puts 'jobfailed'
	end
  end
end

# set the jobs to run here
def runJob
puts 'job1'
puts 'job2'
asdsd
end
job = JobRunner.new
puts "Start at: #{Time.now}"
t1 = Thread.new{job.jobThread()}
t1.join
end



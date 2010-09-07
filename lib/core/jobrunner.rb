class JobRunner

#
# Class to run download jobs 
#
def jobThread
  while true
   
    sleep(60*60)
	begin
	runJob
	rescue
	
	end
  end
end

# set the jobs to run here
def runJob

asdsd
end
job = JobRunner.new

t1 = Thread.new{job.jobThread()}
t1.join
end



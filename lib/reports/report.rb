#
#Base class for reports
#
class Report
  # require all reports in the folder so they can be listed
  Dir.foreach(File.dirname(__FILE__)) do |file|

    if file =~ /.rb$/
      require File.join(File.dirname(__FILE__), file)
    end
  end

  #
  # Print all reports available
  #
  def printAllReports
    table = Table(%w[Report_Name Report_Description])
    reports = ObjectSpace.each_object(Class).select { |klass| klass.superclass == Report }
    reports.each do |report|
      begin
        reportti = Kernel.const_get(report.to_s).new
      rescue => e
        puts e
      end
      table << [report,reportti.printInfo]
    end
    print table
  end
  #
  # this method needs to be overriden. It will generate the report on screen.
  #
  def generateReport
    puts 'printing report base class this should be implemented in the report'
  end

  #
  # this method needs to be overriden. It will generate the report on screen.With args
  #
  def generateReportArgs(args)
    puts 'printing report with vars im not implemented'
    puts args
  end

  #
  # Used to print a genereic info of the report.
  #
  def printInfo
    puts 'this method should explain the report in plain english implement me'
  end


end

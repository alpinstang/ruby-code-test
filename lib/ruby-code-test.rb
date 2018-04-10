require 'ruby_code_test/version'
require 'sortable_hash'
require 'tsort'

# Code Test for MIME
module RubyCodeTest
  # Class for processing and sorting job lists per spec.
  class JobProcessor
    # Parses text input to hash.
    # Uses TSort to order dependencies ahead of jobs.
    # Raises custom errors if the job has a dependency upon itself or is cyclical
    def start(job_list)
      @sequence = ''
      @hash = TsortableHash.new { |hash, key| hash[key] = [] }

      @jobs = job_list.each_line.map do |j|
        job, dependency = j.split('=>').map { |s| s.strip! }
        if job == dependency
          raise SelfDependencyError.new
        else
          @hash[job] << dependency
        end
      end

      begin
        @array = @hash.tsort
      rescue Exception => e
        if e.class == TSort::Cyclic
          raise CircularDependencyError.new
        else
          raise StandardError.new
        end
      end

      @sequence = (@array.reject { |c| c.empty? }).join
    end
  end
end


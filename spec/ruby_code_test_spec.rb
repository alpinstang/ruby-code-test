require 'ruby-code-test'
require 'custom_errors'

RSpec.describe RubyCodeTest::JobProcessor do
  before(:each) do
    @job_processor = RubyCodeTest::JobProcessor.new
  end

  it 'has no jobs' do
    sequence = @job_processor.start ''
    expect(sequence).to eq('')
  end

  it 'has one job' do
    jobs = File.read(Dir.pwd + "/spec/test_files/one_job.txt")
    sequence = @job_processor.start jobs
    expect(sequence).to eq('a')
  end

  it 'has three jobs' do
    jobs = File.read(Dir.pwd + "/spec/test_files/three_jobs.txt")
    sequence = @job_processor.start jobs
    expect(sequence).to eq('abc')
  end

  it 'has three jobs one dependency' do
    jobs = File.read(Dir.pwd + "/spec/test_files/three_jobs_one_dependency.txt")
    sequence = @job_processor.start jobs
    expect(sequence).to eq('acb')
  end

  it 'has six jobs four dependencies' do
    jobs = File.read(Dir.pwd + "/spec/test_files/six_jobs_four_dependencies.txt")
    output = @job_processor.start jobs
    expect(output).to eq('afcbde')
  end

  it 'has three jobs with self dependency error' do
    jobs = File.read(Dir.pwd + "/spec/test_files/three_jobs_self_dependency_error.txt")
    expect{@job_processor.start jobs}.to raise_error(SelfDependencyError)
  end

  it 'has six jobs with circular dependency error' do
    jobs = File.read(Dir.pwd + "/spec/test_files/six_jobs_circular_dependency_error.txt")
    expect{@job_processor.start jobs}.to raise_error(CircularDependencyError)
  end

  it 'has a malformed job' do
    jobs = File.read(Dir.pwd + "/spec/test_files/malformed_job.txt")
    expect{@job_processor.start jobs}.to raise_error(StandardError)
  end

end

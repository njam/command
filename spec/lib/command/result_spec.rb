require 'spec_helper'

describe Command::Result do

  describe '#initialize' do
    let(:cmd) { 'my command' }
    let(:output) { {:stdout => 'my stdout', :stderr => 'my stderr'} }
    let(:status) { double(Process::Status, exitstatus: 12, success?: false, pid: 123) }
    let(:result) { Command::Result.new(cmd, output, status) }

    it 'sets the cmd' do
      expect(result.cmd).to eq(cmd)
    end

    it 'sets the output' do
      expect(result.stdout).to eq('my stdout')
      expect(result.stderr).to eq('my stderr')
    end

    it 'sets the status' do
      expect(result.exitstatus).to be(12)
    end
  end

  describe '#exitstatus' do
    let(:status) { double(Process::Status, exitstatus: 12) }
    let(:result) { Command::Result.new('my command', {}, status) }

    it 'returns the exit status' do
      expect(result.exitstatus).to eq(12)
      expect(result.status).to eq(12)
    end
  end

  describe '#success' do
    let(:status) { double(Process::Status, success?: false) }
    let(:result) { Command::Result.new('my command', {}, status) }

    it 'returns the success' do
      expect(result.success?).to eq(false)
    end
  end

  describe '#pid' do
    let(:status) { double(Process::Status, pid: 123) }
    let(:result) { Command::Result.new('my command', {}, status) }

    it 'returns the success' do
      expect(result.pid).to eq(123)
    end
  end

end
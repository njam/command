require 'spec_helper'

describe Command::Definition do

  describe '#run' do

    context 'when command exits successfully' do
      let(:cmd) { 'ruby -e "STDOUT.print \"hello\"; STDERR.print \"world\";"' }
      let(:definition) { Command::Definition.new(cmd) }
      let(:result) { definition.run }

      it 'returns a result' do
        expect(result).to be_a(Command::Result)
      end

      it 'sets the standard output' do
        expect(result.stdout).to eq('hello')
      end

      it 'sets the standard error' do
        expect(result.stderr).to eq('world')
      end

      it 'sets the exit status' do
        expect(result.exitstatus).to eq(0)
      end

      it 'sets the success' do
        expect(result.success?).to eq(true)
      end

      it 'sets the PID' do
        expect(result.pid).to be_a(Fixnum)
      end

      it 'sets the command' do
        expect(result.cmd).to eq(cmd)
      end
    end

    context 'when command fails' do
      let(:cmd) { 'ruby -e "STDOUT.print \"hello\"; STDERR.print \"world\"; exit(1);"' }
      let(:definition) { Command::Definition.new(cmd) }
      let(:result) { definition.run }

      it 'returns a result' do
        expect(result).to be_a(Command::Result)
      end

      it 'sets the standard output' do
        expect(result.stdout).to eq('hello')
      end

      it 'sets the standard error' do
        expect(result.stderr).to eq('world')
      end

      it 'sets the exit status' do
        expect(result.exitstatus).to eq(1)
      end

      it 'sets the success' do
        expect(result.success?).to eq(false)
      end
    end

  end
end
require_relative '../spec_helper'

describe ProxiClean::Client, :vcr do
  subject(:client) { described_class.new }
  let(:unproxied_ip_address) { '71.202.24.103' }

  describe '#public_ip' do
    it 'sets the correct unproxied IP address' do
      expect(subject.public_ip).to eq(unproxied_ip_address)
    end
  end

  describe '#works?' do
    let(:good_proxy) { 'https://124.88.67.13:843' }
    let(:bad_proxy) { 'http://el-oh-el-smiley-face.z:911' }

    context 'with a good proxy' do
      it 'returns true' do
        result = subject.works?(good_proxy)
        expect(result).to be(true)
      end
    end

    context 'with a bad proxy' do
      it 'returns false' do
        result = subject.works?(bad_proxy)
        expect(result).to be(false)
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe RepoSmallBadge::Image do
  include TestRepoSmallBadge::Mocks

  context '#coverage_total' do
    describe '#coverage' do
      it do
        mock_mini_magick(name: 'total', title: 'badge Total',
                         color: 'yellow', value: '100',
                         output_path: '.',
                         stack: mock_mini_magick_stack)
        expect(subject.badge('total', 'Total', 100, 'good'))
          .to be_truthy
      end

      context 'without rounded' do
        subject { described_class.new(rounded_border: false) }
        it do
          mock_mini_magick(name: 'total', title: 'badge Total',
                           color: 'yellow', value: '100',
                           rounded_border: false,
                           output_path: '.',
                           stack: mock_mini_magick_stack)
          expect(subject.badge('total', 'Total', 100, 'good')).to be_truthy
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe RepoSmallBadge::Image do
  include TestRepoSmallBadge

  context '#coverage_total' do
    describe '#coverage' do
      it do
        allow(File).to receive(:write)
          .with('./badge_total.svg', default_svg_string).and_return(true)
        expect(subject.badge('total', 'Total', '100%'))
          .to be_truthy
      end

      context 'without rounded and width 200 and title' do
        subject do
          described_class
            .new(badge_width: 200, rounded_border: false, title_prefix: 'badge')
        end

        it do
          allow(File).to receive(:write)
            .with('./badge_total.svg', not_rounded_svg_string).and_return(true)
          expect(subject.badge('total', 'Total', '100%')).to be_truthy
        end
      end

      context '#config_merge' do
        it do
          expect(subject.config_merge(badge_height: 10)[:badge_height]).to eq 10
        end
      end
    end
  end
end

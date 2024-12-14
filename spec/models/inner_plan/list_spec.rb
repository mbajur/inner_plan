# frozen_string_literal: true

require "rails_helper"

describe InnerPlan::List do
  subject { build(:list) }

  context "when sub" do
    subject { create(:list, list: parent) }

    let(:parent) { create(:list) }

    it "touches parent list" do
      parent.update!(updated_at: 1.year.ago)
      expect { subject }.to change { parent.reload.updated_at }
    end
  end
end

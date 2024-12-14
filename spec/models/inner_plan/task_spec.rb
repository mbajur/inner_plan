# frozen_string_literal: true

require "rails_helper"

describe InnerPlan::Task do
  subject { build(:task) }

  context "when belongs to root list" do
    subject { create(:task, list: list) }

    let(:list) { create(:list) }

    it "touches parent list" do
      list.update!(updated_at: 1.year.ago)
      expect { subject }.to change { list.reload.updated_at }
    end
  end

  context "when belongs to sub list" do
    subject { create(:task, list: list) }

    let(:root_list) { create(:list) }
    let(:list) { create(:list, list: root_list) }

    it "touches sub list" do
      list.update!(updated_at: 1.year.ago)
      expect { subject }.to change { list.reload.updated_at }
    end

    it "touches root list" do
      root_list.update!(updated_at: 1.year.ago)
      expect { subject }.to change { root_list.reload.updated_at }
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe InnerPlan::Search::Operation::Show do
  subject do
    described_class.call(current_user: user, params: { q: query })
  end

  let(:user) { create(:user) }
  let(:query) { 'bar' }

  let!(:task_foo) { create(:task, title: 'foo') }
  let!(:task_bar) { create(:task, title: 'bar') }
  let!(:task_baz) { create(:task, title: 'baz') }

  it 'searches tasks by query' do
    expect(subject[:results]).not_to include(task_foo)
    expect(subject[:results]).to include(task_bar)
    expect(subject[:results]).not_to include(task_baz)
  end

  context 'when just part of the title is provided' do
    let(:query) { 'ba' }

    it 'returns tasks with titles containing given string' do
      expect(subject[:results]).not_to include(task_foo)
      expect(subject[:results]).to include(task_bar)
      expect(subject[:results]).to include(task_baz)
    end
  end

  context 'when proper string is provided but letter sizes are wrong' do
    let(:query) { 'BaZ' }

    it 'returns tasks anyway' do
      expect(subject[:results]).not_to include(task_foo)
      expect(subject[:results]).not_to include(task_bar)
      expect(subject[:results]).to include(task_baz)
    end
  end
end

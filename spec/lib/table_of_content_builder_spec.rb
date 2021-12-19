require 'rails_helper'

RSpec.describe TableOfContentBuilder do
  let(:chapter1) { create(:post, published: true) }
  let(:chapter2) { create(:post, published: false) }
  let(:chapter3) { create(:post, published: true) }
  let(:section1) { 'section1' }
  let(:section2) { 'section2' }
  let(:parent_post) do
    create(:post, published: true).tap do |post|
      post.post_items.create!(chapter: chapter1, order: 3)
      post.post_items.create!(chapter: chapter2, order: 1)
      post.post_items.create!(section: section1, order: 0)
      post.post_items.create!(chapter: chapter3, order: 2)
      post.post_items.create!(section: section2, order: 4)
    end
  end
  let(:expected) do
    [
      { name: section1, type: :section },
      { id: chapter3.id, name: chapter3.title, slug: chapter3.slug, type: :post },
      { id: chapter1.id, name: chapter1.title, slug: chapter1.slug, type: :post },
      { name: section2, type: :section },
    ]
  end

  it 'builds ToC structure' do
    expect(described_class.new(parent_post).call).to eq(expected)
  end
end

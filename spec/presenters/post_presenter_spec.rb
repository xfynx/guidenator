require 'rails_helper'

RSpec.describe PostPresenter do
  let(:chapter) { create(:post, published: true) }
  let(:section) { 'section' }
  let(:parent_post) do
    create(:post, published: true).tap do |post|
      post.post_items.create!(chapter: chapter, order: 3)
      post.post_items.create!(section: section, order: 0)
    end
  end
  let(:expected_toc) do
    [
      { name: section, type: :section },
      { id: chapter.id, name: chapter.title, slug: chapter.slug, type: :post }
    ]
  end

  it 'builds result for parent_post' do
    expect(described_class.new(parent_post: parent_post).call).
      to eq({ body: parent_post.body, title: parent_post.title, toc: expected_toc })
  end

  it 'builds result for chapter_post' do
    expect(described_class.new(parent_post: parent_post, chapter_post: chapter).call).
      to eq({ body: chapter.body, title: chapter.title, toc: expected_toc })
  end
end

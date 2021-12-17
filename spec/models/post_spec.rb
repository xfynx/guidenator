require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it 'is not valid without title set' do
      expect(build(:post, title: nil)).to_not be_valid
    end

    it 'is not valid without body set' do
      expect(build(:post, body: nil)).to_not be_valid
    end

    it 'is not valid if new title is not unique' do
      title = 'asd'
      create(:post, title: title)
      expect(build(:post, title: title)).to_not be_valid
    end

    it 'is not valid if new slug is not unique' do
      slug = 'asd'
      create(:post, slug: slug)
      expect(build(:post, slug: slug)).to_not be_valid
    end

    it 'is not valid if we have collision bw slug and some path' do
      expect(build(:post, slug: 'example')).to_not be_valid
    end

    it 'is valid' do
      expect(build(:post)).to be_valid
    end
  end

  context 'relations' do
    let(:parent_post) { create(:post) }
    let(:chapter) { create(:post) }

    before do
      parent_post.post_items.create(chapter: chapter, order: 2)
      parent_post.post_items.create(chapter: create(:post), order: 3)
      parent_post.post_items.create(section: 'some-section', order: 1)
    end

    it 'returns all post_items with section only' do
      expect(parent_post.sections.pluck(:order)).to eq([1])
    end

    it 'returns all related chapters which is related posts' do
      expect(parent_post.chapters.pluck(:order)).to eq([2, 3])
    end

    it 'returns all post_items' do
      expect(parent_post.post_items.pluck(:order)).to eq([2, 3, 1])
    end

    it 'returns parent for chapter post' do
      expect(chapter.parent_post).to eq(parent_post)
      expect(parent_post.parent_post).to be_nil
    end
  end

  context 'slug from title' do
    let(:post_with_title) { create(:post, title: 'Some Title Name 321 exAmple') }
    let(:post_with_slug) { create(:post, title: 'Some Title', slug: 'but i want this TO BE 123 slug') }
    let(:slug_from_title) { 'some-title-name-321-example' }
    let(:slug_given) { 'but-i-want-this-to-be-123-slug' }

    it 'creates slug from title' do
      expect(post_with_title.slug).to eq(slug_from_title)
    end

    it 'uses given slug name' do
      expect(post_with_slug.slug).to eq(slug_given)
    end

    it 'keeps slug name on updates if no new slug given' do
      post_with_title.update(title: 'i want this new title')
      expect(post_with_title.slug).to eq(slug_from_title)
    end

    it 'updates slug if new given' do
      post_with_slug.update(slug: 'wanna new sluGG!')
      expect(post_with_slug.slug).to eq('wanna-new-slugg')
    end
  end

  describe '#parent_post?' do
    let(:parent) { create(:post).tap{|p| p.post_items.create(section: '123', order: 1)} }
    let(:chapter) { create(:post) }

    it 'returns true if at least one post_item present' do
      expect(parent.parent?).to be_truthy
      expect(chapter.parent?).to be_falsey
    end
  end
end

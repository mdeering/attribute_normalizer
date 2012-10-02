require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Article do
  it { should normalize_attribute(:title).from(' Social Life at the Edge of Chaos    ').to('Social Life at the Edge of Chaos') }
  it { should normalize_attribute(:slug) }
  it { should normalize_attribute(:slug).from(' Social Life at the Edge of Chaos    ').to('social-life-at-the-edge-of-chaos') }
  it { should normalize_attribute(:limited_slug) }
  it { should normalize_attribute(:limited_slug).from(' Social Life at the Edge of Chaos    ').to('social-life') }

  context 'normalization should not interfere with other hooks and aliases on the attribute assignment' do
    before do
      @article = Article.create!(:title => 'Original Title')
    end

    it 'should still reflect that the attribute has been changed through the call to super' do
      lambda { @article.title = 'New Title' }.should change(@article, :title_changed?).from(false).to(true)
    end
  end

  context 'when another instance of the same saved record has been changed' do
    before do
      @article = Article.create!(:title => 'Original Title')
      @article2 = Article.find(@article.id)
      @article2.update_attributes(:title => 'New Title')
    end

    it "should reflect the change when the record is reloaded" do
      lambda { @article.reload }.should change(@article, :title).from('Original Title').to('New Title')
    end
  end

  context 'normalization should work with multiple attributes at the same time' do
    before do
      @article = Article.new(:slug => '  Bad Slug   ', :limited_slug => '   Bad Limited Slug   ')
    end

    it "should apply normalizations to both attributes" do
      @article.slug.should == 'bad-slug'
      @article.limited_slug.should == 'bad-limited'
    end
  end

end

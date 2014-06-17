require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Article do
  it { should normalize_attribute(:title).from(' Social Life at the Edge of Chaos    ').to('Social Life at the Edge of Chaos') }
  it { should normalize_attribute(:authors).from(' Octavio Miramontes and Pedro Miramontes ').to('Octavio Miramontes and Pedro Miramontes') }
  it { should normalize_attribute(:slug) }
  it { should normalize_attribute(:slug).from(' Social Life at the Edge of Chaos    ').to('social-life-at-the-edge-of-chaos') }
  it { should normalize_attribute(:limited_slug) }
  it { should normalize_attribute(:limited_slug).from(' Social Life at the Edge of Chaos    ').to('social-life') }

  context 'normalization should not interfere with other hooks and aliases on the attribute assignment' do
    before do
      @article = Article.create!(:title => 'Original Title')
    end

    it 'should still reflect that the attribute has been changed through the call to super' do
      expect{ @article.title = 'New Title' }.to change(@article, :title).from('Original Title').to('New Title')
    end
  end

  context 'when another instance of the same saved record has been changed' do
    before do
      @article = Article.create!(:title => 'Original Title')
      @article2 = Article.find(@article.id)
      @article2.update_attributes(:title => 'New Title')
    end

    it "should reflect the change when the record is reloaded" do
      expect{ @article.reload }.to change(@article, :title).from('Original Title').to('New Title')
    end
  end

  context 'normalization should work with multiple attributes at the same time' do
    before do
      @article = Article.new(:title => '  Bad Title   ', :authors => '   Bad Authors   ')
    end

    it "should apply normalizations to both attributes" do
      expect(@article.title).to  eq('Bad Title')
      expect(@article.authors).to eq('Bad Authors')
    end
  end

  context 'with the default normalizer changed' do
    it "only strips leading and trailing whitespace" do
      @book = Book.new :author => ' testing the default normalizer '
      expect(@book.author).to eq('testing the default normalizer')
    end
  end

end

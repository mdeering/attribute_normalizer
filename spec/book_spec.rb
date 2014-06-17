require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Book do

  it { should normalize_attribute(:author).from(' Michael Deering ').to('Michael Deering') }

  it { should normalize_attribute(:us_price).from('$3.50').to(3.50) }
  it { should normalize_attribute(:cnd_price).from('$3,450.98').to(3450.98) }

  it { should normalize_attribute(:summary).from('    Here is my summary that is a little to long  ').to('Here is m...') }

  it { should normalize_attribute(:title).from('pick up chicks with magic tricks').to('Pick Up Chicks With Magic Tricks') }

  context 'normalization should not interfere with other hooks and aliases on the attribute assignment' do
    before do
      @book = Book.create!(:title => 'Original Title')
    end

    it 'should still reflect that the attribute has been changed through the call to super' do
      expect { @book.title = 'New Title' }.to change(@book, :title_changed?).from(false).to(true)
    end
  end

  context 'when another instance of the same saved record has been changed' do
    before do
      @book = Book.create!(:title => 'Original Title')
      @book2 = Book.find(@book.id)
      @book2.update_attributes(:title => 'New Title')
    end

    it "should reflect the change when the record is reloaded" do
      expect { @book.reload }.to change(@book, :title).from('Original Title').to('New Title')
    end
  end

  context 'normalization should work with multiple attributes at the same time' do
    before do
      @book = Book.new(:title => '  Bad Title   ', :author => '   Bad Author   ')
    end

    it "should apply normalizations to both attributes" do
      expect(@book.title).to eq('Bad Title')
      expect(@book.author).to eq('Bad Author')
    end
  end

  context 'with the default normalizer changed' do
    it "only strips leading and trailing whitespace" do
      @book = Book.new :author => ' testing the default normalizer '
      expect(@book.author).to eq('testing the default normalizer')
    end
  end

end

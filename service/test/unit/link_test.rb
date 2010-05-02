require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :tags

  context 'A link' do
    #should_validate_presence_of :url
    setup do
      @link = Link.new(:url => 'http://www.test.de/',
                       :notes => 'Notizen',
                       :title => 'Test.de')
    end
    
    should 'have a maximum url length of 250 characters' do
      @link.url = 'x' * 250
      assert_valid @link
      @link.url = 'x' * 251
      assert !@link.valid?
    end  
    should 'have a maximum title length of 250 characters' do
        @link.title = 'x' * 250
        assert_valid @link
        @link.title = 'x' * 251
        assert !@link.valid?
      end
    should 'have a maximum notes length of 1000 characters' do
      @link.notes = 'x' * 1000
      assert_valid @link
      @link.notes = 'x' * 1001
      assert !@link.valid?
    end
    should 'not allow an empty url' do
      @link.url = ''
      assert !@link.valid?
      @link.url = nil
      assert !@link.valid?
    end
    should 'allow an empty title' do
      @link.title = ''
      assert_valid @link
      @link.title = nil
      assert_valid @link
    end
    should 'allow empty notes' do
      @link.notes = ''
      assert_valid @link
      @link.notes = nil
      assert_valid @link
    end
    # TODO: Validate URL
    # TODO: Test created_at, updated_at
  end
end

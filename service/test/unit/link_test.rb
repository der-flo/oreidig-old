require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :tags

  context 'A link' do
    subject { @link }

    #should_validate_presence_of :url
    
    setup do
      @link = Link.new(:url => 'http://www.test.de/',
                       :notes => 'Notizen',
                       :title => 'Test.de')
    end

    [ 'ftp://www.test.de', 'bla://www.test.de'
    ].each do |str|
      should_not_allow_values_for :url, str
    end
    [ 'http://www.test.de', 'https://www.test.de', 'www.test125.de', 'bla'
    ].each do |str|
      should_allow_values_for :url, str
    end

    should 'have a maximum url length of 500 characters' do
      @link.url = 'http://www.test.de/' + 'x' * 481
      assert_valid @link
      @link.url = 'http://www.test.de/' + 'x' * 482
      assert !@link.valid?
    end  
    should 'have a maximum title length of 250 characters' do
        @link.title = 'x' * 250
        assert_valid @link
        @link.title = 'x' * 251
        assert !@link.valid?
      end
    should 'have a maximum notes length of 5000 characters' do
      @link.notes = 'x' * 5000
      assert_valid @link
      @link.notes = 'x' * 5001
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

    # TODO: tag_list= handles tags quite well
    # TODO: Test created_at, updated_at
  end
end

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :links

  context 'A tag' do
    setup do
      @tag = Tag.new
    end
    should 'have a maximum name length of 100 characters' do
      @tag.name = 'x' * 100
      assert_valid @tag
      @tag.name = 'x' * 101
      assert !@tag.valid?
    end
    should 'not allow an empty name' do
      @tag.name = ''
      assert !@tag.valid?
      @tag.name = nil
      assert !@tag.valid?
    end
    should 'use its name as URL parameter' do
      tag = Factory(:link).tags.first
      assert_equal tag.to_param, tag.name
    end
  end
end

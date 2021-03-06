require 'test_helper'

class TagsControllerTest < ActionController::TestCase

  context 'a TagsController' do
    setup do
      @link = Factory(:link)
    end
  
    context 'on JSON-GET to :index' do
      setup do
        get :index, :format => :json
      end
  
      should_respond_with :success
  
      should 'return valid JSON' do
        assert_nothing_raised do
          json = JSON.parse(@response.body)
        end
      end
    
      context 'with valid JSON' do
        setup do
          @json = JSON.parse(@response.body)
        end
        should 'return two tags' do
          assert_equal @json.length, 2
          @json.each do |tag|
            tag.each do |key, value|
              assert key, :tag
              value.assert_valid_keys 'name', 'id', 'usage_count'
            end
          end
        end
      end
    end
  
    context 'on JSON-GET to :show' do
      setup do
        @tag = @link.tags.first
        get :show, :format => :json, :id => @tag.name
      end
    
      should 'return valid JSON' do
        assert_nothing_raised do
          json = JSON.parse(@response.body)
        end
      end
  
      context 'with valid JSON' do
        setup do
          @json = JSON.parse(@response.body)
        end
        should 'return a valid tag' do
          @json['tag'].assert_valid_keys 'name', 'usage_count'
        end
        should 'return the right attributes' do
          link = @json['tag']
          assert_equal link['name'], 'test'
          assert_equal link['usage_count'], 1
        end
      end
    end
    
    context 'on PUT' do
      # TODO: More tests!
      should 'update tag' do
        @tag = Factory(:tag)
        params = {
          :format => :json,
          :id => @tag.name,
          :tag => {
            :name => '12345'
          }
        }
        put :update, params
        assert_equal Tag.find_by_name!('12345').id, @tag.id
      end
    end
  end
end

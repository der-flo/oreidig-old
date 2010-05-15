require 'test_helper'

class AssociatedControllerTest < ActionController::TestCase

  context 'test' do
    
    setup do
      @link = Factory(:link)
      @tag_name = @link.tags.first.name
      Factory(:link, :tag_list => 'test, code, code2',
              :url => 'http://github2.com')
    end

    should 'be routed from /tags/test/associated' do
      assert_routing({ :method => :get,
                       :path => "/tags/#{@tag_name}/associated" },
                     { :controller => 'associated', :action => 'show',
                       :tag_id => 'test' })
    end
    
    context 'with a result' do
      setup do
        get :show, :tag_id => @tag_name
      end
      should_respond_with :success

      should 'have 2 associated tags' do
        json = JSON.parse(@response.body)

        # puts json.to_yaml

        assert_equal json.length, 2
        json.each do |tag|
          tag.each do |key, value|
            assert key, :tag
            value.assert_valid_keys 'name', 'id', 'usage_count'
          end
        end
      end
    end
  end
end
# TODO: Better tests

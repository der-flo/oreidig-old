require 'test_helper'

class LinksControllerTest < ActionController::TestCase

  should 'redirect to homepage if request is not JSON' do
    get :index
    assert_redirected_to root_url
    get :index, :format => :html
    assert_redirected_to root_url
    get :index, :format => :xml
    assert_redirected_to root_url
  end

  context 'on JSON-GET to :index' do
    setup do
      Factory(:link)
      Factory(:link, :url => 'http://www.test555.de')
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
      should 'return two links' do
        assert_equal @json.length, 2
        @json.each do |link|
          link.each do |key, value|
            assert key, :link
            value.assert_valid_keys 'title', 'tags', 'url', 'id', 'notes'
          end
        end
      end
    end
  end
  
  context 'on JSON-GET to :show' do
    setup do
      @link = Factory(:link)
      get :show, :format => :json, :id => @link.id
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
      should 'return a valid link' do
        @json['link'].assert_valid_keys 'title', 'tags', 'url', 'id', 'notes'
      end
      should 'return the right attributes' do
        link = @json['link']
        assert_equal link['url'], @link.url
        assert_equal link['title'], @link.title
        assert_equal link['tags'], @link.tag_names
        assert_equal link['notes'], @link.notes
      end
    end
  end
  
  # TODO: Stubbing:
  #       http://dev.thoughtbot.com/shoulda/classes/Shoulda/ClassMethods.html
  #       example at #before_should
  # TODO: Stub like this? http://railsforum.com/viewtopic.php?id=37787
end

# http://guides.rubyonrails.org/testing.html

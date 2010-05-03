require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  
  should 'be routed from /search' do
    assert_routing({ :method => :post, :path => '/search' },
                   { :controller => 'searches', :action => 'create' })
  end

  context 'with a test search' do
    setup do
      
      Factory(:link)
      @link = Factory(:link, :url => 'http://www.test555.de')
      @tag = Tag.find_by_name 'test'
      post :create, :format => :json, :q => 'test'
    end
    should 'return valid JSON' do
      assert_nothing_raised do
        json = JSON.parse(@response.body)
      end
    end

    context 'with valid JSON' do
      setup do
        @json = JSON.parse(@response.body)
        @result = @json['result']
      end
      should 'have a result' do
        assert @result
      end
      should 'have a tag list' do
        assert @result['tags']
      end
      should 'have a link list' do
        assert @result['links']
      end
      should 'find first link' do
        assert @result['links'].length > 0 
        @result['links'].each do |obj|
          link = obj['link']
          link.assert_valid_keys 'title', 'tags', 'url', 'id', 'notes'
          assert_equal link['url'], @link.url
          assert_equal link['title'], @link.title
          assert_equal link['tags'], @link.tag_names
          assert_equal link['notes'], @link.notes
        end
      end
      should 'find first tag' do
        assert @result['tags'].length > 0 
        @result['tags'].each do |obj|
          tag = obj['tag']
          tag.assert_valid_keys 'name', 'usage_count'
          assert_equal tag['name'], @tag.name
          assert_equal tag['usage_count'], @tag.usage_count
        end
      end
    end
  end
  
  def find_by x
    @link = Factory(:link, x.to_sym => x.to_s)
    post :create, :format => :json, :q => x.to_s
    json = JSON.parse(@response.body)
    links = json['result']['links']
    assert links.length > 0
    assert_equal @link.id, links.first['link']['id']
  end
  
  should 'find link by title' do
    find_by :title
  end
  should 'find link by notes' do
    find_by :notes
  end
  should 'find link by url' do
    find_by :url
  end
end

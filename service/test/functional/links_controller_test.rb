require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  
  context 'on GET to :index' do
    setup do
      get :index
    end
    should_respond_with :success
  end
  
  # TODO: If response has type HTML, then redirect to a start page
  # TODO: Validate JSON response
  # TODO: Stub like this? http://railsforum.com/viewtopic.php?id=37787
end

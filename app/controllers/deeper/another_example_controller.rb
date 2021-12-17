module Deeper
  class AnotherExampleController < ApplicationController
    def index
      render plain: 'another example'
    end
  end
end

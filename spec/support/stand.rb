module StandMatcher
  class Stand

    def matches?(thing_that_should_stand)
      @thing_that_should_stand = thing_that_should_stand
      @thing_that_should_stand.stand?
    end    

    def failure_message
      "#{@thing_that_should_stand.class.name} should stand"
    end

    def negative_failure_message
      "#{@authoritive_object.class.name} should not stand"
    end
    
  end

  def stand
    Stand.new
  end
end
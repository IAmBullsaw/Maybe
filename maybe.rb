class Maybe
  @@maybes = 0
  
  def initialize trueP=0.5
    if trueP.is_a?(Numeric) && trueP >= 0.0 && trueP <= 1.0 then
      @mid = trueP
    else
      raise ArgumentError ,"#{trueP} is not a valid Numeric!"
    end
    @maybe = self.maybe?
  end
  ##
  # Following are the class methods.
  ##
  def Maybe.maybe? &block
    @@maybes += 1

    n = rand    
    while n == 0.5 do
      n = rand
    end
    
    tof = false
    if n > 0.5 then
      tof = true
    else
      tof = false
    end

    if block_given?
      yield(tof, !tof)
    end
    
    tof
  end

  def Maybe.do(&block)
    yield if Maybe.maybe?
  end

  def Maybe.dont(&block)
    yield unless Maybe.maybe?
  end
  
  def Maybe.false?
    Maybe.maybe? == false
  end
  
  def Maybe.true?
    Maybe.maybe?
  end

  def Maybe.uncertain?
    @@maybes
  end
  ##
  # Following are instance methods.
  ##
  def update! truthP=nil
    if !truthP.nil? then
      self.truthPercent=truthP
    end
    @maybe = self.maybe?
  end
  
  def update? truthP=nil
    m = Maybe.new
    if !truthP.nil? && m.true? then
      self.truthPercent=truthP
      @maybe = self.maybe?
    elsif m.true?
      @maybe = self.maybe?
    end
  end

  def reset!
    @mid = 0.5
  end

  def reset?
    @mid = 0.5 if self.maybe?
  end

  def Maybe.reset!
    @@maybes = 0
  end
  
  def truthPercent= number    
    if number.is_a?(Numeric) && number >= 0.0 && number <= 1.0 then
      @mid = number
    else
      raise ArgumentError,"#{number} is not a valid Numeric!"
    end
  end

  def falsePercent= number
    raise ArgumentError,"#{number} is not a valid Numeric!" unless number.is_a?(Numeric)
    truth = 1.0 - number
    self.truthPercent=(truth)
  end
  
  def true? &block
    if block_given?
      yield(@maybe)
    end
    return @maybe
  end
  
  def false? &block
    if block_given?
      yield(@maybe == false)
    end
    return @maybe == false
  end

  def maybe? &block
    @@maybes += 1
    
    n = rand(0.0..1.0)    
    while n == @mid do
      n = rand(0.0..1.0)
    end
    
    if n < @mid then
      tof = true
    else
      tof = false
    end

    if block_given? then
      yield(tof, @maybe)
    end
    
    return tof
  end
  ##
  # Following are the comparing functions
  ##
  def and? bool
    return ( @maybe && bool.true? ) if bool.is_a?(Maybe)
    return ( @maybe && bool )
  end

  def or? bool
    return ( @maybe || bool.true? ) if bool.is_a?(Maybe)
    return ( @maybe || bool )
  end

  def not? bool
    return ( @maybe != bool.true? ) if bool.is_a?(Maybe)
    return ( @maybe != bool )
  end

  def same? other
    raise ArgumentError, "rhs is not a :Maybe" unless other.is_a?(Maybe)
    same = true
    same = false if @maybe != other.true?
    same = false if @mid != other.chance
    same
  end
  
  def ==(bool)
    return ( @maybe == bool.true? ) if bool.is_a?(Maybe)
    return ( @maybe == bool )
  end

  def !=(bool)
    return ( @maybe != bool.true? ) if bool.is_a?(Maybe)
    return ( @maybe != bool )
  end
  ##
  # Other instance methods ...
  ##
  def uncertain?
    @@maybes
  end

  def areYouSure?
    puts "About #{@mid*100}% sure."
    @mid
  end

  def chance
    @mid
  end

  def risk
    1-@mid
  end
  
  def to_s
    "#{@maybe}"
  end

  def to_i
    num = 1 if self.true?
    num ||= 0
  end

  def inspect
    "I'm maybe #{@maybe}. Trust me #{@mid*100}% of the time."
  end

  ##
  # This apparently comes down to roughly a chance of
  # 1/3 getting true,false or nil...
  ##
  
  def wtf?
    wtf = self.maybe?
    aFactor = 0
    done = 10
    while(done != 0) do
      done +=1 if done == rand(0..10) unless Maybe.maybe?
      
      wtf = self.maybe? unless Maybe.maybe? == self.maybe?
      wtf ||= self.maybe?
      if wtf == Maybe.maybe? then
        wtf = !wtf unless @maybe
      elsif @maybe != Maybe.maybe? then
        a = Maybe.new
        wtf = a.true? unless wtf == a.true?
      end
      
      if !wtf && !@maybe then
        n = rand
        wtf = self.wtf? if ( done == rand(0..10) && done == rand(0..10) )
        wtf = !Maybe.maybe? if (n > 0.3 && n < 0.4)
        wtf = !wtf if wtf == self.maybe?
        wtf = nil unless !self.maybe?
      end
      
      wtf ||= Maybe.maybe?
      wtf = !wtf if (Maybe.maybe? && self.maybe?)

      done -= 1 unless Maybe.maybe?
      aFactor += done unless wtf
      aFactor -= done if wtf
      aFactor += rand( 0..( rand(0..11) ) )
    end

    choices = Array.new
    (1..10).each do 
      choices << wtf if Maybe.maybe?
      choices << !wtf if Maybe.maybe?
      choices << @maybe if Maybe.maybe?      
      choices << !@maybe if Maybe.maybe?
    end

    choice = rand(0..(choices.size))
    choice *= aFactor
    while choice > choices.size
      choice /= choices.size
    end
    choice += choices.size/2 if Maybe.maybe?
    return choices.at( -choice )
  end
end


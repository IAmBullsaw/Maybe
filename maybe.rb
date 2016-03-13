class Maybe
  @@maybes = 0

  def self.maybe? &block
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
    
    return tof
  end
  
  def self.false?
    @@maybes += 1
    self.maybe? == false
  end
  
  def self.true?
    @@maybes += 1
    self.maybe? == true
  end
  
  def initialize
    @mid = 0.5
    @maybe = Maybe.maybe?
  end
  
  def update!
    @maybe = self.maybe?
  end
  
  def update?
    @maybe = self.maybe? if self.maybe?
  end

  def reset!
    @mid = 0.5
  end

  def reset?
    @mid = 0.5 if self.maybe?
  end

  def self.reset!
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
      yield(@maybe)
    end
    return @maybe == false
  end

  def maybe? &block
    @@maybes += 1
    
    n = rand    
    while n == @mid do
      n = rand
    end
    
    if n > @mid then
      tof = true
    else
      tof = false
    end

    if block_given? && @maybe then
      yield(@maybe,tof)
    end
    
    return tof
  end

  def and? bool
    @maybe && bool
  end

  def or? bool
    @maybe || bool
  end

  def not? bool
    if @maybe !=bool
      return true
    else
      return false
    end
  end

  def ==(bool)
    @maybe == bool
  end

  def !=(bool)
    @maybe != bool
  end

  def self.uncertain?
    puts "#{@@maybes} Maybe's."
    return @@maybes
  end

  def uncertain?
    self.uncertain?
  end

  def areYouSure?
    puts "About #{@mid*100}% sure."
    @mid
  end

  def to_s
    "#{@maybe}"
  end

  def inspect
    "I'm maybe #{@maybe}. Trust me #{@mid*100}% of the time."
  end

  def wtf?
    wtf = self.maybe?
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
      
    end
    wtf unless @maybe
  end  
end


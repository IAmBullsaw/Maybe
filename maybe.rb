class Maybe
  @@maybes = 0
  
  def initialize
    @mid = 0.5
    @bool = Maybe.maybe?
  end
  
  def update!
    @bool = self.maybe?
  end
  
  def update?
    @bool = self.maybe? if self.maybe?
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
  
  def self.maybe?
    @@maybes += 1
    n = rand    
    while n == 0.5 do
      n = rand
    end

    if n > 0.5 then
      return true
    else
      return false
    end
    
  end
  
  def self.false?
    @@maybes += 1
    self.maybe? == false
  end
  
  def self.true?
    @@maybes += 1
    self.maybe? == true
  end
  
  def true? &block
    @@maybes += 1
    if block_given?
      yield(@bool)
    end
    return @bool == true
  end
  
  def false? &block
    @@maybes += 1
    if block_given?
      yield(@bool)
    end
    @bool == false
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

    if block_given? && @bool then
      yield(@bool,tof)
    end
    
    return tof
  end

  def and? bool
    @@maybes += 1
    @bool && bool
  end

  def or? bool
    @@maybes += 1
    @bool || bool
  end

  def not? bool
    @@maybes += 1
    if @bool !=bool
      return true
    else
      return false
    end
  end

  def ==(bool)
    @@maybes += 1
    @bool == bool
  end

  def !=(bool)
    @@maybes += 1
    @bool != bool
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
    "#{@bool}"
  end

  def inspect
    "I'm maybe #{Maybe.maybe?}. n Maybe's? #{@@maybes}. Trust me #{@mid*100}% of the time."
  end

  def wtf?
    wtf = self.maybe?
    done = 10
    while(done != 0) do
      done +=1 if done == rand(0..10) unless Maybe.maybe?
      
      wtf = self.maybe? unless Maybe.maybe? == self.maybe?
      wtf ||= self.maybe?
      if wtf == Maybe.maybe? then
        wtf = !wtf unless @bool
      elsif @bool != Maybe.maybe? then
        a = Maybe.new
        wtf = a.true?
      end
      
      if !wtf && !@bool then
        n = rand
        wtf = self.wtf? if done == 3 
        wtf = !Maybe.maybe? if (n > 0.3 && n < 0.4)
        wtf = !wtf if wtf == self.maybe?
        wtf = nil unless !self.maybe?
      end
      
      wtf ||= Maybe.maybe?
      wtf = !wtf if (Maybe.maybe? && self.maybe?)

      done -= 1 unless Maybe.maybe?
      
    end
    wtf
  end
  
end

test = Maybe.new
puts test.wtf?
puts test.inspect

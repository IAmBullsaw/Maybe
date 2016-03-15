
require 'test/unit'

class MaybeTester < Test::Unit::TestCase
  require './maybe'

  def test_Basic
    assert_nothing_thrown { $t = Maybe.new }
    #Defeating the class's purpose by assuring that we get a true one...
    while !$t.true? 
      $t.update! #Obviously this requires that update actually updates it...
    end
    assert_equal(true,$t.true?)
    assert_equal(false,$t.false?)
  end
  
  def test_Truth
    assert_nothing_thrown() { $t = Maybe.new }
    assert_equal(0.5, $t.chance )
    ##
    #Is it close to a chance of 0.5 to get a true?
    ##
    truths = 0
    (1..500000).each do
      truths +=1 if $t.true?
      $t.update!
    end
    percent = truths/500000.0
    assert_equal(0.5,percent.round(2) )
    ##
    #Is it close to a chance of 0.5 to get a false?
    ##
    falses = 0
    $t.update!
    (1..500000).each do
      falses +=1 if $t.false?
      $t.update!
    end
    percent = falses/500000.0
    assert_equal(0.5,percent.round(2) )
    ##
    #Changing the truthPercent to 0.7
    ##
    $t.truthPercent=0.7
    assert_equal(0.7, $t.chance )
    $t.update!
    truths = 0
    (1..500000).each do
      truths +=1 if $t.true?
      $t.update!
    end
    percent = truths/500000.0
    
    assert_equal(0.7,percent.round(2) )
    ##
    #How about the falses now??
    ##
    falses = 0
    $t.update!
    (1..500000).each do
      falses +=1 if $t.false?
      $t.update!
    end
    percent = falses/500000.0
    assert_equal(0.3,percent.round(2) )

    ##
    #Changing the falsePercent to 0.7
    ##
    $t.falsePercent=0.7
    assert_equal(0.7, $t.risk )
    $t.update!
    truths = 0
    (1..500000).each do
      truths +=1 if $t.true?
      $t.update!
    end
    percent = truths/500000.0
    
    assert_equal(0.3,percent.round(2) )
    ##
    #Now give me 0.7 falses!
    ##
    falses = 0
    $t.update!
    (1..500000).each do
      falses +=1 if $t.false?
      $t.update!
    end
    percent = falses/500000.0
    assert_equal(0.7,percent.round(2) )

    ##
    #Testing resetting the truthPercent
    #It should be 0.5 again
    ##
    $t.reset!

    truths = 0
    (1..500000).each do
      truths +=1 if $t.true?
      $t.update!
    end
    percent = truths/500000.0
    assert_equal(0.5,percent.round(2) )
  end

  def test_InstanceMethods
    $t=Maybe.new 1.0
    assert_equal(true,  $t.true?)
    assert_equal(false, $t.false?)
    assert_equal(true,  $t.and?(true) )
    assert_equal(false, $t.and?(false) )    
    assert_equal(true,  $t.or?(true) )
    assert_equal(true,  $t.or?(false) )    
    assert_equal(true,  $t.not?(false) )
    assert_equal(false, $t.not?(true) )
    assert_equal(true,  $t == true )
    assert_equal(false, $t == false )
    assert_equal(true,  $t != false )
    assert_equal(false, $t != true )
  end

  def test_Crash    
    assert_raise(ArgumentError) { Maybe.new 1.2 }
    assert_raise(ArgumentError) { Maybe.new -0.5 }
    assert_raise(ArgumentError) { Maybe.new (0.0..1.0) }
    assert_raise(ArgumentError) { Maybe.new "banana" }
    assert_raise(ArgumentError) { Maybe.new.truthPercent=1.2 }
  end

  def test_Maybes
    Maybe.reset!
    $t = Maybe.new
    assert_equal( 1 , Maybe.uncertain? )
    Maybe.maybe?
    assert_equal( 2 , Maybe.uncertain? )
    $t.maybe?
    assert_equal( 3 , Maybe.uncertain? )
  end

  
end

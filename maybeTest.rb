
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
    t = Maybe.new 1.0 #Making this always true is just... heartbreaking.
    assert_equal( true,  t.true?)
    assert_equal( false, t.false?)
    assert_equal( true,  t.and?(true) )
    assert_equal( false, t.and?(false) )    
    assert_equal( true,  t.or?(true) )
    assert_equal( true,  t.or?(false) )    
    assert_equal( true,  t.not?(false) )
    assert_equal( false, t.not?(true) )
    assert_equal( true,  t == true )
    assert_equal( false, t == false )
    assert_equal( true,  t != false )
    assert_equal( false, t != true )

    #test update
    t.update! 0.0
    assert_equal( false,t.true? )
    t.update! 1.0
    assert_equal( true, t.true? )
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
    t = Maybe.new
    assert_equal( 1 , Maybe.uncertain? )
    Maybe.maybe?
    assert_equal( 2 , Maybe.uncertain? )
    t.maybe?
    assert_equal( 3 , Maybe.uncertain? )
  end  
end

def exampleOfUse

  maybe = Maybe.new
  puts "I became: #{maybe.true?}"
  if maybe.true? then
    puts "Hello, this time i like you."
  else
    puts "I really hate you today."
  end

  while input = gets.chomp do

    if input.include?("why") then
      puts "Because it is a good day so far." if maybe.true?
      puts "I am actually not sure, maybe because you are asking stupid questions!" if maybe.false?
      puts "Also, that is a weird thing to ask." if maybe.maybe?
    elsif input.include?("who") && input.include?("you") then
      puts "A maybe test." if maybe.true?
      puts "YOU UPSET ME! GO AWAY" if maybe.false?
      puts "By the way, where is the nearest toilet?" if maybe.maybe?
    elsif input.include?("toilet?")then
      puts "Yes I need a toilet. Please direct me to one." if maybe.true?
      puts "That is not a weird thing for me to ask for. Stop it." if maybe.false?
      puts "And maybe a toilet paper roll?" if maybe.maybe?
    elsif input.include?("toilet") && ( input.include?("where") || input.include?("there"))then
      puts "Super. Thank you! Gotta go!" if maybe.true?
      puts "Shut up! That is probably the wrong direction. I'll find it myself!" if maybe.false?
      puts "Oh shit! I had too much burritos... RUN!" if maybe.maybe?
      break
    elsif input.include?("bye") then
      puts "Good bye. Nice seeing you" if maybe.true?
      puts "Good riddance. Bugger off!" if maybe.false?
      puts "Bring candy next time!" if maybe.maybe?
      break
    elsif input.include?("reroll") && input.include?("please") then
      maybe.update!
      puts "Rerolled, only for you my friend!" if maybe.true?
      puts "Aw shit, I rerolled. I'm still mad at you, though!" if maybe.false?
      puts "This is awesome, i am now #{maybe.true?}" if maybe.maybe?
    else 
      puts "I didn't get that, because I am retarded." if maybe.true?
      puts "You posed the question wrong. Stop being so stupid." if maybe.false?
      puts "Try to ask me: 'Who are you?' " if maybe.maybe?
    end
    
  end
  :ok
end

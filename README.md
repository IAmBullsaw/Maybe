# Maybe
I basically wanted a third bool that could be either true or false. So I made a Maybe class in ruby, that returns true 50% of the time(or what ever value is set). The best part of this class is that an instance of it stores the "random" bool, so that a specific Maybe keeps its true (or false) state through entire program. This can of course be overridden with the .update! method (or the more true to its nature .update?).

This Idea came to my mind when me and my friends had a deep discussion about choosing our "Top three bools". But, when do you need this? I am not entirely sure but I have some ideas. Let's imagine that we're making a RPG and our character has 70% chance to unlock a specific part of a dialogue, then this class is great.

     unlocked = Maybe.new
     unlocked.truthPercent=0.7
     unlocked.update!
     newCoolDialogueOption() if unlocked.true?
     
If you want to see this in action, I've added a smaller function to maybeTest.rb

Other ideas that come to mind: Just make some unnessecairy code. It's fun!

# Class methods
Maybe there's more. however I find these to be the most important.

     Maybe.maybe? 
     #=> true or false, with a chance of 0.5
     Maybe.false? 
     #=> calls a Maybe.maybe? and checks if it is false.
     Maybe.true? 
     #=> calls a Maybe.maybe? and checks if it is true.
     Maybe.uncertain? 
     #=> The class keeps track of every time Maybe.maybe? has been called, the amount is returned
     Maybe.reset? 
     #=> Resets the maybe counter.
     Maybe.do &block 
     #=> given block may be run.
     Maybe.dont &block 
     #=> given block may not be run.

# Instance methods
These are very useful.

     maybe = Maybe.new 
     #=> This instance has a stored bool generated via Maybe.maybe?
     maybe.true? / maybe.false?
     #=> Checks if it is true/ false
     maybe.maybe? 
     #=> true or false, with a default chance of 0.5
     maybe.truthPercent=(Numeric) / maybe.falsePercent=(Numeric) #=> sets the percentage of getting true / false.
     maybe.update? 
     #=> Maybe updates the stored bool to self.maybe?.
     maybe.update! 
     #=> Actually updates the stored bool to self.maybe?. I promise.
     maybe.wtf? 
     #=> It may or may not return true or false with a probability of I don't know.
     maybe.reset? 
     #=> Maybe resets the truthPercent
     maybe.reset! 
     #=> Resets the truthPercent
     maybe.and? (comp) 
     #=> returns if the stored bool && comp 
     maybe.or? (comp) 
     #=> returns if the stored bool || comp 
     maybe.not? (comp) 
     #=> returns if the stored bool != comp 

There may be more methods.

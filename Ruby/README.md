## Maybe - Ruby
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
     maybe.truthPercent=(Numeric) / maybe.falsePercent=(Numeric) 
     #=> sets the percentage of getting true / false.
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


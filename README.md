# Maybe
I basically wanted a third bool that could be either true or false. So I made a Maybe class in ruby, that returns true 50% of the time(or what ever value is set). The best part of this class is that an instance of it stores the "random" bool, so that a specific Maybe keeps its true (or false) state through entire program.

This Idea came to my mind when me and my friends had a deep discussion about choosing our "Top three bools". But, when do you need this? I am not entirely sure but I have some ideas. Let's imagine that we're making a RPG and our character has 70% chance to unlock a specific part of a dialogue, then this class is great.

     unlocked = Maybe.new 0.7
     newCoolDialogueOption() if unlocked.true?

Later in the dialogue or program you could easily do this check:

     if unlocked.true?
       self.increaseStatXP 10, 'charm'
     end
     
     
If you want to see this in action, I've added a smaller function to maybeTest.rb. To test it out, open up irb and load maybeTest.rb
then run the command:

     exampleOfUse

It will be alright. Just talk to the retarded AI.

Other ideas that come to mind: Just make some unnecessary code. It's fun!

#So...
As of today, there's my first Maybe-class in Ruby that got a little out of hand in the serious part. So I decided to make one in C++ as well. This is way more serious, and way less cody. Jesus. 
But it gave me an Idea. 

Time to make Maybe-classes in all OO languages. Fun.

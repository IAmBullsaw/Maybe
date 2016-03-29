##Maybe - C++
Everytime a Maybe-object is created, updates its value or Maybe::maybe() is called, a counter increases.

#Create a Maybe-object

    Maybe m; // Creates a Maybe with a 50% chance of true
    Maybe m{0.7}; // Creates a Maybe with the chance to get true to 70%

#Member functions - Public

    Maybe m;
    m.is_true(); // Returns true if it's true. (Yes, it just returs the Bool, it does not check maybetrue == true)
    m.is_false(); // Does the reverse.
    m.maybe(); // Returns a maybe with set truthPercent (0.5 in this example)
    m.update(); // Updates the bool with the set truthPercent.
    m.update( 0.7 ); //sets the truthPercent to 0.7 then updates.
    m.uncertain; //Returns the count of uncertanties (Calls of maybe)

#Member functions - Private

    Maybe::randomizer(); // This returns a random number between 0.0 and 1.0, not 0.5 (or set truthPercent)

#Member variables - Private

    bool maybetrue; //The maybe <3
    float truth; //The truthPercent
    static unsigned int maybes; //The counter

Have fun!

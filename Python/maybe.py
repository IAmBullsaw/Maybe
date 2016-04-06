from random import randint

class Maybe(object):

    def maybe(self):
        n = randint(0,100)
        while (n == 50):
            n = randint(0,100)
        n = n/100.0
        if n < self.truthPercent:
            return True
        else:
            return False

    def update(self):
        self.maybe = self.maybe()
    

    def __init__(self, truthP=0.5):
        if ( (truthP >= 0.0) and (truthP <= 1.0) ):
            self.truthPercent = truthP 
        else: 
            raise AttributeError("A maybe's truthPercent must be between 0.0 and 1.0")
        
        self.maybe = self.maybe()

    def __bool__(self):
        return self.maybe

    def __eq__(self, other):
        if isinstance(other,Maybe):
            return self.maybe == other.maybe
        else:
            return self.maybe == other
        
    def __ne__(self, other):
        if isinstance(other,Maybe):
            return self.maybe != other.maybe
        else:
            return self.maybe != other

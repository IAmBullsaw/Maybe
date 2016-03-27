#ifndef MAYBE_H
#define MAYBE_H

class Maybe {

 public:
  Maybe();
  Maybe(float tp);
	
  bool is_true();
  bool is_false();
  bool maybe();
  int uncertain();
 
  void update();
  void update(float thruthp);

 private:
  bool maybetrue;
  float truth;
  static unsigned int maybes;
  float randomizer();
  	
};


#endif /*MAYBE_H*/

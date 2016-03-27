#include <stdexcept>
#include <random>
#include "maybe.h"

unsigned int Maybe::maybes = 0;

Maybe::Maybe()
  :truth{0.5} {
  maybetrue = this->maybe();
}

Maybe::Maybe(float truthp){
  if (truthp <= 0.0 || truthp >= 1.0) {
    throw std::invalid_argument("A maybe object must have a truth percentage between 0.0 and 1.0");
  }
  truth = truthp;
  maybetrue = this->maybe();
}

bool Maybe::maybe(){
  maybes++;
  bool tof{false};
  float n{randomizer()};
  
  if (n < truth) {
    tof = true;
  }
  
  return tof;
}

bool Maybe::is_true(){
  return maybetrue;
}

bool Maybe::is_false(){
  return ( maybetrue == false) ;
}

int Maybe::uncertain(){
  return maybes;
}

void Maybe::update() {
  maybetrue = this->maybe();
}

void Maybe::update(float truthp) {
  if (truthp <= 0.0 || truthp >= 1.0) {
    throw std::invalid_argument("A maybe object must have a truth percentage between(or equal to) 0.0 and 1.0");
  }
  truth = truthp;
  maybetrue = this->maybe();
}

float Maybe::randomizer() {
  std::default_random_engine generator;
  std::uniform_real_distribution<float> distribution(0.0,1.0);
  float n = distribution(generator);	
  while (n == truth)
  {
	n = distribution(generator);
  }
	
    return n;
}

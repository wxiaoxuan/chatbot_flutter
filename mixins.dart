// static
// - to implement class-wide variables and methods

// MIXINS : a way of reusing a class's code in multiple class hierarchies
// - Mixins Format: use the 'with' keyword followed by the mixin names

void main() {
  Animal().move(); // output: changed position

  Fish().move(); // output: changed position by swimming
  Fish().swim();

  Bird().move(); // output: changed position by flying
  Bird().fly(); // output: weeeeee

  Duck().move(); // output: changed position
  Duck().swim(); // output: bloop bloop bloop
  Duck().fly(); // output: weeeeee
}

class Animal {
  void move() {
    print('changed position');
  }
}

class Fish extends Animal with canSwim {
  @override
  void move() {
    super.move();
    print('by swimming');
  }
}

class Bird extends Animal with canFly {
  @override
  void move() {
    super.move();
    print('by flying');
  }
}

class Duck extends Animal with canFly, canSwim {}

mixin canSwim {
  void swim() {
    print('bloop bloop bloop');
  }
}

mixin canFly {
  void fly() {
    print('weeeeee');
  }
}

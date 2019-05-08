// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of falling rectangles

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

float bw = 120;
float nnww;
float goal_y;
float start_y;
float []goal_x = new float [3];

void setup() {
  size(640,800);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -20);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
   //boundaries.add(new Boundary(width/4,height-5,width/2-100,10));
  // boundaries.add(new Boundary(3*width/4,height-5,width/2-100,10));
  boundaries.add(new Boundary (width-bw*0.5, 0, bw, 2.0*height)); // 右壁
  boundaries.add(new Boundary (bw*0.5, 0, bw, 2.0*height)); // 左壁
  boundaries.add(new Boundary (bw*0.5 + (width - bw) / 3, 0, bw, 2.0*height));
  boundaries.add(new Boundary (bw*0.5 + 2 * (width - bw) / 3, 0, bw, 2.0*height));
  
  nnww = (width - 4*bw) / 3.0;
  goal_y = height - 30;
  start_y = 30;
  
  goal_x[0] = bw + nnww/2.0;
  goal_x[1] = 2*bw + nnww + nnww/2.0;
  goal_x[2] = width - bw - nnww/2.0;
  
  //boundaries.add(new Boundary(width-5,height/2,10,height));
  //boundaries.add(new Boundary(5,height/2,10,height));
}

void draw() {
  //background(255);
  background(0);

  // We must always step through time!
  box2d.step();

  // When the mouse is clicked, add a new Box object
  if (random(1) < 0.1){
    int k = int(random(10000)); // 追加
    // Box p = new Box(random(width),10); 削除
    Box p = new Box(goal_x[k%3], start_y);

    boxes.add(p);
  }
  
  if (mousePressed) {
    for (Box b: boxes) {
     Vec2 wind = new Vec2(20,0);
     b.applyForce(wind);
    }
  }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  
  fill(0);
  text("Click mouse to apply a wind force.",20,20);
}

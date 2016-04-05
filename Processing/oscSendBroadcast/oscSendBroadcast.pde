/**
 * send a message to all the subnet
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myBroadcastLocation; 

void setup() {
  size(400,400);
  
  oscP5 = new OscP5(this,8888);
  myBroadcastLocation = new NetAddress("255.255.255.255", 32000);
  
  frameRate(20);
}


void mousePressed() {
  OscMessage myOscMessage;
  
  myOscMessage = new OscMessage("/mpx");
  myOscMessage.add(mouseX);
  
  myOscMessage = new OscMessage("/mpy");
  myOscMessage.add(mouseY);
  
  println("send mouse");
}


void draw() {
  background(0);
  
  OscMessage myOscMessage = new OscMessage("/qc");
  myOscMessage.add(frameCount);
  myOscMessage.add(mouseX);
  myOscMessage.add("dudee");

  //oscP5.send(myOscMessage, myBroadcastLocation);
  
}
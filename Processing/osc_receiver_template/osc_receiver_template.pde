import oscP5.*;
import netP5.*;

int IMG_X = 100;

PImage img=createImage(IMG_X,IMG_X,RGB);
PImage imgIn=createImage(IMG_X,IMG_X,RGB);
  color c=color(255,0,0);


OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this, 7172);

  myRemoteLocation = new NetAddress("192.168.2.40", 7172);
}

void draw() {
  background(0);
}

void oscEvent(OscMessage theOscMessage) {

  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  if (theOscMessage.addrPattern().equals("time")) {
    println(" typetag: "+theOscMessage.get(0).floatValue() );
  }

  if (theOscMessage.addrPattern().equals("time")) {
    println(" typetag: "+theOscMessage.get(0).floatValue() );
  }

  if (theOscMessage.addrPattern().equals("image")) {
    if (theOscMessage.checkTypetag("b")) {
      int bl;
      imgIn.loadPixels();
      bl=theOscMessage.get(0).blobValue().length;
      byte[] bb;
      bb=new byte[bl];
      bb = theOscMessage.get(0).blobValue();
      // println("decoding blob:");
      for (int i=0; i<bl/3; i++) {
        char r=char(bb[i*3+0]);
        char g=char(bb[i*3+1]);
        char b=char(bb[i*3+2]);
        //println(i,r,g,b); 
        c=color(int(r), int(g), int(b));

        imgIn.pixels[i]=c;
      }
      imgIn.updatePixels();
    }
  }
}
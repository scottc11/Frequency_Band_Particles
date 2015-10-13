// Create an object of a particle whith arguments locX, locY, sizeX, sizeY.  
// Use this particle object to draw a particle for every specSize()
// specSize is how many frequency bands the piece of audio has.  You can then get each 
// frequency bands data and adjust the particles arguments accordingly with getBand()

// You will have to devide the specSize() by two and avarage each band with its neighbor in order
// to draw an accurate representation of each band.  Theres not enough room for 513 bands.

// COLORS: GreenYellow = 173, 255, 47, 

import ddf.minim.*;
import ddf.minim.analysis.*;

// Declare Global objects to be used in setup(), draw(), and other funtions
Minim minim;
AudioPlayer player;
FFT fft;
BandParticle bandParticleDown;
BandParticle bandParticleUp;

int red = 0;
int green = 0;
int blue = 0;

// create an array to hold all the particles.  One array for each type of particle.
ArrayList<BandParticle> bpdArray = new ArrayList<BandParticle>();
ArrayList<BandParticle> bpuArray = new ArrayList<BandParticle>();


void setup() {
  size(600, 400);
  background(99, 99, 99);
  
  minim = new Minim(this);
  // 1024 is the buffer size.  FFT's like this size. Something about power-of-two.
  player = minim.loadFile("06-Logistics-Sparks.mp3", 1024);  
  player.loop();
  
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  //Setup up particle arrays (ArrayList)
  // appends a particle object for each bandwidth to the end of an array.
  for (int i = 0; i < fft.specSize(); i++) {
    bpdArray.add(new BandParticle(color(173, 255, 147), i, fft.getBand(i), 2, 2, i));
    bpuArray.add(new BandParticle(color(173, 255, 47), i, (fft.getBand(i) * -1), 4, 4, i));
  }
  
}

void draw() {
  background(99, 99, 99);  
  
  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward(player.mix);
  
  
  for (int i = 0; i < bpdArray.size(); i++) {
    
    float freqPer = (float)i/bpuArray.size();  // this is your 0.0 -> 1.0 range number
    float sinFreqPer = sin( freqPer * 3.141592 ); // this will give you half of a full sine wave
    //float newValue = freq[i] * sinFreqPer;
    
    // Draw the particles Upwards
    bpuArray.get(i).update(color(173, 255, 47), i, (fft.getBand(i) * -1), 4, 4, i);
    bpuArray.get(i).drawParticle();
    
    // Draw the Reflection particles (downwards)
    BandParticle part = bpdArray.get(i);
    part.update(color(173, 255, 147), i, fft.getBand(i), 2, 2, i);
    part.drawParticle();
  }
  
  

  println("Band 250: ", fft.getBand(10), "Band 260: ", fft.getBand(260));
  println((fft.getBand(250) * -1) * sin(fft.getBand(250)));

}
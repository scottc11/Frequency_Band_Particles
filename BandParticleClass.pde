class BandParticle {
  // Class Properties
  color particleColor;
  float locX;
  float locY;
  float sizeX;
  float sizeY;
  int bandNumber;
  
  // This is a constructor.  It is what gets called when you create an object of the class
  BandParticle(color tempParticleColor, float tempLocX, float tempLocY, float tempSizeX, float tempSizeY, int tempBandNumber) {
    
    particleColor = tempParticleColor;
    locX = tempLocX + ((width - fft.specSize()) / 2);  // This centers the waveform horozontally
    locY = tempLocY + (height / 2);  // This centers the waveform vertically
    sizeX = tempSizeX;
    sizeY = tempSizeY;
    bandNumber = tempBandNumber;
  }
  
  // updates the parameters of particle.  Meant to be used in the Draw Loop
  void update(color tempParticleColor, float tempLocX, float tempLocY, float tempSizeX, float tempSizeY, int tempBandNumber) {
    particleColor = tempParticleColor;
    locX = tempLocX + ((width - fft.specSize()) / 2);  // This centers the waveform horozontally
    locY = tempLocY + (height / 2);  // This centers the waveform vertically
    sizeX = tempSizeX;
    sizeY = tempSizeY;
    bandNumber = tempBandNumber;
  }
  
  // creating a method.  Must use 'void' if the method doesn't return anything.
  void drawParticle() {

    
    fill(particleColor);
    noStroke();
    ellipse(locX, locY, sizeX, sizeY);
  }
  
}


// http://web.archive.org/web/20081218154505/http://www.flight404.com/blog/?p=143
// HOW TO LEVEL THE FFT TO ANALYSE LESS LOW-END
// "...the FFT data is heavily biased towards the lower frequencies which presents itself as a sharp 
// falloff as you go from low to high. As a quick fix, I multiplied the FFT data by a section of 
// a sine wave and leveled off the data. This put the majority of the action in the middle of the 
// waveform instead of the left side."
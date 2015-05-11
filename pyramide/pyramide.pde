// minim library
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// minim settings
Minim minim;
AudioInput in;

// image source
PImage rue;


void setup() {
  
  rue = loadImage("DSC_0011.JPG");
  size(rue.width,rue.height);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO,rue.width);  
  
}

void draw() {
  image (rue,0,0);
  
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    float hauteurDeSon = in.mix.get(i);
    int largeur= round(random(100));
    int hauteur= round(random(100));
    
    int nbColonne=floor(hauteurDeSon*25);
    int nbLigne=nbColonne;
    
    int depart=(width/2)-((nbColonne*largeur)/2);
    
    int posX=depart;
    int posY=height;
    
    int offsetX = floor(hauteurDeSon*100);
    int offsetY = floor(hauteurDeSon*100);
    
    if(abs(hauteurDeSon)>.99){
    hauteurDeSon+=random(hauteurDeSon/abs(hauteurDeSon));
    }
    
    for (int k=0; k<=nbLigne; k++){
     
     for (int j=nbColonne; j>=0; j--){
       //rect(posX,posY,largeur,hauteur);
       copy(rue,posX,posY,largeur,hauteur,offsetX+posX,offsetY+posY,largeur,hauteur);
       posX = posX+largeur;
     } 
     
     posY=posY-hauteur;
     nbColonne--;
     posX=depart+(k*(largeur/2));
    }
  }
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}

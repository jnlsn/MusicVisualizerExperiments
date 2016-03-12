import ddf.minim.*;
import ddf.minim.analysis.*;

import controlP5.*;

// Virtual controls
ControlP5 cp5;
boolean showVirtualKnobs = false;
boolean toggleA = false;
boolean toggleB = false;
boolean toggleC = false;

float motionPerc;
float colorPerc;
float shapePerc;

Minim minim;
AudioInput audioIn;
BeatDetect beat;
BeatListener bl;
FFT fft;

// For on-the-fly switching between visualizers
ArrayList<Visualizer> visualizers;
int selected;

void setup() {
    size(1280, 720, P3D);
    // fullScreen(P3D);
    frameRate(30);

    minim = new Minim(this);
    audioIn = minim.getLineIn(Minim.STEREO, 1024);

    beat = new BeatDetect(audioIn.bufferSize(), audioIn.sampleRate());
    beat.setSensitivity(0);
    bl = new BeatListener(beat,audioIn);

    visualizers = new ArrayList<Visualizer>();
    visualizers.add(new MaxHeadroomVisualizer(this));
    visualizers.add(new SphereCoilVisualizer(this));
    selected = 0;

    // Add some virtual knobs and buttons for testing
    cp5 = new ControlP5(this);

    cp5.addKnob("motionPerc")
        .setLabelVisible(false)
        .setRange(0,1)
        .setValue(random(1))
        .setRadius(30)
        .setPosition(20, height - 80)
        .setDragDirection(Knob.HORIZONTAL);

    cp5.addKnob("shapePerc")
        .setLabelVisible(false)
        .setRange(0,1)
        .setValue(random(1))
        .setRadius(30)
        .setPosition(90, height - 80)
        .setDragDirection(Knob.HORIZONTAL);

    cp5.addKnob("colorPerc")
        .setLabelVisible(false)
        .setRange(0,1)
        .setValue(random(1))
        .setRadius(30)
        .setPosition(160, height - 80)
        .setDragDirection(Knob.HORIZONTAL);

    cp5.addToggle("toggleA")
        .setLabelVisible(false)
        .setPosition(230, height - 80)
        .setSize(15, 15);

    cp5.addToggle("toggleB")
        .setLabelVisible(false)
        .setPosition(230, height - 58)
        .setSize(15, 15);

    cp5.addToggle("toggleC")
        .setLabelVisible(false)
        .setPosition(230, height - 35)
        .setSize(15, 15);

    cp5.addButton("skipVisualizer")
        .setPosition(255, height - 80)
        .setLabel(">")
        .setSize(15, 60);

    cp5.hide();
}

void draw() {
    visualizers.get(selected).display();
    if(showVirtualKnobs){
        camera();
        fill(0,100);
        noStroke();
        rect(10, height-90, 270, 80);
    }
}

void keyReleased() {
    if(key==' '){
        if(!showVirtualKnobs){
            showVirtualKnobs = true;
            cp5.show();
        } else if(showVirtualKnobs){
            showVirtualKnobs = false;
            cp5.hide();
        }
    }
}

void skipVisualizer(int theValue) {
    selected++;
    if(selected >= visualizers.size()){
        selected = 0;
    }
}

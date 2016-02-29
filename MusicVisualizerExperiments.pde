import ddf.minim.*;
import ddf.minim.analysis.*;

import controlP5.*;

// Virtual knobs
ControlP5 cp5;
boolean showVirtualKnobs = false;
Knob virtualKnobA;
Knob virtualKnobB;
Knob virtualKnobC;

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
    visualizers.add(new SphereCoilVisualizer(this));
    selected = 0;

    // Add some virtual knobs for testing
    cp5 = new ControlP5(this);
    virtualKnobA = cp5.addKnob("motionPerc")
        .setRange(0,1)
        .setValue(0.5)
        .setRadius(30)
        .setPosition(20, height - 90)
        .setLabel("Motion")
        .setDragDirection(Knob.HORIZONTAL)
        .hide();

    virtualKnobB = cp5.addKnob("colorPerc")
        .setRange(0,1)
        .setValue(0.5)
        .setRadius(30)
        .setPosition(90, height - 90)
        .setLabel("Color")
        .setDragDirection(Knob.HORIZONTAL)
        .hide();

    virtualKnobC = cp5.addKnob("shapePerc")
        .setRange(0,1)
        .setValue(0.5)
        .setRadius(30)
        .setPosition(160, height - 90)
        .setLabel("Shape")
        .setDragDirection(Knob.HORIZONTAL)
        .hide();
}

void draw() {
    visualizers.get(selected).display();
    if(showVirtualKnobs){
        camera();
        fill(0,100);
        noStroke();
        rect(10, height-100, 220, 90);
    }
}

void keyReleased() {
    if(key==' '){
        if(!showVirtualKnobs){
            showVirtualKnobs = true;
            virtualKnobA.show();
            virtualKnobB.show();
            virtualKnobC.show();
        } else if(showVirtualKnobs){
            showVirtualKnobs = false;
            virtualKnobA.hide();
            virtualKnobB.hide();
            virtualKnobC.hide();
        }
    }
}

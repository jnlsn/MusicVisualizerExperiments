import ddf.minim.*;
import ddf.minim.analysis.*;

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
    background(255);
    stroke(0);

    minim = new Minim(this);
    audioIn = minim.getLineIn(Minim.STEREO, 1024);

    beat = new BeatDetect(audioIn.bufferSize(), audioIn.sampleRate());
    beat.setSensitivity(0);
    bl = new BeatListener(beat,audioIn);

    visualizers = new ArrayList<Visualizer>();
    visualizers.add(new SphereCoilVisualizer(this));
    selected = 0;
}

void draw() {
    visualizers.get(selected).display();
}

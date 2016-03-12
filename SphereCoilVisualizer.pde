class SphereCoilVisualizer extends Visualizer
{
    float beatVal;
    int radius;

    SphereCoilVisualizer(PApplet parentApplet){
        super(parentApplet);
        radius = height / 4;
        beatVal = 0;
    }

    @Override
    public void display(){
        background(255);
        strokeWeight(1.5);

        // calculate faster decay for greater motion
        beatVal *= (0.9 - 0.4 * motionPerc);
        // Give hat, snare, and kick different weight
        if(beat.isHat()) beatVal += radius*0.02 + radius*0.02*motionPerc;
        if(beat.isSnare()) beatVal += radius*0.04 + radius*0.04*motionPerc;
        if(beat.isKick()) beatVal += radius*0.06 + radius*0.06*motionPerc;
        // prevent sphere from growing off screen
        beatVal = constrain(beatVal, 0, radius);

        // Center drawing point
        translate(width/2, height/2, 0);

        // Slowly rotate camera
        rotateY(frameCount * random(0.004, 0.001));
        rotateX(frameCount * random(0.004, 0.001));

        float s = 0;
        float t = 0;
        float c = 0;
        float lastx = 0;
        float lasty = 0;
        float lastz = 0;
        int bsize = audioIn.bufferSize();
        float tIncrement = 180.0/bsize;
        float sIncrement = 1 + 5 * shapePerc;
        for (int b = 0; b < bsize; b++){
            c += 0.001 * colorPerc;
            s += sIncrement;
            t += tIncrement;
            float radianS = radians(s);
            float radianT = radians(t);
            float intensity = radius/4 + radius/2 * motionPerc;
            float thisx = 0 + ((radius + audioIn.mix.get(b)*intensity) * cos(radianS) * sin(radianT));
            float thisy = 0 + ((radius + audioIn.mix.get(b)*intensity) * sin(radianS) * sin(radianT));
            float thisz = 0 + ((radius + beatVal) * cos(radianT));
            if (lastx != 0) {
                stroke(
                    (128*sin(t/9+sIncrement*c)+127)*colorPerc,
                    (128*sin(t/9+PI+sIncrement*c)+127)*colorPerc,
                    (128*cos(t/9-sIncrement*c)+127)*colorPerc
                );
                // draw the waveform
                line(thisx, thisy, thisz, lastx, lasty, lastz);

                // draw a triangle connecting waveform to center spindle
                if(toggleA){
                    fill(
                        (128*sin(t/9+sIncrement*c)+127)*colorPerc,
                        (128*sin(t/9+PI+sIncrement*c)+127)*colorPerc,
                        (128*cos(t/9-sIncrement*c)+127)*colorPerc
                    );
                    noStroke();
                    beginShape();
                    vertex(thisx, thisy, thisz);
                    vertex(lastx, lasty, lastz);
                    vertex(0, 0, lastz);
                    endShape();
                }

                // draw a line connecting waveform to center spindle
                if(toggleB){
                    line(thisx, thisy, thisz, 0, 0, lastz);
                }
            }
            lastx = thisx;
            lasty = thisy;
            lastz = thisz;
        }
    }
}

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
        beatVal *= 0.8;
        if(beat.isHat()) beatVal += radius*0.02;
        if(beat.isSnare()) beatVal += radius*0.04;
        if(beat.isKick()) beatVal += radius*0.06;
        beatVal = constrain(beatVal, 0, radius);
        background(255);
        translate(width/2, height/2, 0);
        rotateY(frameCount * 0.003);
        rotateX(frameCount * 0.004);
        float s = 0;
        float t = 0;
        float lastx = 0;
        float lasty = 0;
        float lastz = 0;
        int bsize = audioIn.bufferSize();
        while (t < 180){
            s += 18;
            t += 1;
            int sampleNum = int((t / 180) * bsize);
            sampleNum = constrain(sampleNum, 0, bsize-1);
            float radianS = radians(s);
            float radianT = radians(t);
            float thisx = 0 + ((radius + audioIn.mix.get(sampleNum)*100) * cos(radianS) * sin(radianT));
            float thisy = 0 + ((radius + audioIn.mix.get(sampleNum)*100) * sin(radianS) * sin(radianT));
            float thisz = 0 + ((radius + beatVal) * cos(radianT));
            if (lastx != 0) {
                line(thisx, thisy, thisz, lastx, lasty, lastz);
            }
            lastx = thisx;
            lasty = thisy;
            lastz = thisz;
        }
    }
}

class MaxHeadroomVisualizer extends Visualizer
{
    float beatVal;
    int cubeLength;

    MaxHeadroomVisualizer(PApplet parentApplet){
        super(parentApplet);
        // cubeLength = height;
        // beatVal = 0;
    }

    public void waveformLine(float startx, float starty, float startz, float endx, float endy, float endz){
        int steps = int(4 + 35*motionPerc);
        float waveformMultiplier = width*0.2 + width*0.8*motionPerc;
        float changey = endy - starty;
        float changex = endx - startx;
        int bsize = audioIn.bufferSize();
        beginShape();
        curveVertex(startx, starty, startz);
        curveVertex(startx, starty, startz);
        for(int p = 1; p < steps; p++){
            int b = int((bsize-1)*p/steps);
            curveVertex(
                startx + changex * p/steps,
                starty + changey * p/steps,
                startz + audioIn.mix.get(b) * waveformMultiplier
            );
        }
        curveVertex(endx, endy, endz);
        curveVertex(endx, endy, endz);
        endShape();
    }

    @Override
    public void display(){
        // int bsize = audioIn.bufferSize();
        int cubeSize = int(width*2 + width*3*shapePerc);
        int numSquares = int(cubeSize*0.005);
        float radius = cubeSize/2;

        background(20,20,20);
        strokeWeight(2);
        noFill();
        translate(width/2, height/2, height/2);
        rotateY(frameCount * random(0.008, 0.002));
        rotateX(frameCount * random(0.008, 0.004));
        rotateZ(frameCount * random(0.008, 0.002));

        for (int i = 0; i <= numSquares; i++){
            float zDepth = -radius + cubeSize * i/numSquares;
            // Top
            stroke(0,76,255);
            this.waveformLine(
                -radius,
                -radius,
                zDepth,
                radius,
                -radius,
                zDepth
            );
            // Right
            stroke(255,54,158);
            this.waveformLine(
                radius,
                -radius,
                zDepth,
                radius,
                radius,
                zDepth
            );
            // Bottom
            stroke(0,76,255);
            this.waveformLine(
                radius,
                radius,
                zDepth,
                -radius,
                radius,
                zDepth
            );
            // Left
            stroke(255,54,158);
            this.waveformLine(
                -radius,
                radius,
                zDepth,
                -radius,
                -radius,
                zDepth
            );

            if(i==0 || i==numSquares){
                stroke(223,255,50);
                for(int i2 = 1; i2 < numSquares; i2++){
                    this.waveformLine(
                        -radius + cubeSize * i2/numSquares,
                        radius,
                        zDepth,
                        -radius + cubeSize * i2/numSquares,
                        -radius,
                        zDepth
                    );
                }
            }
        }
    }
}

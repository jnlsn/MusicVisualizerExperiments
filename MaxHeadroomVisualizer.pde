class MaxHeadroomVisualizer extends Visualizer
{
    float beatVal;
    int cubeLength;

    MaxHeadroomVisualizer(PApplet parentApplet){
        super(parentApplet);
        // cubeLength = height;
        // beatVal = 0;
    }

    public void waveformLine(float startx, float starty, float startz, float endx, float endy, float endz, char direction){
        int steps = int(4 + 35*motionPerc);
        float waveformMultiplier = width*0.2 + width*0.8*motionPerc;
        float changey = endy - starty;
        float changex = endx - startx;
        float changez = endz - startz;
        int bsize = audioIn.bufferSize();
        beginShape();
        curveVertex(startx, starty, startz);
        curveVertex(startx, starty, startz);
        for(int p = 1; p < steps; p++){
            int b = int((bsize-1)*p/steps);
            float vertexX = startx + changex * p/steps;
            float vertexY = starty + changey * p/steps;
            float vertexZ = startz + changez * p/steps;
            if(direction == 'z') {
                vertexZ += audioIn.mix.get(b) * waveformMultiplier;
            } else if (direction == 'x') {
                vertexX += audioIn.mix.get(b) * waveformMultiplier;
            }
            curveVertex(vertexX, vertexY, vertexZ);
        }
        curveVertex(endx, endy, endz);
        curveVertex(endx, endy, endz);
        endShape();
    }

    @Override
    public void display(){
        // int bsize = audioIn.bufferSize();
        int cubeSize = int(width*2 + width*3.5*shapePerc);
        int numSquares = int(cubeSize*0.005);
        float radius = cubeSize/2;

        background(20,20,20);
        strokeWeight(2);
        noFill();
        translate(width/2, height/2, height/2);
        rotateY(frameCount * random(0.008, 0.001));
        rotateX(frameCount * random(0.008, 0.001));
        rotateZ(frameCount * random(0.008, 0.001));

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
                zDepth,
                'z'
            );
            // Right
            stroke(255,54,158);
            this.waveformLine(
                radius,
                -radius,
                zDepth,
                radius,
                radius,
                zDepth,
                'z'
            );
            // Bottom
            stroke(0,76,255);
            this.waveformLine(
                radius,
                radius,
                zDepth,
                -radius,
                radius,
                zDepth,
                'z'
            );
            // Left
            stroke(255,54,158);
            this.waveformLine(
                -radius,
                radius,
                zDepth,
                -radius,
                -radius,
                zDepth,
                'z'
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
                        zDepth,
                        'x'
                    );
                }
            }
        }
    }
}

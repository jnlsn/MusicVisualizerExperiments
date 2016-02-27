public abstract class Visualizer
{
    protected PApplet parent;
    public Visualizer(PApplet parentApplet){
        this.parent = parentApplet;
    }

    public void display(){}
}

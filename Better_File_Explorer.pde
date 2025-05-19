import java.util.Date;
import processing.video.*;
import processing.sound.*;
import g4p_controls.*;
import java.awt.Font;
import java.nio.file.*;

RootFolder rootFolder = new RootFolder("");

RootFolder currentFolder = rootFolder;
PApplet MainScreen;
MediaFile currentFile;

int buttonHeight = 30;
int buttonWidth = 80;
int toolbarHeight = buttonHeight + 2 * buttonHeight / 2;

void settings() {
    int maxW = displayWidth * 2 / 3;
    int maxH = displayHeight * 2 / 3;
    int w = maxW;
    int h = maxH / buttonHeight * buttonHeight;
    size(w, h);
}

void setup() {
    MainScreen = this;
    createGUI();
}

void draw() {
    background(230);
    noStroke();
    //textSize(50);
    fill(215);
    rect(0,0,width,toolbarHeight);
    fill(200);
    rect(0,0,buttonWidth * 2, height);
    stroke(180);
    
    line(0, toolbarHeight, buttonWidth * 2, toolbarHeight);
    stroke(200);
    line(140,35,600,35);
    checkSelectedObject();



}

void checkSelectedObject(){

    for (MediaFile f: currentFolder.files){

        if (f == currentFile){
            f.FileLabel.setLocalColorScheme(GCScheme.GREEN_SCHEME);
        }else{
            f.FileLabel.setLocalColorScheme(GCScheme.BLUE_SCHEME);
        }
    }
}

void mousePressed(){
    for (MediaFile f: currentFolder.files){
        GLabel FileLabel = f.FileLabel;
        boolean isMouseAboveLabelX = (mouseX > FileLabel.getX() && mouseX < FileLabel.getX() + FileLabel.getWidth());
        boolean isMouseAboveLabelY = (mouseY > FileLabel.getY() && mouseY < FileLabel.getY() + FileLabel.getHeight());
        if (isMouseAboveLabelX && isMouseAboveLabelY){
            currentFile = f;
        }
    }
}
import java.util.Date;
import processing.video.*;
import processing.sound.*;
import g4p_controls.*;
import java.awt.Font;
import java.nio.file.*;

RootFolder rootFolder = new RootFolder("");

RootFolder currentFolder = rootFolder;

int buttonHeight = 30;
int buttonWidth = 80;

void settings() {
    int maxW = displayWidth * 2 / 3;
    int maxH = displayHeight * 2 / 3;
    int w = maxW;
    int h = maxH / buttonHeight * buttonHeight;
    size(w, h);
}

void setup() {
    createGUI();
}

void draw() {
    int toolbarHeight = buttonHeight + 2 * buttonHeight / 2;
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
}

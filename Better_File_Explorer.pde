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
int toolbarHeight = 2 * buttonHeight;

int selectedIndex = -1;

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
    fill(215);
    rect(0,0,width,toolbarHeight);
    fill(200);
    rect(0,0,buttonWidth * 2, height);
    stroke(180);
    
    line(0, toolbarHeight, buttonWidth * 2, toolbarHeight);
    stroke(200);
    line(140,35,600,35);

    drawCurrentFolder();
}

void drawCurrentFolder() {
    int curY = toolbarHeight;
    int fillColIndex = 0;
    int[] fillCols = {color(220), color(240)};
    for (Folder folder : this.currentFolder.getFolders()) {
        fill(fillCols[fillColIndex ^= 1]);
        rect(buttonWidth * 2, curY, width - buttonWidth, buttonHeight);
        textAlign(LEFT, CENTER);
        fill(0);
        text(folder.getName(), buttonWidth * 2 + 10, curY + buttonHeight / 2);
        curY += buttonHeight;
    }
    for (MediaFile file : this.currentFolder.getFiles()) {
        fill(fillCols[fillColIndex ^= 1]);
        rect(buttonWidth * 2, curY, width - buttonWidth, buttonHeight);
        textAlign(LEFT, CENTER);
        fill(0);
        text(file.getName(), buttonWidth * 2 + 10, curY + buttonHeight / 2);
        curY += buttonHeight;
    }
    if (selectedIndex >= 0) {
        fill(0x3f, 0xbf, 0x3f, 0x7f);
        rect(buttonWidth * 2, selectedIndex * buttonHeight + toolbarHeight, width - buttonWidth, buttonHeight);
    }
}

void mousePressed(){
    if (mouseX > 2 * buttonWidth && mouseY > toolbarHeight && mouseY < buttonHeight * currentFolder.getSize() + toolbarHeight) {
        selectedIndex = (int) (mouseY - toolbarHeight) / buttonHeight;
    } else {
        if (mouseY > toolbarHeight) selectedIndex = -1;
    }
}

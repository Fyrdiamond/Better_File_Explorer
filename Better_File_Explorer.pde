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
    background(0);

    String path = dataPath("");
    currentFolder.addFolder("Library");
    currentFolder = currentFolder.getFolder("Library");
    println(currentFolder.getPath());
    new File(path).mkdir();
    File dst = new File(System.getProperty("user.dir"));
    File src = new File("/Users/lobbard/pfp.png");
}

void draw() {}

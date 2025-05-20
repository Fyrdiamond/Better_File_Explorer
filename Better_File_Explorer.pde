import java.util.Date;
import processing.video.*;
import processing.sound.*;
import g4p_controls.*;
import java.awt.Font;
import java.nio.file.*;
import gifAnimation.*;

Folder rootFolder = new Folder("");

Folder currentFolder = rootFolder;
PApplet mainScreen;
MediaFile currentFile;

Movie media1;
PImage media2;
SoundFile media3;
Gif media4;

int buttonHeight = 30;
int buttonWidth = 80;
int toolbarHeight = 2 * buttonHeight;

int selectedIndex = -1;

String getMediaType(FileType f){
  String mediaType = null; 
   for (String fileT : PHOTOS){
     if (FileType.valueOf(fileT) == f){
       mediaType = "Photo";
     }
        }

   if (FileType.valueOf("GIF") == f){
     mediaType = "Gif";
   }
   
   for (String fileT : VIDEOS){
     if (FileType.valueOf(fileT) == f){
       mediaType = "Video";
     }
   }
   for (String fileT : AUDIOS){
     if (FileType.valueOf(fileT)==f){
       mediaType = "Audio";
     }
   }
   return mediaType;
}

void settings() {
    int maxW = displayWidth * 2 / 3;
    int maxH = displayHeight * 2 / 3;
    int w = maxW;
    int h = maxH / buttonHeight * buttonHeight;
    size(w, h);
}

void setup() {
    mainScreen = this;
    createGUI();
}

void draw() {
    surface.setTitle("Better File Explorer: " + currentFolder.getPath());
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
    // Start drawing the current folder from below the toolbar
    int curY = toolbarHeight;
    int fillColIndex = 0;
    int[] fillCols = {color(220), color(240)};

    // Draw this folder's parent
    // Alternate colours
    fill(fillCols[fillColIndex ^= 1]);
    // Draw the parent folder
    rect(buttonWidth * 2, curY, width - buttonWidth * 2, buttonHeight);
    // Draw the previous folder symbol
    fill(0);
    textAlign(LEFT, CENTER);
    text("..", buttonWidth * 2 + 10, curY + buttonHeight / 2);
    // Adjust the y position for everything else
    curY += buttonHeight;

    // Draw every folder, using alternating dark and light grey
    for (Folder folder : this.currentFolder.getFolders()) {
        if (curY > height) break;
        // Alternate colours
        fill(fillCols[fillColIndex ^= 1]);
        // Draw the folder
        rect(buttonWidth * 2, curY, width - buttonWidth * 2, buttonHeight);
        // Draw the folder name
        fill(0);
        textAlign(LEFT, CENTER);
        text(folder.getName(), buttonWidth * 2 + 10, curY + buttonHeight / 2);
        // Adjust the y position for the next folder
        curY += buttonHeight;
    }

    // Draw every file, using alternating dark and light grey
    for (MediaFile file : this.currentFolder.getFiles()) {
        if (curY > height) break;
        // Alternate colours
        fill(fillCols[fillColIndex ^= 1]);
        // Draw the file
        rect(buttonWidth * 2, curY, width - buttonWidth * 2, buttonHeight);
        // Draw the file name
        fill(0);
        textAlign(LEFT, CENTER);
        text(file.getName(), buttonWidth * 2 + 10, curY + buttonHeight / 2);
        // Adjust the y position for the next file
        curY += buttonHeight;
    }

    // If a file or folder is selected, draw a highlight over it
    if (selectedIndex >= 0) {
        fill(0x3f, 0xbf, 0x3f, 0x7f);
        rect(buttonWidth * 2, selectedIndex * buttonHeight + toolbarHeight, width - buttonWidth * 2, buttonHeight);
    }
}

void mousePressed(){
    // Get the selected file or folder if the mouse is within the display area for files and folders
    if (mouseX > 2 * buttonWidth && mouseY > toolbarHeight && mouseY < buttonHeight * (currentFolder.getSize() + 1) + toolbarHeight) {
        selectedIndex = (int) (mouseY - toolbarHeight) / buttonHeight;
    } else {
        if (mouseY > toolbarHeight) selectedIndex = -1;
    }
}

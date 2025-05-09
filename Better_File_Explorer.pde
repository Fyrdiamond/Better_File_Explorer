import java.util.Date;

import processing.video.*;
ArrayList<MediaFile> mediaFileList = new ArrayList<MediaFile>();

void importFile(){ // Function to import file from the user's device.
    selectInput("Select a file to process:", "FileSelected");
}

void FileSelected(File ChosenFile){ // function that runs once the user selects a file.
    if (ChosenFile != null){
        println(ChosenFile.getAbsolutePath());

        PImage AttemptImg = loadImage(ChosenFile.getAbsolutePath());

        if (AttemptImg != null){
            println("Success!");
        } else {
            println("Not an image");
        }
        //MediaFile newFile = new MediaFile(ChosenFile.name, "hi");
        //println(newFile.Name);
        // maybe create the class here?
    }
}

void setup() {
    size(500,500);
    background(0);
    importFile();
}

void setup() {}

void draw() {}

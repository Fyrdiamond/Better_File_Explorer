GWindow mediaWindow;
void changeWindow(){
    currentFile = currentFolder.getFiles().get(selectedIndex - currentFolder.getFolders().size() - 1);
    FileType displayFileType = currentFile.getFileType();
    String displayMediaType = getMediaType(displayFileType);
    String displayFilePath = currentFile.getPath();
    
    
    if (displayMediaType.equals("Video")){
     
      media1 = new Movie(this, displayFilePath);
      media1.loop();
    }
    
    if (displayMediaType.equals("Photo")){
      media2 = loadImage(displayFilePath);
    }
    
    if (displayMediaType.equals("Audio")){
      media3 = new SoundFile(this, displayFilePath);
      media3.play();
      print("yes");

    }
    if(displayMediaType.equals("Gif")){
      media4 = new Gif(this, displayFilePath);
      media4.loop();
    }
}

void createWindow(){  // this function will execute when the user presses "open"
    int maxW = displayWidth * 2 / 3;
    int maxH = displayHeight * 2 / 3;
    int w = maxW;
    int h = maxH / buttonHeight * buttonHeight;
    if (mediaWindow == null){
      mediaWindow = GWindow.getWindow(this, "mediaView", 0, 0, w, h, JAVA2D);
      mediaWindow.setActionOnClose(G4P.CLOSE_WINDOW);
      mediaWindow.addDrawHandler(this, "mediaWindowOpen");
      mediaWindow.addOnCloseHandler(this, "resetMedia");
      mediaWindow.loop();
      
      GButton nextMediaButton;
      nextMediaButton = new GButton(mediaWindow, width - buttonWidth, height / 2, buttonHeight, buttonHeight);
      nextMediaButton.setText(">");
      nextMediaButton.addEventHandler(this, "nextMediaButtonClicked");
      
      GButton previousMediaButton;
      previousMediaButton = new GButton(mediaWindow, 0 + buttonWidth, height/2, buttonHeight, buttonHeight);
      previousMediaButton.setText("<");
      previousMediaButton.addEventHandler(this, "previousMediaButtonClicked");
      
      
    }
    changeWindow();
}

void deleteSelectedFile(){ // this function will execute when the user presses "delete"
    if (selectedIndex > 0){
        if (selectedIndex <= currentFolder.getFolders().size()){
            currentFolder.removeFolder(currentFolder.getFolders().get(selectedIndex - 1).getName());
        } else {
            selectedIndex -= currentFolder.getFolders().size();
            currentFolder.removeFile(currentFolder.getFiles().get(selectedIndex - 1));
        }
        selectedIndex = -1;
    }
}


void openSelectedItem(){ // function that will execute when the user presses "open"
    if (selectedIndex > 0){
        if (selectedIndex <= currentFolder.getFolders().size()){
            currentFolder = currentFolder.getFolders().get(selectedIndex - 1);
        } else {
          createWindow();
        }
        
    } else {
        currentFolder = currentFolder.getParent();
    }
}

void renameSelectedItem(String newText){
    if (selectedIndex > 0){
        if (selectedIndex <= currentFolder.getFolders().size()){
            currentFolder.getFolders().get(selectedIndex - 1).rename(newText);
        } else {
            println("Object is not a folder");
        }
        
    }
}


synchronized public void mediaWindowOpen(PApplet appc, GWinData data) { //_CODE_:mediaWindow:247466:
    appc.background(230);
   FileType displayFileType = currentFile.getFileType();
    String displayMediaType = getMediaType(displayFileType);
    if (displayMediaType.equals("Video")){
      if (media1 != null && mediaWindow != null){
        mediaWindow.image(media1, 0, 0);
      }
    }
    
    if (displayMediaType.equals("Photo")){
      if (media2 != null && mediaWindow != null){
        mediaWindow.image(media2, 0, 0);
      }
    }
    
    if(displayMediaType.equals("Audio")){
      if(media3 != null && mediaWindow != null){
         
      }
    }
    
    if(displayMediaType.equals("Gif")){
      if(media4 != null && mediaWindow != null){
        println("h0o");
        mediaWindow.image(media4, 0,0);
      }
    }
} //_CODE_:mediaWindow:247466:

public void resetMedia(GWindow window) { //_CODE_:mediaWindow:917051:
    FileType displayFileType = currentFile.getFileType();
    String displayMediaType = getMediaType(displayFileType);
    if (displayMediaType.equals("Video")){
     media1.pause();
     media1 = null;
    }
    
    if (displayMediaType.equals("Photos")){
      media2 = null;
    }
    
    if(displayMediaType.equals("Audio")){
      media3.pause();
      media3 = null;
    }
    
    if(displayMediaType.equals("Gif")){
      media4 = null;
    }
    mediaWindow = null;

    //img = null;
} //_CODE_:mediaWindow:917051:

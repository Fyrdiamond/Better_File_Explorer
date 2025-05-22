GWindow mediaWindow;
void changeWindow(){
    currentFile = currentFolder.getFiles().get(displayIndex - currentFolder.getFolders().size() - 1);
    FileType displayFileType = currentFile.getFileType();
    String displayMediaType = getMediaType(displayFileType);
    String displayFilePath = currentFile.getPath();
    
    if (displayMediaType.equals("Video")){
      fileAsVideo = (Video)currentFile;
      volumeSlider.setValue(0.5);
      volumeSlider.setVisible(true);
      pausePlayButton.setVisible(true);
      media1 = new Movie(this, displayFilePath);
      media1.loop();
      media1.pause();
    }
    
    if (displayMediaType.equals("Photo")){
      media2 = loadImage(displayFilePath);
      dim = resize(media2.width, media2.height);
      media2.resize(dim[0],dim[1]);
    }
    
    if (displayMediaType.equals("Audio")){
      fileAsAudio = (Audio)currentFile;
      volumeSlider.setValue(0.5);
      volumeSlider.setVisible(true);
      pausePlayButton.setVisible(true);
      media3 = new SoundFile(this, displayFilePath);
      media3.loop();
      media3.pause();

    }
    if(displayMediaType.equals("Gif")){
      media4 = new Gif(this, displayFilePath);
      dim = resize(media4.width, media4.height);
      media4.loop();
    }
}

void createWindow(){  // this function will execute when the user presses "open"
    if (mediaWindow == null){
      mediaWindow = GWindow.getWindow(this, "mediaView", 0, 0, width, height, JAVA2D);
      mediaWindow.setActionOnClose(G4P.CLOSE_WINDOW);
      mediaWindow.addDrawHandler(this, "mediaWindowOpen");
      mediaWindow.addMouseHandler(this, "mediaWindowMouse");
      mediaWindow.addOnCloseHandler(this, "resetMedia");
      mediaWindow.loop();
      
      GButton nextMediaButton;
      nextMediaButton = new GButton(mediaWindow, width - (1/2.0)*buttonWidth, height/2, buttonHeight, buttonHeight);
      nextMediaButton.setText(">");
      nextMediaButton.addEventHandler(this, "nextMediaButtonClicked");
      
      GButton previousMediaButton;
      previousMediaButton = new GButton(mediaWindow, 0 +(1/2.0)*buttonWidth - buttonHeight, height/2, buttonHeight, buttonHeight);
      previousMediaButton.setText("<");
      previousMediaButton.addEventHandler(this, "previousMediaButtonClicked");
      
      pausePlayButton = new GButton(mediaWindow, (1/2.0)*buttonWidth, height - (3/2.0)*buttonHeight, (2/3.0)*buttonWidth, buttonHeight);
      pausePlayButton.setText("Play");
      pausePlayButton.addEventHandler(this, "pausePlayButtonClicked");
      pausePlayButton.setVisible(false);
     
      volumeSlider = new GSlider(mediaWindow, width - (1/2) * buttonWidth, height/2.0 + buttonWidth, buttonWidth *2, buttonWidth, buttonHeight*(1/2.0));
      volumeSlider.setRotation(PI/2, GControlMode.CORNER);
      volumeSlider.setLimits(0.5, 0.0, 1.0);
      volumeSlider.setNumberFormat(G4P.DECIMAL, 1);
      volumeSlider.addEventHandler(this, "volumeChanged");
      volumeSlider.setVisible(false);
    }
    changeWindow();
}

void deleteSelectedFile(){ // this function will execute when the user presses "delete"
    if (selectedIndex > 0){
        if (selectedIndex <= currentFolder.getFolders().size()){
            currentFolder.removeFolder(currentFolder.getFolders().get(selectedIndex - 1).getName());
        } else {
            selectedIndex -= currentFolder.getFolders().size();
            deleteDir(new File(currentFolder.getFiles().get(selectedIndex - 1).getPath()));
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
          if (mediaWindow == null){
            createWindow();
          }
        }
        
    } else {
        currentFolder = currentFolder.getParent();
    }
    selectedIndex = -1;
}

void renameSelectedItem(String newText){
    if (selectedIndex > 0){
        if (selectedIndex <= currentFolder.getFolders().size()){
            currentFolder.getFolders().get(selectedIndex - 1).rename(newText);
        } else {
            selectedIndex -= currentFolder.getFolders().size();
            MediaFile file = currentFolder.getFiles().get(selectedIndex - 1);
            currentFolder.renameFile(file.getName(), newText);
        }
        
    }
}
public void mediaWindowMouse(PApplet appc, GWinData data, MouseEvent mevent) {
  float mx = mevent.getX();
  float my = mevent.getY();
  float barX = buttonWidth + buttonHeight;
  float barY = height - (3.0/2.0) * buttonHeight;
  float barW = width - 2 * buttonWidth - buttonHeight;
  float barH = (2.0/3) * buttonHeight;
  if (getMediaType(currentFile.fileType) == "Video"){
    if (mevent.getAction() == MouseEvent.PRESS) {
      if (my > barY && my < barY + barH && mx > barX && mx < barX + barW) {
        dragging = true;
        updateVideo(int(mx));
      }
    }

    if (mevent.getAction() == MouseEvent.RELEASE) {
      dragging = false;
    }

    if (mevent.getAction() == MouseEvent.DRAG && dragging) {
      updateVideo(int(mx));
    }
  }
  if (getMediaType(currentFile.fileType) == "Audio"){
    if (mevent.getAction() == MouseEvent.PRESS) {
      if (my > barY && my < barY + barH && mx > barX && mx < barX + barW) {
        dragging = true;
        updateAudio(int(mx));
      }
    }

    if (mevent.getAction() == MouseEvent.RELEASE) {
      dragging = false;
    }

    if (mevent.getAction() == MouseEvent.DRAG && dragging) {
      updateAudio(int(mx));
    }
  }
}


synchronized public void mediaWindowOpen(PApplet appc, GWinData data) { //_CODE_:mediaWindow:247466:
    appc.background(230);
    FileType displayFileType = currentFile.getFileType();
    String displayMediaType = getMediaType(displayFileType);
    if (displayMediaType.equals("Video")){
      if (media1 != null && mediaWindow != null){
        mediaWindow.image(media1,  (width/2.0) - dim[0]/2.0, height/2.0 - dim[1]/2.0 - (1/2.0)*buttonHeight, dim[0], dim[1]);
        if(!dragging){
          fileAsVideo.progress = media1.time()/media1.duration();
        }
        mediaWindow.fill(255);
        mediaWindow.rect(buttonWidth + buttonHeight, height - (3/2.0)*buttonHeight, (width - 2*buttonWidth - buttonHeight), (2.0/3)*buttonHeight); 
        mediaWindow.fill(0,100,100);
        mediaWindow.rect(buttonWidth + buttonHeight, height - (3/2.0)*buttonHeight, (width - 2*buttonWidth - buttonHeight)*fileAsVideo.progress, (2.0/3)*buttonHeight);
      }
    }
    
    if (displayMediaType.equals("Photo")){
      if (media2 != null && mediaWindow != null){
        mediaWindow.image(media2, (width/2.0) - dim[0]/2.0, height/2.0 - dim[1]/2.0, dim[0], dim[1]);
      }
    }
    
    if(displayMediaType.equals("Audio")){
      if(media3 != null && mediaWindow != null){
        PImage img = loadImage("audio.png");
        mediaWindow.image(img, width/2.0 - (2/6.0)*img.width , height/2.0 - (2/6.0)*img.height, (2/3.0)*img.width, (2/3.0)*img.height);
        if(!dragging){
          fileAsAudio.progress = media3.position()/media3.duration();
        }
        mediaWindow.fill(255);
        mediaWindow.rect(buttonWidth + buttonHeight, height - (3/2.0)*buttonHeight, (width - 2*buttonWidth - buttonHeight), (2.0/3)*buttonHeight); 
        mediaWindow.fill(0,100,100);
        mediaWindow.rect(buttonWidth + buttonHeight, height - (3/2.0)*buttonHeight, (width - 2*buttonWidth - buttonHeight)*fileAsAudio.progress, (2.0/3)*buttonHeight);
      }
    }
    
    if(displayMediaType.equals("Gif")){
      if(media4 != null && mediaWindow != null){
        mediaWindow.image(media4, (width/2.0) - dim[0]/2.0, height/2.0 - dim[1]/2.0, dim[0], dim[1]);
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

} //_CODE_:mediaWindow:917051:

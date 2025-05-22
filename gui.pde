/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */
public void volumeChanged(GSlider source, GEvent event){
  //Because the bar is turn 90 degrees when you go up it lowers the value when you go down it lowers so the value is minused to inverse this affect
  if (getMediaType(currentFile.getFileType()).equals("Video")){
    fileAsVideo.changeVolume(1- volumeSlider.getValueF());
  }
  if (getMediaType(currentFile.getFileType()).equals("Audio")){
    fileAsAudio.changeVolume(1-volumeSlider.getValueF());
  }
}

public void previousMediaButtonClicked(GButton source, GEvent event){ //Before switching if the currentFile is a video or audio its media variable is paused and set to null
  if (displayIndex > 1){
     if (displayIndex > currentFolder.getFolders().size() + 1){//Folders come first in line and view folders in the media display they get skipped.
       if (getMediaType(currentFile.getFileType()).equals("Video")){
         fileAsVideo.paused = false;
         media1.pause();
         media1 = null;
       }
       if(getMediaType(currentFile.getFileType()).equals("Audio")){
          fileAsAudio.paused = false;
          media3.pause();
          media3 = null;
       }
       volumeSlider.setVisible(false);
       pausePlayButton.setVisible(false);
       displayIndex --; //moves file back unless its the very first file in the folder
       changeWindow(); 
     }
  }
}

public void nextMediaButtonClicked(GButton source, GEvent event){ //Before switching if the currentFile is a video or audio its media variable is paused and set to null
  if (displayIndex < currentFolder.getSize()){
    if(getMediaType(currentFile.getFileType()).equals("Video")){
      fileAsVideo.paused = false;
      media1.pause();
      media1 = null;
    }
    if(getMediaType(currentFile.getFileType()).equals("Audio")){
      fileAsAudio.paused = false;
      media3.pause();
      media3 = null;
    }
    //Make these disapear (they will reappear if there is a video or audio)
    volumeSlider.setVisible(false);
    pausePlayButton.setVisible(false);
    
    displayIndex ++; // moves up a file unless its the last one in the folder
    changeWindow();
   }
  } 
public void pausePlayButtonClicked(GButton source, GEvent event){
  if (getMediaType(currentFile.fileType) == ("Video")){
    fileAsVideo.paused = !fileAsVideo.paused; // takes the negative of what the paused feild is for the video file
    if (fileAsVideo.paused){ // if its true it pauses the file
      media1.pause();
      pausePlayButton.setText("Play");
    }
    else{ //plays file 
      media1.play();
      pausePlayButton.setText("Pause");
    }
  }
  if (getMediaType(currentFile.fileType) == ("Audio")){
    fileAsAudio.paused = !fileAsAudio.paused;
    if (fileAsAudio.paused){
      media3.pause();
      pausePlayButton.setText("Play");
    }
    else{
      media3.play();
      pausePlayButton.setText("Pause");
    }
  }
}

public void importFileClicked(GButton source, GEvent event) { //_CODE_:importFileButton:738052:
  importFile();
} //_CODE_:importFileButton:738052:

public void createNewFolderClicked(GButton source, GEvent event) { //_CODE_:NewFolder:822673:
  //checking for the lowest NewFolder# name that isn't used and names the new folder that name
  Boolean checking = true;
  int i = 1; 
  String n = "";
  if (currentFolder.getFolders().size() >0){
    i = 0;
    while (i <= currentFolder.getFolders().size() && checking){
      i ++;
      n = "New Folder" + (i);
      boolean nameInList = false;
      for (Folder f : currentFolder.getFolders()){
        if (n.equals(f.getName())){
          nameInList = true;
        }
      }
      if (!nameInList){
        checking = false;
      }
    }
  }
  else {
    n = "New Folder1";
  }
  
  currentFolder.addFolder(n);
} //_CODE_:NewFolder:822673:

public void nameChange(GTextField source, GEvent event) { //_CODE_:textfield1:322137:
  if (event == GEvent.ENTERED || event == GEvent.LOST_FOCUS){
    renameSelectedItem(fileRenamingField.getText());
    fileRenamingField.dispose();
    fileRenamingField = null;
  }
} //_CODE_:textfield1:322137:

public void searchChange(GTextField source, GEvent event) { //_CODE_:textfield1:322137:
  if (event == GEvent.ENTERED || event == GEvent.LOST_FOCUS){
    currentFolder.setKey(FileSortKey.SEARCH);
    currentFolder.sort();
    redraw();
  }
} //_CODE_:textfield1:322137:

public void sortByNameButtonClicked(GButton source, GEvent event){
  currentFolder.setKey(FileSortKey.NAME);
  currentFolder.sort();
  redraw();
}

public void sortByDateButtonClicked(GButton source, GEvent event){
  currentFolder.setKey(FileSortKey.DATE);
  currentFolder.sort();
  redraw();
}

public void renameButtonClicked(GButton source, GEvent event) { //_CODE_:NewFolder:822673:
  if (selectedIndex > 0){
    int yCoordinate = toolbarHeight + (selectedIndex * buttonHeight);
    fileRenamingField = new GTextField(this, buttonWidth * 2, yCoordinate, width - buttonWidth * 2, buttonHeight, G4P.SCROLLBARS_NONE);
    fileRenamingField.setOpaque(false);
    fileRenamingField.addEventHandler(this, "nameChange");
    fileRenamingField.setFocus(true);
  }
} //_CODE_:NewFolder:822673:

public void openMediaClicked(GButton source, GEvent event) { //_CODE_:OpenMedia:789457:
  openSelectedItem();
} //_CODE_:OpenMedia:789457:

public void deleteFileClicked(GButton source, GEvent event) { //_CODE_:button2:772053:
  deleteSelectedFile();
} //_CODE_:button2:772053:

// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.setInputFont("Arial", G4P.PLAIN, 14);
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  importFileButton = new GButton(this, width - buttonWidth * 5, buttonHeight / 2, buttonWidth, buttonHeight);
  importFileButton.setText("Import File");
  importFileButton.addEventHandler(this, "importFileClicked");

  // "New Folder" button
  newFolderButton = new GButton(this, width - buttonWidth * 4, buttonHeight / 2, buttonWidth, buttonHeight);
  newFolderButton.setText("New Folder");
  newFolderButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  newFolderButton.addEventHandler(this, "createNewFolderClicked");


  renameObjectButton = new GButton(this, width - buttonWidth * 3, buttonHeight / 2, buttonWidth, buttonHeight);
  renameObjectButton.setText("Rename");
  renameObjectButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  renameObjectButton.addEventHandler(this, "renameButtonClicked");
  
  // "Open file" button
  openMediaButton = new GButton(this, width - buttonWidth * 2, buttonHeight / 2, buttonWidth, buttonHeight);
  openMediaButton.setText("Open");
  openMediaButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  openMediaButton.addEventHandler(this, "openMediaClicked");


  // "Delete file" button
  deleteMediaButton = new GButton(this, width - buttonWidth, buttonHeight / 2, buttonWidth, buttonHeight);
  deleteMediaButton.setText("Delete");
  deleteMediaButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  deleteMediaButton.addEventHandler(this, "deleteFileClicked");

  //File search feild
  fileSearchingField = new GTextField(this, buttonWidth * 2, buttonHeight / 2, width - buttonWidth * 7, buttonHeight);
  fileSearchingField.setOpaque(false);
  fileSearchingField.addEventHandler(this, "searchChange");
  
  //Sort by name button
  sortByNameButton = new GButton(this,(.5)* buttonWidth, buttonWidth, buttonWidth, buttonHeight);
  sortByNameButton.setText("SortByName");
  sortByNameButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  sortByNameButton.addEventHandler(this, "sortByNameButtonClicked");
  
  //Sort by date button
  sortByDateButton = new GButton(this,(.5)* buttonWidth, (3/2.0)* buttonWidth, buttonWidth, buttonHeight);
  sortByDateButton.setText("SortByDate");
  sortByDateButton.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  sortByDateButton.addEventHandler(this, "sortByDateButtonClicked");
}

// Variable declarations 
// autogenerated do not edit
GButton sortByNameButton;
GButton sortByDateButton;
GSlider volumeSlider;
GButton importFileButton; 
GButton renameObjectButton; 
GButton newFolderButton; 
GButton openMediaButton; 
GButton deleteMediaButton; 
GTextField fileRenamingField;
GTextField fileSearchingField;

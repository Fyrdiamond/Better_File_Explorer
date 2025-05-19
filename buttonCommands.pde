GWindow MediaWindow;

void createWindow(){  // this function will execute when the user presses "open"

    
    MediaWindow = GWindow.getWindow(this, "mediaView", 0, 0, 500, 500, JAVA2D);
    MediaWindow.setActionOnClose(G4P.CLOSE_WINDOW);
    MediaWindow.noLoop();
    MediaWindow.addDrawHandler(this, "mediaWindowOpen");
    MediaWindow.addOnCloseHandler(this, "resetMedia");
    MediaWindow.loop();
}



void deleteSelectedFile(){ // this function will execute when the user presses "delete"
  if (currentFile != null){
    currentFolder.files.remove(currentFile);
    
    for (MediaFile f: currentFolder.files){
        f.LabelYCoord = (currentFolder.files.indexOf(f) * 30) + toolbarHeight;
        f.FileLabel.moveTo(f.LabelXCoord, f.LabelYCoord);
    }
    
    currentFile.FileLabel.dispose();
    currentFile = null;
    
  } 
  this.redraw();
}

synchronized public void mediaWindowOpen(PApplet appc, GWinData data) { //_CODE_:MediaWindow:247466:
  appc.background(230);
  /*
  if (img != null && MediaWindow != null){
    MediaWindow.image(img, 0, 0);
  }
  */
} //_CODE_:MediaWindow:247466:

public void resetMedia(GWindow window) { //_CODE_:MediaWindow:917051:
  println("MediaWindow - window closed at " + millis());
  //img = null;
} //_CODE_:MediaWindow:917051:
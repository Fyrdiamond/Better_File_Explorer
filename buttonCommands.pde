GWindow MediaWindow;

void createWindow(){  // this function will execute when the user presses "open"

    
    MediaWindow = GWindow.getWindow(this, "mediaView", 0, 0, 500, 500, JAVA2D);
    MediaWindow.setActionOnClose(G4P.CLOSE_WINDOW);
    MediaWindow.addDrawHandler(this, "mediaWindowOpen");
    MediaWindow.addOnCloseHandler(this, "resetMedia");
    MediaWindow.loop();
}

void deleteSelectedFile(){ // this function will execute when the user presses "delete"
    if (selectedIndex > 0){
        if (selectedIndex < currentFolder.getFolders().size()){
            currentFolder.removeFolder(currentFolder.getFolders().get(selectedIndex).getName());
        } else {
            selectedIndex -= currentFolder.getFolders().size();
            currentFolder.removeFile(currentFolder.getFiles().get(selectedIndex));
        }
        selectedIndex = -1;
    }
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

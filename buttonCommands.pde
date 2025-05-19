GWindow mediaWindow;

void createWindow(){  // this function will execute when the user presses "open"

    
    mediaWindow = GWindow.getWindow(this, "mediaView", 0, 0, 500, 500, JAVA2D);
    mediaWindow.setActionOnClose(G4P.CLOSE_WINDOW);
    mediaWindow.addDrawHandler(this, "mediaWindowOpen");
    mediaWindow.addOnCloseHandler(this, "resetMedia");
    mediaWindow.loop();
}

void deleteSelectedFile(){ // this function will execute when the user presses "delete"
    if (selectedIndex > 0){
        if (selectedIndex < currentFolder.getFolders().size()){
            currentFolder.removeFolder(currentFolder.getFolders().get(selectedIndex - 1).getName());
        } else {
            selectedIndex -= currentFolder.getFolders().size();
            currentFolder.removeFile(currentFolder.getFiles().get(selectedIndex - 1));
        }
        selectedIndex = -1;
    }
}

synchronized public void mediaWindowOpen(PApplet appc, GWinData data) { //_CODE_:mediaWindow:247466:
    appc.background(230);
    /*
    if (img != null && mediaWindow != null){
      mediaWindow.image(img, 0, 0);
    }
    */
} //_CODE_:mediaWindow:247466:

public void resetMedia(GWindow window) { //_CODE_:mediaWindow:917051:
    println("mediaWindow - window closed at " + millis());
    //img = null;
} //_CODE_:mediaWindow:917051:

enum FileType {
    JPEG,
    TIF,
    JPG,
    PNG,
    TIFF,
    BMP,
    WBMP,
    GIF,
    MP4,
    MOV,
    MP3,
    WAV;
}

String [] Photos = {"JPG", "PNG", "TIFF", "BMP", "WBMP", "GIF"};
String [] Videos = {"MP4", "MOV"};
String [] Audios = {"MP3", "WAV"};

class MediaFile{
    //FEILDS
    String name;
    Date date;
    FileType fileType;
    GLabel FileLabel;
    int LabelYCoord;
    int LabelXCoord;

    //CONSTRUCTOR
    MediaFile(String n, Date d, FileType t){
        this.name = n;
        this.date = d;
        this.fileType = t;
        this.CreateLabel();
        currentFolder.addFile(this);
    }

    //METHODS
    String getName(){
        return this.name;
    }  

    Date getDate(){
        return this.date;
    }

    FileType getFileType(){
        return fileType;
    }

    void CreateLabel(){
      LabelYCoord = ((currentFolder.files.size() + currentFolder.folders.size()) * 30) + toolbarHeight;
      LabelXCoord = buttonWidth * 2; 
      FileLabel = new GLabel(MainScreen, LabelXCoord, LabelYCoord, 305, 20);
      FileLabel.setText(this.name);
      FileLabel.setFont(new Font("Dialog", Font.PLAIN, 14));
      FileLabel.setOpaque(true);
    }
}

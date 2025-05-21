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
    MP3,
    WAV;
}

String[] PHOTOS = {"JPG", "PNG", "TIFF", "BMP", "WBMP", "GIF"};
String[] VIDEOS = {"MP4"};
String[] AUDIOS = {"MP3", "WAV"};

class MediaFile{
    //FEILDS
    String name;
    Date date;
    FileType fileType;
    String path;

    //CONSTRUCTOR
    MediaFile(String n, Date d, FileType t, String p){
        this.name = n;
        this.date = d;
        this.fileType = t;
        this.path = p;
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
    
    void setName(String n){
      this.name = n;
    }
    
    String getPath(){
      return this.path;
    }
}

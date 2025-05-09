enum FileType {
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

class MediaFile{
    //FEILDS
    String name;
    Date date;
    FileType fileType;

    //CONSTRUCTOR
    MediaFile(String n, Date d, FileType t){
        this.name = n;
        this.date = d;
        this.fileType = t;
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
}

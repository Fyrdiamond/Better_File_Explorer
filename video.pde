class Video extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    Movie file;

    //CONSTUCTOR
    Video(String n, Date d, FileType t, String p){
        super(n,  d,  t, p);
        this.volume = 100;
        this.paused = true;

    } 
}

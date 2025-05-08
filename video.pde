class Video extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;

    //CONSTUCTOR
    Video(String n, Date d, FileType f){
        super(n,  d,  f);
        this.volume = 100;
        this.paused = True;
    } 
}
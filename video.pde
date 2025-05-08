class Video extends MediaFile {
    boolean paused;
    float volume;

    Video(String n, Date d, FileType f){
        super(n,  d,  f);
        this.volume = 100;
        this.paused = True;
    }

    
}
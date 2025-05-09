class Video extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    Movie file;

    //CONSTUCTOR
    Video(String n, Date d, FileType t, Movie m){
        super(n,  d,  t);
        this.volume = 100;
        this.paused = true;
        this.file = m;
    } 
}

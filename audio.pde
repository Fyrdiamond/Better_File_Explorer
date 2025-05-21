class Audio extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    float progress;
    SoundFile file;
    int timeStarted;
    //CONSTUCTOR
    Audio(String n, Date d, FileType t, String p){
        super(n,  d,  t, p);
        this.volume = 100;
        this.paused = true;
        this.progress = 0;
        this.timeStarted = millis();
    }     
}

class Audio extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    SoundFile file;

    //CONSTUCTOR
    Audio(String n, Date d, FileType t, String p){
        super(n,  d,  t, p);
        this.volume = 100;
        this.paused = true;
    } 
}

class Audio extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    SoundFile file;

    //CONSTUCTOR
    Audio(String n, Date d, FileType t, SoundFile s){
        super(n,  d,  t);
        this.volume = 100;
        this.paused = true;
        this.file = s;
    } 
    void play(){
        this.file.play();
    }
}

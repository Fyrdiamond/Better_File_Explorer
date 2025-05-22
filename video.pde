class Video extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    float progress = 0;

    //CONSTUCTOR
    Video(String n, Date d, FileType t, String p){
        super(n,  d,  t, p);
        this.volume = .5;
        this.paused = true;
    } 
    void changeVolume(float v){
      this.volume = v;
      media1.volume(this.volume);
    }
}

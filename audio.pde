class Audio extends MediaFile {
    //FEILDS
    boolean paused;
    float volume;
    float progress;

    //CONSTUCTOR
    Audio(String n, Date d, FileType t, String p){
        super(n,  d,  t, p);
        this.volume = .5;
        this.paused = true;
        this.progress = 0;
    }     
    
    void changeVolume(float v){
      print("madeIt");
      this.volume = v;
      media3.amp(this.volume);
    }
}

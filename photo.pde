class Photo extends MediaFile{
    //CONSTRUCTOR
    PImage file;
    Photo(String n, Date d, FileType t, PImage i){
        super(n,  d,  t);  
        file = i;
    } 
    void display(){
        image(file, 0, 0);        
    }
}

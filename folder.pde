class Folder {
    String name;
    ArrayList<MediaFile> files;
    ArrayList<Folder> folders;

    Folder(String name) {
        this.name = name;
        this.files = new ArrayList<File>();
        this.folders = new ArrayList<Folder>();
    }
}

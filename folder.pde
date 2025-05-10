class Folder {
    String name;
    ArrayList<MediaFile> files;
    ArrayList<Folder> folders;

    Folder(String name) {
        this.name = name;
        this.files = new ArrayList<MediaFile>();
        this.folders = new ArrayList<Folder>();
    }

    ArrayList<Folder> getFolders() {
        return this.folders;
    }

    ArrayList<MediaFile> getFiles() {
        return this.files;
    }

    String getName() {
        return this.name;
    }

    int getSize() {
        return this.files.size() + this.folders.size();
    }

    boolean isEmpty() {
        return (this.files.size() + this.folders.size()) == 0;
    }

    void addFile(MediaFile file) {
        this.files.add(file);
    }

    void removeFile(MediaFile file) {
        this.files.remove(file);
    }
}

enum FileSortKey {
    NAME,
    DATE,
    SEARCH;
}

class RootFolder {
    private RootFolder parent;

    private String name;
    private ArrayList<MediaFile> files;
    private ArrayList<Folder> folders;

    private FileSortKey key;

    RootFolder(String name) {
        this.parent = this;
        this.name = name;
        this.files = new ArrayList<MediaFile>();
        this.folders = new ArrayList<Folder>();
        this.key = FileSortKey.NAME;
    }

    ArrayList<Folder> getFolders() {
        return this.folders;
    }

    Folder getFolder(String name) {
        for (Folder folder : this.folders) {
            if (folder.getName().equals(name)) {
                return folder;
            }
        }
        throw new IllegalArgumentException();
    }

    ArrayList<MediaFile> getFiles() {
        return this.files;
    }

    MediaFile getFile(String name) {
        for (MediaFile file : this.files) {
            if (file.getName().equals(name)) {
                return file;
            }
        }
        throw new IllegalArgumentException();
    }

    String getPath() {
        return File.separator;
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

    void sort() {
        this.sort(this.files);
    }

    void sort(ArrayList<MediaFile> list) {
        int s = list.size();
        if (s == 1) return;

        int first = 0;
        int last = s;
        int mid = last << 1;

        ArrayList<MediaFile> l1 = new ArrayList<MediaFile>(mid - first);
        ArrayList<MediaFile> l2 = new ArrayList<MediaFile>(last - mid);

        for (int i = 0; i < mid; i++) {
            l1.add(i, list.get(i));
        }

        for (int i = mid; i < last; i++) {
            l2.add(i - mid, list.get(i));
        }

        list = merge(l1, l2);
    }

    ArrayList<MediaFile> merge(ArrayList<MediaFile> list1, ArrayList<MediaFile> list2) {
        int size1 = list1.size();
        int size2 = list2.size();

        ArrayList<MediaFile> resultList = new ArrayList<MediaFile>(size1 + size2);

        MediaFile file1 = list1.get(0);
        MediaFile file2 = list2.get(0);

        while (size1 > 0 & size2 > 0) {
            if (fileComesBefore(file1, file2)) {
                resultList.add(file1);
                list1.remove(0);
                size1--;
                file1 = list1.get(0);
            } else {
                resultList.add(file2);
                list2.remove(0);
                size2--;
                file1 = list2.get(0);
            }
        }

        while (size1 > 0) {
            resultList.add(file1);
            list1.remove(0);
            size1--;
            file1 = list1.get(0);
        }

        while (size2 > 0) {
            resultList.add(file2);
            list2.remove(0);
            size2--;
            file1 = list2.get(0);
        }

        return resultList;
    }

    boolean fileComesBefore(MediaFile file1, MediaFile file2) {
        switch (this.key) {
            case NAME:
                return file1.getName().compareTo(file2.getName()) == -1;
            case DATE:
                return file1.getDate().compareTo(file2.getDate()) == -1;
            default:
                throw new UnsupportedOperationException();
        }
    }

    void setKey(FileSortKey key) {
        this.key = key;
    }

    void setParent(RootFolder parent) {
        this.parent = parent;
    }

    RootFolder getParent() {
        return this.parent;
    }

    void addFile(MediaFile file) {
        this.files.add(file);
    }

    void removeFile(MediaFile file) {
        this.files.remove(file);
    }

    void addFolder(String name) {
        this.folders.add(new Folder(this, name));
    }

    void removeFolder(String name) {
        for (Folder folder : this.folders) {
            if (folder.getName().equals(name)) {
                this.folders.remove(folder);
                break;
            }
        }
    }
}

class Folder extends RootFolder {
    Folder(RootFolder parent, String name) {
        super(name);
        this.setParent(parent);
    }

    String getPath() {
        return this.getParent().getPath() + this.getName() + File.separator;
    }
}

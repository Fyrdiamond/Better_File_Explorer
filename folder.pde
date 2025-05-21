enum FileSortKey {
    NAME,
    DATE,
    SEARCH;
}

class Folder {
    private Folder parent;

    private String name;
    private ArrayList<MediaFile> files;
    private ArrayList<Folder> folders;

    private FileSortKey key;

    Folder(String name) {
        this.parent = this; // Root folder points to itself as parent
        this.name = name;
        this.files = new ArrayList<MediaFile>();
        this.folders = new ArrayList<Folder>();
        this.key = FileSortKey.NAME;
    }

    Folder(String name, Folder parent) {
        this.parent = parent;
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
        return this.parent == this ? File.separator : this.parent.getPath() + this.name + File.separator;
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
        this.files = this.sort(this.files);
    }

    ArrayList<MediaFile> sort(ArrayList<MediaFile> list) {
        int s = list.size();
        if (s == 1) return list;

        int first = 0;
        int last = s;
        int mid = last >> 1;

        ArrayList<MediaFile> l1 = new ArrayList<MediaFile>(mid - first);
        ArrayList<MediaFile> l2 = new ArrayList<MediaFile>(last - mid);

        for (int i = 0; i < mid; i++) {
            l1.add(i, list.get(i));
        }

        for (int i = mid; i < last; i++) {
            l2.add(i - mid, list.get(i));
        }

        l1 = sort(l1);
        l2 = sort(l2);
        
        list = merge(l1, l2);
        return list;
    }

    ArrayList<MediaFile> merge(ArrayList<MediaFile> list1, ArrayList<MediaFile> list2) {
        int size1 = list1.size();
        int size2 = list2.size();

        ArrayList<MediaFile> resultList = new ArrayList<MediaFile>(size1 + size2);
        int numCombined = 0;
        MediaFile file1 = list1.get(0);
        MediaFile file2 = list2.get(0);

        while (size1 > 0 & size2 > 0) {
            if (fileComesBefore(file1, file2)) {
                resultList.add(numCombined, file1);
                list1.remove(0);
                size1--;
                if (size1 > 0){
                    file1 = list1.get(0);
                }
            } else {
                resultList.add(numCombined, file2);
                list2.remove(0);
                size2--;
                if (size2 > 0){
                    file2 = list2.get(0);
                }
            }
            numCombined++;
        }
        
        while (size1 > 0) {
            resultList.add(file1);
            list1.remove(0);
            size1--;
            if (size1 > 0){
                file1 = list1.get(0);
            }
        }

        while (size2 > 0) {
            resultList.add(file2);
            list2.remove(0);
            size2--;
            if (size2 > 0){
                file2 = list2.get(0);
            }
        }

        return resultList;
    }

    boolean fileComesBefore(MediaFile file1, MediaFile file2) {
        switch (this.key) {
            case NAME:
                return !(file2.getName().compareTo(file1.getName()) == -1);
            case DATE:
                return !(file2.getDate().compareTo(file1.getDate()) == -1);
            case SEARCH:
                String searchKey = fileSearchingField.getText();
                return !(search(file1.getName(), searchKey) < search(file2.getName(), searchKey));
            default:
                throw new UnsupportedOperationException();
        }
    }

    void rename(String newName) {
        if (this.getParent() != this) {
            String name = this.getName();
            Path oldPath = Paths.get(dataPath("") + this.getPath() + File.separator);
            Path newPath = Paths.get(dataPath("") + this.getParent().getPath() + newName + File.separator);
            if (newPath.toFile().exists()) {
                return;
            }
            try {
                Files.copy(oldPath, newPath, StandardCopyOption.REPLACE_EXISTING);
                deleteDir(oldPath.toFile());
                this.setName(newName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void setName(String name) {
        this.name = name;
    }

    void setKey(FileSortKey key) {
        this.key = key;
    }

    void setParent(Folder parent) {
        this.parent = parent;
    }

    Folder getParent() {
        return this.parent;
    }

    void addFile(MediaFile file) {
        this.files.add(file);
    }

    void removeFile(MediaFile file) {
        this.files.remove(file);
    }

    void addFolder(String name) {
        this.folders.add(new Folder(name, this));
        new File(dataPath("") + this.getPath() + name + File.separator).mkdir();
    }

    void removeFolder(String name) {
        for (Folder folder : this.folders) {
            if (folder.getName().equals(name)) {
                deleteDir(new File(dataPath("") + this.getPath() + name + File.separator));
                this.folders.remove(folder);
                break;
            }
        }
    }

    void loadExistingData() {
        File folder = new File(dataPath("") + this.getPath());
        if (folder.listFiles() != null){
            for (File file : folder.listFiles()) {
                if (file.isDirectory()) {
                    this.addFolder(file.getName());
                    this.getFolder(file.getName()).loadExistingData();
                } else {
                    Folder tempCurrentFolder = currentFolder;
                    currentFolder = this;
                    FileSelected(file);
                    currentFolder = tempCurrentFolder;
                }
            }
        }
        
    }
}

void deleteDir(File file) {
    File[] contents = file.listFiles();
    if (contents != null) {
        for (File f : contents) {
            deleteDir(f);
        }
    }
    file.delete();
}

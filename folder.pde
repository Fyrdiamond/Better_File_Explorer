enum FileSortKey {
    NAME,
    DATE
}

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

    ArrayList<MediaFile> getRecursiveSortedFiles(FileSortKey key) {
        ArrayList<MediaFile> result = new ArrayList<MediaFile>();
        int i = 0;
        for (Folder folder : this.folders) {
            result = mergeFiles(folder.getRecursiveSortedFiles(key), result, key);
        }
        return mergeFiles(result, this.getSortedFiles(key), key);
    }

    ArrayList<MediaFile> getSortedFiles(FileSortKey key) {
        return sortFiles(this.files, key);
    }

    ArrayList<MediaFile> sortFiles(ArrayList<MediaFile> files, FileSortKey key) {
        int halfsize = files.size() << 1;
        if (halfsize == 0) {
            return files;
        }

        ArrayList<MediaFile> list1 = new ArrayList<MediaFile>();
        ArrayList<MediaFile> list2 = new ArrayList<MediaFile>();
        int i = 0;
        for (MediaFile file : files) {
            if (i++ < halfsize) {
                list1.add(file);
            } else {
                list2.add(file);
            }
        }

        return mergeFiles(list1, list2, key);
    }

    ArrayList<MediaFile> mergeFiles(ArrayList<MediaFile> list1, ArrayList<MediaFile> list2, FileSortKey key) {
        ArrayList<MediaFile> result = new ArrayList<MediaFile>();
        int i = list1.size();
        int j = list2.size();
        while (i > 0 & j > 0) {
            if (fileComesBefore(list1.get(0), list2.get(0), key)) {
                result.add(list1.get(0));
                list1.remove(0);
                i--;
            } else {
                result.add(list2.get(0));
                list2.remove(0);
                j--;
            }
        }
        while (i > 0) {
            for (MediaFile file : list1) {
                result.add(file);
            }
            i--;
        }
        while (j > 0) {
            for (MediaFile file : list2) {
                result.add(file);
            }
            j--;
        }

        return result;
    }

    boolean fileComesBefore(MediaFile file1, MediaFile file2, FileSortKey key) {
        switch (key) {
            case NAME:
                return file1.getName().compareTo(file2.getName()) == -1;
            case DATE:
                return file1.getDate().compareTo(file2.getDate()) == -1;
            default:
                throw new UnsupportedOperationException();
        }
    }

    void addFile(MediaFile file) {
        this.files.add(file);
    }

    void removeFile(MediaFile file) {
        this.files.remove(file);
    }

    void addFolder(String name) {
        this.folders.add(new Folder(name));
        println("Created new folder:", name);
    }

    void removeFolder(String name) {
        for (Folder folder : this.folders) {
            if (folder.getName().equals(name)) {
                this.folders.remove(folder);
                println("Removed folder:", name);
                break;
            }
        }
    }
}

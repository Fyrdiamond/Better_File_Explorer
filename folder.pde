enum FileSortKey {
    NAME,
    DATE,
    SEARCH;
}

class Folder {
    // Parent folder to go up folders or get the path
    private Folder parent;

    // Information used to reference this folder and those under it
    private String name;
    private ArrayList<MediaFile> files;
    private ArrayList<Folder> folders;

    // Key used when sorting files
    private FileSortKey key;
    Folder(String name) {
        // Constructor for if folder doesn't have a parent
        this.parent = this;
        this.name = name;
        this.files = new ArrayList<MediaFile>();
        this.folders = new ArrayList<Folder>();
        this.key = FileSortKey.NAME;
    }

    Folder(String name, Folder parent) {
        // Constructor for if folder has a parent
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
        // Searches for a folder with the given name
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
        // Searches for a file with the given name
        for (MediaFile file : this.files) {
            if (file.getName().equals(name)) {
                return file;
            }
        }
        throw new IllegalArgumentException();
    }

    String getPath() {
        // If this folder is the root, returns the root path
        // Otherwise, returns this folder's parent's path + this folder's name
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
        // Sorts the list of files using merge sort

        // If the list has one element, it is sorted
        int s = list.size();
        if (s == 1) return list;

        // Get the points to split the list into two
        int first = 0;
        int last = s;
        int mid = last >> 1;

        // Create two new lists to hold the split lists
        ArrayList<MediaFile> l1 = new ArrayList<MediaFile>(mid - first);
        ArrayList<MediaFile> l2 = new ArrayList<MediaFile>(last - mid);

        for (int i = 0; i < mid; i++) {
            l1.add(i, list.get(i));
        }

        for (int i = mid; i < last; i++) {
            l2.add(i - mid, list.get(i));
        }

        // Recursively sort the two lists
        l1 = sort(l1);
        l2 = sort(l2);

        // Merge the sorted lists back together
        list = merge(l1, l2);
        return list;
    }

    ArrayList<MediaFile> merge(ArrayList<MediaFile> list1, ArrayList<MediaFile> list2) {
        // Merges two sorted lists into one sorted list

        // Keep track of the size of the two lists
        int size1 = list1.size();
        int size2 = list2.size();

        // Keep track of the size of the merged list
        int numCombined = 0;

        ArrayList<MediaFile> resultList = new ArrayList<MediaFile>(size1 + size2);

        // Keep track of the current file in each list
        MediaFile file1 = list1.get(0);
        MediaFile file2 = list2.get(0);

        // While there are files in both lists, compare the two and add the one that comes first
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

        // If one of the lists is empty, add the rest of the other list to the merged list
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

        // Return the merged list
        return resultList;
    }

    boolean fileComesBefore(MediaFile file1, MediaFile file2) {
        // Compares two files based on the current sort key
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
        // Renames the folder and moves it to the new location

        // If the folder is the root, ignore it
        if (this.getParent() != this) {
            // Get the path to the current name and the path to the new name
            String name = this.getName();
            Path oldPath = Paths.get(dataPath("") + this.getPath() + File.separator);
            Path newPath = Paths.get(dataPath("") + this.getParent().getPath() + newName + File.separator);
            // If the new path already exists, stop
            if (newPath.toFile().exists()) {
                return;
            }
            try {
                // Copy the folder to the new location and delete the old one
                Files.copy(oldPath, newPath, StandardCopyOption.REPLACE_EXISTING);
                deleteDir(oldPath.toFile());
                // Set the new name
                this.setName(newName);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    void renameFile(String oldName, String newName) {
        // Renames the file and moves it to the new location
        for (MediaFile file : this.files) {
            if (file.getName().equals(oldName)) {
                // If the new name doesn't have the same ending, add it
                String fileEnding = oldName.substring(oldName.lastIndexOf("."));
                if (!newName.endsWith(fileEnding)) {
                    newName += fileEnding;
                }
                // Get the path to the current name and the path to the new name
                Path oldPath = Paths.get(dataPath("") + this.getPath() + oldName);
                Path newPath = Paths.get(dataPath("") + this.getPath() + newName);
                // If the new path already exists, stop
                if (newPath.toFile().exists()) {
                    return;
                }
                try {
                    // Copy the file to the new location and delete the old one
                    Files.copy(oldPath, newPath, StandardCopyOption.REPLACE_EXISTING);
                    deleteDir(oldPath.toFile());
                    // Set the new name
                    file.setName(newName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
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
        // Create the folder in the file system and add it to the list of folders
        this.folders.add(new Folder(name, this));
        new File(dataPath("") + this.getPath() + name + File.separator).mkdir();
    }

    void removeFolder(String name) {
        // Remove the folder from the file system and from the list of folders
        for (Folder folder : this.folders) {
            if (folder.getName().equals(name)) {
                deleteDir(new File(dataPath("") + this.getPath() + name + File.separator));
                this.folders.remove(folder);
                break;
            }
        }
    }

    void loadExistingData() {
        // Load the existing data from the file system

        // Get the path to this folder
        File folder = new File(dataPath("") + this.getPath());
        if (folder.listFiles() != null){
            for (File file : folder.listFiles()) {
                //For every file in this folder
                if (file.isDirectory()) {
                    //If the file is a folder, add it to list
                    this.addFolder(file.getName());

                    //Load the data from the folder
                    this.getFolder(file.getName()).loadExistingData();
                } else {
                    //If the file is a file, add it to the list of files
                    Folder tempCurrentFolder = currentFolder;
                    //Load the file data
                    currentFolder = this;
                    FileSelected(file);
                    currentFolder = tempCurrentFolder;
                }
            }
        }
    }
}

void deleteDir(File file) {
    // Deletes a directory and all of its contents

    // Get the contents of the directory
    File[] contents = file.listFiles();
    if (contents != null) {
        // If the directory is not empty, delete all of its contents
        for (File f : contents) {
            deleteDir(f);
        }
    }
    // Delete the directory itself
    file.delete();
}

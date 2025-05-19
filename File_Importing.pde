void importFile(){ // Function to import file from the user's device.
    selectInput("Select a file to process:", "FileSelected");
}

void FileSelected(File chosenFile){ // function that runs once the user selects a file.
    if (chosenFile != null){
        // Finding the string of the chosen file location.
        String path = chosenFile.getAbsolutePath();
        String fileName = chosenFile.getName();

        // Finding the last Modified Date
        Date fileModifiedDate = new Date(chosenFile.lastModified());

        // Converting the string into an enum from our list of file format enums.
        String fileTypeString= path.substring(path.lastIndexOf(".") + 1).toUpperCase();
        FileType type = FileType.valueOf(fileTypeString);

        // Test print statements
        println(fileModifiedDate);
        println(chosenFile.getName());
        println(type.valueOf(fileTypeString));
        // Creating a file from the MediaFile class
        for (String fileT : PHOTOS){
            if (fileTypeString.equals(fileT)){
                PImage file = loadImage(path);
                Photo newFile = new Photo(fileName, fileModifiedDate, type, file);
                newFile.display();
                addFileToCurrentFolder(path, fileName);
            }
        }

        for (String fileT : VIDEOS){
            if (fileTypeString.equals(fileT)){
                Movie file = new Movie (this, path);
                Video newFile = new Video(fileName, fileModifiedDate, type, file);
                addFileToCurrentFolder(path, fileName);
            }
        }

        for (String fileT : AUDIOS){
            if (fileTypeString.equals(fileT)){
                SoundFile file = new SoundFile(this, path);
                Audio newFile = new Audio(fileName, fileModifiedDate, type, file);
                addFileToCurrentFolder(path, fileName);
            }
        }
    }
}

void addFileToCurrentFolder(String path, String name) {
    Path src = Paths.get(path);
    Path dst = Paths.get(dataPath("") + currentFolder.getPath() + name);
    try {
        Files.copy(src, dst, StandardCopyOption.REPLACE_EXISTING);
    } catch (IOException e) {
        e.printStackTrace();
    }
}

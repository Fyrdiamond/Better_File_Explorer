import java.util.Date;
import processing.video.*;
import processing.sound.*;
import g4p_controls.*;

ArrayList<MediaFile> mediaFileList = new ArrayList<MediaFile>();

Stack<Folder> folderPath = new Stack<Folder>();

void importFile(){ // Function to import file from the user's device.
    selectInput("Select a file to process:", "FileSelected");
}

void FileSelected(File chosenFile){ // function that runs once the user selects a file.
    if (chosenFile != null){
        // Finding the string of the chosen file location.
        String path = chosenFile.getAbsolutePath();
        String FileName = chosenFile.getName();

        // Finding the last Modified Date
        Date fileModifiedDate = new Date(chosenFile.lastModified());

        // Converting the string into an enum from our list of file format enums.
        String fileTypeString= path.substring(path.lastIndexOf(".") + 1).toUpperCase();
        FileType MediaFileType = FileType.valueOf(fileTypeString);

        // Test print statements
        println(fileModifiedDate);
        println(chosenFile.getName());
        println("the file type is:", MediaFileType);
        println (MediaFileType.valueOf(fileTypeString));
        // Creating a file from the MediaFile class
        for (String fileT : Photos){
            if (fileTypeString.equals(fileT)){
                PImage file = loadImage(path);
                Photo newFile = new Photo(FileName, fileModifiedDate, MediaFileType, file);
                print("this is a photo");
                newFile.display();
            }
        }

        for (String fileT : Videos){
            if (fileTypeString.equals(fileT)){
                Movie file = new Movie (this, path);
                Video newFile = new Video(FileName, fileModifiedDate, MediaFileType, file);
                print("this is a video");
            }
        }

        for (String fileT : Audios){
            if (fileTypeString.equals(fileT)){
                SoundFile file = new SoundFile(this, path);
                Audio newFile = new Audio(FileName, fileModifiedDate, MediaFileType, file);
                print("this is a audio");
            }
        }
    }
}

void setup() {
    size(1000, 700);
    background(0);
    folderPath.push(new Folder("Library"));
    importFile();
}

void draw() {}

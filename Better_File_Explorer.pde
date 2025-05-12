import java.util.Date;
import processing.video.*;

ArrayList<MediaFile> mediaFileList = new ArrayList<MediaFile>();

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
        FileType MediaFileType = FileType.valueOf(path.substring(path.lastIndexOf(".") + 1).toUpperCase());

        // Test print statements
        println(fileModifiedDate);
        println(chosenFile.getName());
        println("the file type is:", MediaFileType); 
        
        // Creating a file from the MediaFile class
        MediaFile newFile = new MediaFile(FileName, fileModifiedDate, MediaFileType);
    }
}

void setup() {
    size(500,500);
    background(0);
    importFile();
}

void draw() {}

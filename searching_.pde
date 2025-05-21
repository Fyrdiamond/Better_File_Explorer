Float search(String s1, String s2){
  //string lists for the 3 character chunks
  ArrayList <String> s1Chunks = new ArrayList<String>();
  ArrayList <String> s2Chunks = new ArrayList<String>();
  ArrayList <String> chunks = new ArrayList<String>();
  
  //Dividing up each string into 3 character chunks and adding all unique chunks to a list
  for (int i = 0; i <= s1.length() - 3; i++){
    String chunk = s1.substring(i, i + 3);
    s1Chunks.add(chunk);
    chunks.add(chunk);
  }
  String chunk;
  for (int i = 0; i <= s2.length() - 3; i++){
    chunk = s2.substring(i, i + 3);
    s2Chunks.add(chunk);
    for (String s: chunks){
      if (chunk.equals(s)){
        chunk = " ";
      }
    }
    if (chunk != " "){
      chunks.add(chunk);
    }
  }
  
  //two int arrays the length of the unique chunk list
  int[] s1Values = new int[chunks.size()];
  int[] s2Values = new int[chunks.size()];
  
  //Every chunk in the unique chunk list is checked and seen how many are in each string. 
  //That value is added to the same index slot for the value lists.
  for (int x = 0; x < chunks.size(); x ++){ 
    int n = 0;
   
    for (String s: s1Chunks){
      if (s.equals(chunks.get(x))){
        n ++;
      }
    }
    s1Values[x] = n;
    
    n = 0;
    for (String s: s2Chunks){
      if (s.equals(chunks.get(x))){
        n ++;
      }
    }
    s2Values[x] = n;
  }
  
  //all of the variables for the cosine difference equation
  float s1dots2 = 0;
  float s1ValuesSquares = 0;
  float s2ValuesSquares = 0;
  
  //gets the number for these values
  for (int x = 0; x < chunks.size(); x ++){
    s1dots2 += s2Values[x] * s1Values[x];
    s1ValuesSquares += pow(s1Values[x],2);
    s2ValuesSquares += pow(s2Values[x],2);
  }
  //the equation and return the value
  float cosDifValue = (float)(s1dots2)/(sqrt(s1ValuesSquares)*sqrt(s2ValuesSquares));
  return cosDifValue;
}

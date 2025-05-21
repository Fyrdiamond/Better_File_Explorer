Float search(String s1, String s2){
  int i = 0; 
  ArrayList <String> s1Chunks = new ArrayList<String>();
  ArrayList <String> s2Chunks = new ArrayList<String>();
  ArrayList <String> chunks = new ArrayList<String>();
  
  while (i <= s1.length() - 3){
    String chunk = s1.substring(i, i + 3);
    s1Chunks.add(chunk);
    chunks.add(chunk);
    i ++;
  }
  
  i = 0;
  String chunk;
  while (i <= s2.length() - 3){
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
    i++;
  }
  
  int[] s1Values = new int[chunks.size()];
  int[] s2Values = new int[chunks.size()];
  
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
  
  float s1dots2 =0;
  float s1ValuesSquares = 0;
  float s2ValuesSquares = 0;
  for (int x = 0; x < chunks.size(); x ++){
    s1dots2 += s2Values[x] * s1Values[x];
    s1ValuesSquares += pow(s1Values[x],2);
    s2ValuesSquares += pow(s2Values[x],2);
  }
  float cosDifValue = (float)(s1dots2)/(sqrt(s1ValuesSquares)*sqrt(s2ValuesSquares));
  return cosDifValue;
}

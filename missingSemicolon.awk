#! /usr/bin/awk
BEGIN{

}
{
  line = $0;
  lineWithoutSpaces = line;
  gsub(" ","",lineWithoutSpaces);
  split(lineWithoutSpaces, lineArray, "");
  lengthOfArray = length(lineArray);
  if( lineWithoutSpaces !~ "^for" && lineArray[lengthOfArray] != ";" && 
      lineWithoutSpaces !~ "^if" && lineArray[lengthOfArray] != ";" &&
      lineWithoutSpaces !~ "^{" && lineArray[lengthOfArray] != ";" &&
      lineWithoutSpaces !~ "^}" && lineArray[lengthOfArray] != ";" &&
      lineWithoutSpaces !~ "^while" && lineArray[lengthOfArray] != ";") {
    print NR ": missing semicolon"
  }
}
END{
}

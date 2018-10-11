#! /usr/bin/awk -f
BEGIN {
  indentationSpaces = 0;
  indentationMatches = "^for.*{$,^if.*{$,^while.*{$,^do.*{$,^{";
  split(indentationMatches, indentationMatchesArr, ",");
}
{
  noOfSpaces = 0;
  line = $0;
  lineWithoutSpaces = line;
  gsub(" ","",lineWithoutSpaces);
  if(lineWithoutSpaces == "}")
  {
    indentationSpaces-=2;
  }
  split(line, lineArray, "");
  spaceChecker = 1;
  while(lineArray[spaceChecker] == " ") {
      noOfSpaces++;
      spaceChecker++;
  }
  if(noOfSpaces != indentationSpaces) {
    print NR ": bad indentation";
  }
  for(i = 1; i <= length(indentationMatchesArr); i++){
    if(lineWithoutSpaces ~ indentationMatchesArr[i])  {
    indentationSpaces += 2;
    }
  }
  #Opening curly braces not on the same line
  if(lineWithoutSpaces ~ "^for.*[^{]$" || lineWithoutSpaces ~ "^if.*[^{]$" || lineWithoutSpaces ~ "^while.*[^{]$" || lineWithoutSpaces ~ "^do.*[^{]$")
  {
    print NR ": '{' does not appear on the same line as controlling statement."
  }
  #Missing Semicolon Finder
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

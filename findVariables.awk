#! /usr/bin/awk
BEGIN{
};
/let/{
  line = $0;
  lineWithoutSpaces = line;
  gsub(" ","",lineWithoutSpaces);
  positionOfEqualSign = match(lineWithoutSpaces, /=/);
  positionOfLet = match(lineWithoutSpaces, /let/);
  variableLength = positionOfEqualSign - (positionOfLet + 3);
  variableName = substr(lineWithoutSpaces, (positionOfLet + 3), variableLength);
  print variableName; 
};
END{

};

/**
 * 
 */




function validatePassword(){
 
  //Initalize as false, always is false unless proven true.
  var isPasswordValid = false;

  //Initialize as strings then set values.
  var username =  "";
  var password = "";
  var confirmPassword = "";
  username = document.getElementById("username").value;
  password = document.getElementById("password").value;
  confirmPassword = document.getElementById("confirmPassword").value;
 

//Returns 0 if strings DO MATCH
  var doPasswordsMatch = password.localeCompare(confirmPassword);
  if (doPasswordsMatch == 0){
    document.getElementById("doPasswordsMatch").innerHTML = "The two passwords DO match";
  } else{
    document.getElementById("doPasswordsMatch").innerHTML = "The two passwords DO NOT match";
  }

  //Must be atleast 10 characters long.
  //Dont need to test for both because we proved both password and confirmPassword are same value in above logic.
  if (password.length >9){
    document.getElementById("isAtleastTenCharacters").innerHTML = "Password DOES have atleast 10 characters.";
  } else{
    document.getElementById("isAtleastTenCharacters").innerHTML = "Password DOES NOT have atleast 10 characters.";

  }

  //Must have at least 1 uppercase  
  //Must have atleast 2 lowercase

  var i = 0;
  var char = "";
  var isUppercasePresent = false;
  var isLowerCasePresentAtleastTwice = false;
  var lowerCaseLetterCounter = 0;

  while (i < password.length){
    char = password.charAt(i);
    if (char == char.toUpperCase()){
      isUppercasePresent = true;
    }
    if (char == char.toLowerCase()){
      lowerCaseLetterCounter++;
    }
    i++;
  }

  if(isUppercasePresent){
      document.getElementById("isUpperCasePresent").innerHTML = "Password DOES contain atleast one uppercase value.";
  }else{
    document.getElementById("isUpperCasePresent").innerHTML = "Password DOES NOT contain an uppercase value.";
  }

  if (lowerCaseLetterCounter > 1){
    isLowerCasePresentAtleastTwice = true;
  }

  if(isLowerCasePresentAtleastTwice){
    document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "Password DOES contain atleast two lowercase values.";
}else{
  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "Password DOES NOT contain atleast two lowercase values.";
}
  

  //Must have 1 special character
  if(/^[a-zA-Z0-9]*$/.test(password) == false){
    document.getElementById("isSpecialCharacterPresent").innerHTML = "Password DOES contain atleast one special character value.";
    
  }else{
  document.getElementById("isSpecialCharacterPresent").innerHTML = "Password DOES NOT contain atleast one special character value.";
}




//NOT working try REGEX instead???
  //Must have 1 number
var isNumberPresentBoolean = false;
var i=0;
var char ="";

while (i>password.length){

char = password.charAt(i);

if(isNaN(char)==false){
  isNumberPresentBoolean = true
}
i++;

}

  if(isNumberPresentBoolean){
    document.getElementById("isNumberPresent").innerHTML = "Password DOES contain atleast one Number.";
    
  }else{
  document.getElementById("isNumberPresent").innerHTML = "Password DOES NOT contain atleast one Number.";
}


  document.getElementById("isPasswordValid").innerHTML = "Is Password Valid? : " + isPasswordValid;

  }
 
function clear() {
	  document.getElementById("doPasswordsMatch").innerHTML = "";
	  document.getElementById("isAtleastTenCharacters").innerHTML = "";
	  document.getElementById("isUpperCasePresent").innerHTML = "";
	  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "";
    document.getElementById("isSpecialCharacterPresent").innerHTML = "";
    document.getElementById("isNumberPresent").innerHTML = "";


	}

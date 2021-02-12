/**
 * 
 */

const defaultPasswordList = ['aaaaaaaaaa', 'aaaaaaaaa0', 'aaaaaaaaaA','Aaaaaaaaaa','aaaa1!aaaa!','Asss12!aaaa',
'bB34!!ppppp','lakj$%lkjlk','987lkjlk!lk','lkhjlkjh!@#SD2'];
  //Initalize as false, always is false unless proven true.
   isPasswordValid = false;


function validatePassword(){
     counter=0;


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
    document.getElementById("doPasswordsMatch").innerHTML = "<span style='color: green;'>The two passwords DO match</span>";
    counter++
    console.log("Do passwords match..." + counter);
  } else{
    document.getElementById("doPasswordsMatch").innerHTML = "<span style='color: red;'>The two passwords DO NOT match</span>";
  }

  //Must be atleast 10 characters long.
  //Dont need to test for both because we proved both password and confirmPassword are same value in above logic.
  if (password.length >9){
    document.getElementById("isAtleastTenCharacters").innerHTML = "<span style='color: green;'>Password DOES have atleast 10 characters.</span>";
    counter++
    console.log("10 characters..." + counter);

  } else{
    document.getElementById("isAtleastTenCharacters").innerHTML = "<span style='color: red;'>Password DOES NOT have atleast 10 characters.</span>";

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
    if(!/^[a-z]*$/.test(char)){
      lowerCaseLetterCounter++;

    }
    if(/^[A-Z]*$/.test(char)){
      isUppercasePresent = true;

    }


    i++;
  }

  if(isUppercasePresent){
      document.getElementById("isUpperCasePresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one uppercase value.</span>";
      counter++
      console.log("uppercase?..." + counter);

  }else{
    document.getElementById("isUpperCasePresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain an uppercase value.</span>";
  }

  if (lowerCaseLetterCounter > 1){
    isLowerCasePresentAtleastTwice = true;
  }

  if(isLowerCasePresentAtleastTwice){
    document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "<span style='color: green;'>Password DOES contain atleast two lowercase values.</span>";
    counter++
    console.log("lowercase?..." + counter);


}else{
  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast two lowercase values.</span>";
}
  

  //Must have 1 special character
  if(/^[a-zA-Z0-9]*$/.test(password) == false){
    document.getElementById("isSpecialCharacterPresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one special character value.</span>";
    counter++
    console.log("special char?..." + counter);

    
  }else{
  document.getElementById("isSpecialCharacterPresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast one special character value.</span>";
}




 //Must have 1 number
var isNumberPresentBoolean = false;
var i=0;
var char ="";
var numString = [0,1,2,3,4,5,6,7,8,9];

while (i<password.length){
char = password.charAt(i);
numString.forEach(num=>{

  if(char==num){
    isNumberPresentBoolean = true

  }
})
i++;
}

  if(isNumberPresentBoolean){
    document.getElementById("isNumberPresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one Number.</span>";
    counter++
    console.log("has number?..." + counter);

    
  }else{
  document.getElementById("isNumberPresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast one Number.</span>";
}


//Must check passord.txt file

isInPasswordTextFile = false;

let d = document.querySelector('input');

if(typeof d !== 'undefined' && d.files.length!=0) {
  let file = d.files[0];

  var reader = new FileReader();
  reader.onload = function(progressEvent){
  
    // By lines
    var lines = this.result.split('\n');
    for(var line = 0; line < lines.length; line++){
      let current = "";
      current= lines[line];
      let newCurrent = current.replace('\r','');
      
      if (password.localeCompare(newCurrent) == 0){
        isInPasswordTextFile = true
      }
    }
    if(isInPasswordTextFile){
      document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: red;'>Password IS IN password.txt file.</span>";
  
      
    }else{
    document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: green;'>Password IS NOT IN password.txt file.</span>";
    counter++
    console.log("in password file 1?..." + counter);
    console.log("Before =7  file 1 " +counter);
    if (counter = 7){
      isPasswordValid = true;
      document.getElementById("isPasswordValid").innerHTML = "Is Password Valid? : " + isPasswordValid;

    
    }

  }
  };
  reader.readAsText(file);

}else{
  for(var i = 0; i < defaultPasswordList.length; i++){
    let current = "";
    current= defaultPasswordList[i];
    
    if (password.localeCompare(current) == 0){
      isInPasswordTextFile = true
    }
  }
  if(isInPasswordTextFile){
    document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: red;'>Password IS IN password.txt file.</span>";
    
  }else{
  document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: green;'>Password IS NOT IN password.txt file.</span>";
  counter++
  console.log("in password file 2?..." + counter);
  console.log("Before =7  file 2" +counter);
if (counter == 7){
  isPasswordValid = true;
  document.getElementById("isPasswordValid").innerHTML = "Is Password Valid? : " + isPasswordValid;


}


}
}
document.getElementById("isPasswordValid").innerHTML = "Is Password Valid? : " + isPasswordValid;

}
function clear(){
	  document.getElementById("doPasswordsMatch").innerHTML = "";
	  document.getElementById("isAtleastTenCharacters").innerHTML = "";
	  document.getElementById("isUpperCasePresent").innerHTML = "";
	  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "";
    document.getElementById("isSpecialCharacterPresent").innerHTML = "";
    document.getElementById("isNumberPresent").innerHTML = "";
    document.getElementById("isInPasswordTextFile").innerHTML = "";
    document.getElementById("isPasswordValid").innerHTML = "";
    document.getElementById("username").innerHTML = "";
    document.getElementById("password").innerHTML = "";
    document.getElementById("confirmPassword").innerHTML = "";
    document.getElementById("myForm").reset();
    counter =0;

	}
function loadDefaultPws(){
defaultPasswordList.forEach( p=> {
document.getElementById("defualtPwList").innerHTML += p + '</br>';
});
}


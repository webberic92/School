var isPasswordValid;
var counter;

function validatePassword() {
  clear();
  var username = "";
  var newPassword = "";
  var confirmNewPassword = "";
  username = document.getElementById("username").value;
  newPassword = document.getElementById("newPassword").value;
  confirmNewPassword = document.getElementById("confirmNewPassword").value;
  arePwAndConfirmationPwTheSame(newPassword, confirmNewPassword);
  hasTenCharacters(newPassword);
  hasOneUpperCaseAndHasOneLowerCase(newPassword);
  hasSpecialCharacter(newPassword);
  hasOneNumber(newPassword);
  compareWithLoadedPasswordFileDefualtPasswordListIfEmpty(newPassword);
  document.getElementById("isPasswordValid").innerHTML = "Password Accepted? : " + isPasswordValid;
}

function validateEmail(){
  var email = "";
  email = document.getElementById("email").value;
  let json = JSON.stringify({
    username: email
  });
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://localhost:8080/isEmailValid", true);
  xhttp.setRequestHeader('Content-type', 'application/json; charset=utf-8');
  xhttp.onreadystatechange = function() {
      if (xhttp.responseText == 'true') {
         document.getElementById("validateEmail").innerHTML =  "<span style='color: green;'> Email Address is Valid : </span>" + xhttp.responseText;
      }
      else{
        document.getElementById("validateEmail").innerHTML =  "<span style='color: red;'> Email Address is Valid : </span>" + xhttp.responseText ;
      }
  };
  xhttp.send(json);
}

function registerNewUser(){
  var email = "";
  var password = "";
  email = document.getElementById("email").value;
  password = document.getElementById("password").value;

  let json = JSON.stringify({
    username: email,
    password: password
  });

  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://localhost:8080/register", true);
  xhttp.setRequestHeader('Content-type', 'application/json; charset=utf-8');
  xhttp.onreadystatechange = function() {
      if (xhttp.responseText == 'true') {
         document.getElementById("didUserGetAdded").innerHTML =  "<span style='color: green;'> Added new user : </span>" + email;
      }
      else{
        document.getElementById("didUserGetAdded").innerHTML =  "<span style='color: red;'> User already Exsist for : </span>" + email ;
      }
  };
  xhttp.send(json);
}



function clear() {
  document.getElementById("doPasswordsMatch").innerHTML = "";
  document.getElementById("isAtleastTenCharacters").innerHTML = "";
  document.getElementById("isUpperCasePresent").innerHTML = "";
  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "";
  document.getElementById("isSpecialCharacterPresent").innerHTML = "";
  document.getElementById("isNumberPresent").innerHTML = "";
  document.getElementById("isInPasswordTextFile").innerHTML = "";
  document.getElementById("isPasswordValid").innerHTML = "";
  document.getElementById("email").innerHTML = "";
  document.getElementById("currentPassword").innerHTML = "";
  document.getElementById("newPassword").innerHTML = "";
  document.getElementById("confirmNewPassword").innerHTML = "";
  document.getElementById("validateEmail").innerHTML = "";
  document.getElementById("didUserGetAdded").innerHTML = "";
  counter = 0;
  isPasswordValid = false;

}

function clearAll() {
  document.getElementById("doPasswordsMatch").innerHTML = "";
  document.getElementById("isAtleastTenCharacters").innerHTML = "";
  document.getElementById("isUpperCasePresent").innerHTML = "";
  document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "";
  document.getElementById("isSpecialCharacterPresent").innerHTML = "";
  document.getElementById("isNumberPresent").innerHTML = "";
  document.getElementById("isInPasswordTextFile").innerHTML = "";
  document.getElementById("isPasswordValid").innerHTML = "";
  document.getElementById("email").innerHTML = "";
  document.getElementById("currentPassword").innerHTML = "";
  document.getElementById("newPassword").innerHTML = "";
  document.getElementById("confirmNewPassword").innerHTML = "";
  document.getElementById("validateEmail").innerHTML = "";
  document.getElementById("didUserGetAdded").innerHTML = "";
  document.getElementById("myEmailForm").reset();
  document.getElementById("myForm").reset();

  
  counter = 0;
  isPasswordValid = false;

}

function arePwAndConfirmationPwTheSame(password, confirmPassword) {
  var doPasswordsMatch = password.localeCompare(confirmPassword);
  if (doPasswordsMatch == 0) {
    document.getElementById("doPasswordsMatch").innerHTML = "<span style='color: green;'>The two passwords DO match</span>";
    counter++

  } else {
    document.getElementById("doPasswordsMatch").innerHTML = "<span style='color: red;'>The two passwords DO NOT match</span>";
  }
}

function hasTenCharacters(password) {

  if (password.length > 9) {
    document.getElementById("isAtleastTenCharacters").innerHTML = "<span style='color: green;'>Password DOES have atleast 10 characters.</span>";
    counter++


  } else {
    document.getElementById("isAtleastTenCharacters").innerHTML = "<span style='color: red;'>Password DOES NOT have atleast 10 characters.</span>";
  }
}

function hasOneUpperCaseAndHasOneLowerCase(password) {
  var i = 0;
  var char = "";
  var isUppercasePresent = false;
  var isLowerCasePresentAtleastTwice = false;
  var lowerCaseLetterCounter = 0;

  while (i < password.length) {
    char = password.charAt(i);
    if (/^[a-z]*$/.test(char)) {
      lowerCaseLetterCounter++;
    }
    if (/^[A-Z]*$/.test(char)) {
      isUppercasePresent = true;
    }
    i++;
  }

  if (isUppercasePresent) {
    document.getElementById("isUpperCasePresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one uppercase value.</span>";
    counter++

  } else {
    document.getElementById("isUpperCasePresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain an uppercase value.</span>";
  }
  if (lowerCaseLetterCounter > 1) {
    isLowerCasePresentAtleastTwice = true;
  }
  if (isLowerCasePresentAtleastTwice) {
    document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "<span style='color: green;'>Password DOES contain atleast two lowercase values.</span>";
    counter++

  } else {
    document.getElementById("isLowerCasePresentAtLeastTwice").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast two lowercase values.</span>";
  }
}

function hasSpecialCharacter(password) {
  //Must have 1 special character
  if (/^[a-zA-Z0-9]*$/.test(password) == false) {
    document.getElementById("isSpecialCharacterPresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one special character value.</span>";
    counter++

  } else {
    document.getElementById("isSpecialCharacterPresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast one special character value.</span>";
  }
}
function hasOneNumber(password) {
  //Must have 1 number
  var isNumberPresentBoolean = false;
  var i = 0;
  var char = "";
  var numString = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  while (i < password.length) {
    char = password.charAt(i);
    numString.forEach(num => {
      if (char == num) {
        isNumberPresentBoolean = true
      }
    })
    i++;
  }
  if (isNumberPresentBoolean) {
    document.getElementById("isNumberPresent").innerHTML = "<span style='color: green;'>Password DOES contain atleast one Number.</span>";
    counter++

  } else {
    document.getElementById("isNumberPresent").innerHTML = "<span style='color: red;'>Password DOES NOT contain atleast one Number.</span>";
  }
}

function placeholder(){
  if (counter == 7) {
    isPasswordValid = true;
    document.getElementById("isPasswordValid").innerHTML = "Password Accepted? : " + isPasswordValid;
  }
}


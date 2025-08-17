/**
 * 
 */

const defaultPasswordList = ['aaaaaaaaaa', 'aaaaaaaaa0', 'aaaaaaaaaA', 'Aaaaaaaaaa', 'aaaa1!aaaa!', 'Asss12!aaaa',
  'bB34!!ppppp', 'lakj$%lkjlk', '987lkjlk!lk', 'lkhjlkjh!@#SD2'];

var isPasswordValid;
var counter;

function validatePassword() {
  clear();
  var username = "";
  var password = "";
  var confirmPassword = "";
  username = document.getElementById("username").value;
  password = document.getElementById("password").value;
  confirmPassword = document.getElementById("confirmPassword").value;
  arePwAndConfirmationPwTheSame(password, confirmPassword);
  hasTenCharacters(password);
  hasOneUpperCaseAndHasOneLowerCase(password);
  hasSpecialCharacter(password);
  hasOneNumber(password);
  compareWithLoadedPasswordFileDefualtPasswordListIfEmpty(password);
  document.getElementById("isPasswordValid").innerHTML = "Password Accepted? : " + isPasswordValid;
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
  document.getElementById("username").innerHTML = "";
  document.getElementById("password").innerHTML = "";
  document.getElementById("confirmPassword").innerHTML = "";
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
  document.getElementById("username").innerHTML = "";
  document.getElementById("password").innerHTML = "";
  document.getElementById("confirmPassword").innerHTML = "";
  document.getElementById("myForm").reset();
  counter = 0;
  isPasswordValid = false;

}
function loadDefaultPws() {
  defaultPasswordList.forEach(p => {
    document.getElementById("defualtPwList").innerHTML += p + '</br>';
  });
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

function compareWithLoadedPasswordFileDefualtPasswordListIfEmpty(password) {
  //Must check passord.txt file
  isInPasswordTextFile = false;
  let d = document.querySelector('input');
  if (typeof d !== 'undefined' && d.files.length != 0) {
    let file = d.files[0];
    var reader = new FileReader();
    reader.onload = function (progressEvent) {
      // By lines
      var lines = this.result.split('\n');
      for (var line = 0; line < lines.length; line++) {
        let current = "";
        current = lines[line];
        let newCurrent = current.replace('\r', '');
        if (password.localeCompare(newCurrent) == 0) {
          isInPasswordTextFile = true
        }
      }
      if (isInPasswordTextFile) {
        document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: red;'>Password IS IN password.txt file.</span>";
      } else {
        document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: green;'>Password IS NOT IN password.txt file.</span>";
        counter++

        if (counter = 7) {
          isPasswordValid = true;
          document.getElementById("isPasswordValid").innerHTML = "Password Accepted? : " + isPasswordValid;
        }
      }
    };
    reader.readAsText(file);
  } else {
    for (var i = 0; i < defaultPasswordList.length; i++) {
      let current = "";
      current = defaultPasswordList[i];
      if (password.localeCompare(current) == 0) {
        isInPasswordTextFile = true
      }
    }
    if (isInPasswordTextFile) {
      document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: red;'>Password IS IN password.txt file.</span>";
    } else {
      document.getElementById("isInPasswordTextFile").innerHTML = "<span style='color: green;'>Password IS NOT IN password.txt file.</span>";
      counter++

      if (counter == 7) {
        isPasswordValid = true;
        document.getElementById("isPasswordValid").innerHTML = "Password Accepted? : " + isPasswordValid;
      }
    }
  }
}
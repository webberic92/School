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
    document.getElementById("isAtleastTenCharacters").innerHTML = "Both passwords ARE atleast 10 characters.";
  } else{
    document.getElementById("isAtleastTenCharacters").innerHTML = "Passwords ARE NOT atleast 10 characters in length.";

  }

  //Must have at least 1 uppercase
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
  


  //Must have atleast 2 lowercase

  //Must have 1 special character

  //Must have 1 number

  document.getElementById("isPasswordValid").innerHTML = "Is Password Valid? : " + isPasswordValid;


  }


function myAddress() {
	
	// Gets value for wallet address..
  var x = document.getElementById("myAddress").value;
  document.getElementById("displayAddress").innerHTML = x;
  document.getElementById("youChose").innerHTML = "You chose the password...";
  
  //makes get request.
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        let jsonObj=JSON.parse(this.responseText);

     // traverse the JSON object
      //WORKS
       var balance =jsonObj['balance'];
       //creates table
 	  var table="<tr><th>Asset ID</th><th>Amount</th></tr>";
 	  //loops table
 	  for (var i=0; i<balance.length; i++) {  
    	   table += "<tr><td>" +
   	    JSON.stringify(balance[i].asset_symbol) +
   	    "</td><td>" +
   	    JSON.stringify(balance[i].amount) +
   	    "</td></tr>";
       }
       document.getElementById("demoTable").innerHTML = table;
       
       }
     
    if( this.readyState == 4 && this.status == 400) {
        document.getElementById("demo1").innerHTML = "That is an incorrect wallet address format....";

    }  
     
  };
  xhttp.open("GET", "https://api.neoscan.io/api/main_net/v1/get_balance/" + x, true);
  xhttp.send();
  var y = document.getElementById("horizontalLine");
  y.style.display = "block";
   
}



 
function clearAddress() {
	  document.getElementById("displayAddress").innerHTML = "Address Cleared, Please enter another...";
	  document.getElementById("youChose").innerHTML = "";
	  document.getElementById("demoTable").innerHTML = "";
	  document.getElementById("demo1").innerHTML = "";
	  document.getElementById("demo2").innerHTML = "";
	  table= "";
      
	  var y = document.getElementById("horizontalLine");
	  y.style.display = "none";
	  
	  var t = document.getElementById("demoTable");
	  t.style.display = "none";


	  var x = document.getElementById("myAddress").value;
	  x=null;
	}

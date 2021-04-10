package com.javainuse.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.NumberUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.dao.PasswordListEntryDAO;
import com.javainuse.dao.UserDao;
import com.javainuse.model.DAOPasswordListEntry;
import com.javainuse.model.DAOUser;
import com.javainuse.model.UserDTO;
import com.javainuse.model.UserUpdateDTO;
import com.javainuse.service.JwtUserDetailsService;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
public class JwtAuthenticationController {

	@Autowired
	private PasswordEncoder bcryptEncoder;

	@Autowired
	private PasswordListEntryDAO passwordListEntryDAO;

	@Autowired
	private UserDao userDao;

	@Autowired
	private JwtUserDetailsService userDetailsService;

	@CrossOrigin(origins = "*")
	@GetMapping(value = "/test")
	public String test() throws Exception {

		return "test";
	}

	@CrossOrigin(origins = "*")
	@RequestMapping(value = "/isEmailValid", method = RequestMethod.POST)
	public ResponseEntity<?> isEmailValid(@RequestBody UserDTO user) throws Exception {
		boolean retVal = true;
		try {
			userDetailsService.loadUserByUsername(user.getUsername());
		} catch (Exception e) {
			retVal = false;
			return ResponseEntity.ok(retVal);
		}
		return ResponseEntity.ok(retVal);

	}

	@CrossOrigin(origins = "*")
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ResponseEntity<?> saveUser(@RequestBody UserDTO user) throws Exception {
		boolean retVal = false;

		if (passwordValidation(user.getPassword())) {

			try {
				userDetailsService.save(user);
				retVal = true;
			} catch (Exception e) {
				return ResponseEntity.ok(retVal);

			}
		}

		return ResponseEntity.ok(retVal);

	}

	private boolean passwordValidation(String password) throws Exception {
		
		long lowerCaseCounter = 0;
		boolean retVal = false;

		
			//The password should be at least 10 characters strong.
		if (password.length()<= 9) {
			throw new Exception("Password must be 10 characters.");
			
		}
			
			for (int i =0; i < password.length();i++) {
				// The password should contain at least one upper case letter.

				if(String.valueOf(password.charAt(i)).matches("[A-Z]*")) {
							
					// The password should contain at least 2 lower case letters.

					for (int j =0; j < password.length();j++) {

						if(String.valueOf(password.charAt(j)).matches("[a-z]*")) {
							
							lowerCaseCounter++;
						
						}j++;
					}
							
							if(lowerCaseCounter>=2) {
								
								
								
								for (int k =0; k < password.length();k++) {

									//		The password should have at least one special character.

									if(!String.valueOf(password.charAt(k)).matches("[A-Za-z0-9 ]*")) {
										
										for (int l =0; l < password.length();l++) {

											if (String.valueOf(password.charAt(l)).matches("[0-9]*")) {
												return true;
										}else {
											throw new Exception("Password does not conatin a number.");
										}

										
										
									}k++;
									
							}else {
								throw new Exception("Password does not conatin special character.");
							}
							
								}}
							
					else {
						throw new Exception("Password does not conatin 2 lower case letters.");
					}
					
				i++;

	}else
		{
		throw new Exception("Password Does not conatin uppercause value.");
		}
		}
		return retVal;}

	@CrossOrigin(origins = "*")
	@RequestMapping(value = "/updatePassword", method = RequestMethod.PUT)
	public ResponseEntity<?> updatePassword(@RequestBody UserUpdateDTO updatedUser) throws Exception {
		boolean retVal = false;

		try {
			DAOUser originalUser = userDao.findByUsername(updatedUser.getUsername());
			String oldPassword = updatedUser.getOldPassword();
			String newPassword = bcryptEncoder.encode(updatedUser.getNewPassword());

			if (bcryptEncoder.matches(oldPassword, originalUser.getPassword())) {

				List<DAOPasswordListEntry> passwordListEntrys = passwordListEntryDAO
						.findByUsername(updatedUser.getUsername());

				if (passwordListEntrys != null) {
					for (DAOPasswordListEntry pwel : passwordListEntrys) {

						if (bcryptEncoder.matches(updatedUser.getNewPassword(), pwel.getPassword())) {
							return ResponseEntity.ok("CAN NOT USE ANY OF YOUR OLD 5 PASSWORDS!");

						}
					}

				}

				originalUser.setPassword(newPassword);
				userDao.save(originalUser);

				if (passwordListEntrys.size() < 5) {

					DAOPasswordListEntry pwdle = new DAOPasswordListEntry();
					pwdle.setUsername(originalUser.getUsername());
					pwdle.setPassword(newPassword);
					pwdle.setDate(new Date());
					passwordListEntryDAO.save(pwdle);
					retVal = true;
				} else {

					replaceOldestPasswordOfFive(passwordListEntrys.get(0), updatedUser);
					retVal = true;

				}

			} else {
				return ResponseEntity.ok("PASSWORD DOES NOT MATCH WHATS IN DATABASE!");

			}

		} catch (Exception e) {
			return ResponseEntity.ok(e.getMessage());

		}
		return ResponseEntity.ok(retVal);

	}

	private void replaceOldestPasswordOfFive(DAOPasswordListEntry daoPasswordListEntry, UserUpdateDTO updatedUser) {
		passwordListEntryDAO.delete(daoPasswordListEntry);
		DAOPasswordListEntry pwdle = new DAOPasswordListEntry();
		pwdle.setUsername(updatedUser.getUsername());
		pwdle.setPassword(bcryptEncoder.encode(updatedUser.getNewPassword()));
		pwdle.setDate(new Date());
		passwordListEntryDAO.save(pwdle);
	}

//	@CrossOrigin(origins = "*")
//	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
//	public ResponseEntity<?> createAuthenticationToken(@RequestBody JwtRequest authenticationRequest) throws Exception {
//
//		authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
//
//		final UserDetails userDetails = userDetailsService
//				.loadUserByUsername(authenticationRequest.getUsername());
//
//		final String token = jwtTokenUtil.generateToken(userDetails);
//
//		return ResponseEntity.ok(new JwtResponse(token));
//	}
//	
//	
//	private void authenticate(String username, String password) throws Exception {
//		try {
//			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
//		} catch (DisabledException e) {
//			throw new Exception("USER_DISABLED", e);
//		} catch (BadCredentialsException e) {
//			throw new Exception("INVALID_CREDENTIALS", e);
//		}
//	}
}
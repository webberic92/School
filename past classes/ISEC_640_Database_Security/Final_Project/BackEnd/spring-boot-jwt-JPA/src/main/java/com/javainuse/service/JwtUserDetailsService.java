package com.javainuse.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.javainuse.dao.PasswordListEntryDAO;
import com.javainuse.dao.UserDao;
import com.javainuse.model.DAOPasswordListEntry;
import com.javainuse.model.DAOUser;
import com.javainuse.model.UserDTO;

@Service
public class JwtUserDetailsService implements UserDetailsService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private PasswordListEntryDAO passwordListEntryDAO;

	@Autowired
	private PasswordEncoder bcryptEncoder;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		DAOUser user = userDao.findByUsername(username);
		if (user == null) {
			throw new UsernameNotFoundException("User not found with username: " + username);
		}
		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
				new ArrayList<>());
	}
	
	public void save(UserDTO user) throws Exception {
		String un = user.getUsername();
		final String pwd = bcryptEncoder.encode(user.getPassword());
		
		if(userDao.findByUsername(user.getUsername())==null) {
			
			DAOUser newUser = new DAOUser();
			newUser.setUsername(un);
			newUser.setPassword(pwd);
			userDao.save(newUser);
			
			DAOPasswordListEntry passwordListEntry = new DAOPasswordListEntry();
			passwordListEntry.setUsername(un);
			passwordListEntry.setPassword(pwd);
			passwordListEntry.setDate(new Date());
			passwordListEntryDAO.save(passwordListEntry);
			
		}else {
			throw new Exception("That user already exsists.");
		}

	}
}
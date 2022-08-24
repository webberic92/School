package com.javainuse.dao;

import java.util.ArrayList;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.javainuse.model.DAOPasswordListEntry;

@Repository
public interface PasswordListEntryDAO extends CrudRepository<DAOPasswordListEntry, Integer> {
	
	ArrayList<DAOPasswordListEntry> findByUsername(String username);
	
}
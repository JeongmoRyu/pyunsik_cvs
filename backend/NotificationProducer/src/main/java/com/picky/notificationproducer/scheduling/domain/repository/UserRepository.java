package com.picky.notificationproducer.scheduling.domain.repository;

import com.picky.notificationproducer.scheduling.domain.entiity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findAllByIsDeletedFalse();
}

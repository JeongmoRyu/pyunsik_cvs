package com.picky.auth.user.domain.repository;

import com.picky.auth.user.domain.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User getByUUID(String UUID);

    User getByNickname(String nickname);
}

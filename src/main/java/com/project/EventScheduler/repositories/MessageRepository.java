package com.project.EventScheduler.repositories;

import com.project.EventScheduler.models.Message;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {
    List<Message> findAll();

}
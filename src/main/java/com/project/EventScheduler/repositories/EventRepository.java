package com.project.EventScheduler.repositories;
import com.project.EventScheduler.models.Event;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventRepository extends CrudRepository<Event, Long> {
    List<Event> findAll();

}
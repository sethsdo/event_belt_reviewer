package com.project.EventScheduler.services;

import com.project.EventScheduler.models.Event;
import com.project.EventScheduler.models.User;
import com.project.EventScheduler.repositories.EventRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class EventService {
    private EventRepository eventRepo;

    public EventService(EventRepository eventRepo){
        this.eventRepo = eventRepo;
    }
    
    public List<Event> allEvents() {
        return eventRepo.findAll();
    }

    public void destroyEvent(Long id) {
        eventRepo.delete(id);
    }

    public void removeUser(List<User> current) {
        
    }

    public void saveEvent(Event event) {
        eventRepo.save(event);
    }

    public Event findEventById(Long id) {
        return eventRepo.findOne(id);
    }
    
    public void updateEvent(Event event) {
        eventRepo.save(event);
    }

}
package com.project.EventScheduler.controllers;

import com.project.EventScheduler.models.Event;
import com.project.EventScheduler.models.Message;
import com.project.EventScheduler.models.User;
import com.project.EventScheduler.services.EventService;
import com.project.EventScheduler.services.MessageService;
import com.project.EventScheduler.services.UserService;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.validation.Valid;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class EventsController {
    private final EventService eventService;
    private final UserService userService;
    private final MessageService messageService;

    public EventsController(EventService eventService, UserService userService, MessageService messageService) {
        this.eventService = eventService;
        this.userService = userService;
        this.messageService = messageService;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    @RequestMapping("/user/{user_id}/event/{id}")
    public String createEvent(Model model, @PathVariable("id") Long id, @PathVariable("user_id") Long user_id, RedirectAttributes err) {
        model.addAttribute("event", eventService.findEventById(id));
        Event event = eventService.findEventById(id);
        model.addAttribute("size", event.getUsers().size());
        model.addAttribute("user", userService.findUserById(user_id));
        model.addAttribute("messages", messageService.allMessages());
        return "event";
    }

    @RequestMapping("/event/delete/{id}")
    public String deleteEvent(Model model, @PathVariable("id") Long id, RedirectAttributes err) {
        System.out.println("hello world");
        eventService.destroyEvent(id);
        return "redirect:/dashboard";
    }

    @RequestMapping("/event/{event_id}/join/{user_id}")
    public String joinEvent(Model model, @PathVariable("event_id") Long event_id, @PathVariable("user_id") Long user_id, RedirectAttributes err) {
        Event event = eventService.findEventById(event_id);
        User user = userService.findUserById(user_id);
        event.getUsers().add(user);
        eventService.updateEvent(event);
        return "redirect:/dashboard";
    }
    
    @RequestMapping("/event/{event_id}/cancel/{user_id}")
    public String cancelRsvp(Model model, @PathVariable("event_id") Long event_id,
            @PathVariable("user_id") Long user_id, RedirectAttributes err) {
        Event event = eventService.findEventById(event_id);
        
        event.getUsers().remove(userService.findUserById(user_id));
        eventService.saveEvent(event);
        return "redirect:/dashboard";
    }

    @PostMapping("/event/update/{id}")
    public String updateEvent(@PathVariable("id") Long id,
            @RequestParam(value="name") String name, 
            @RequestParam(value="date") Date date, 
            @RequestParam(value = "location") String location,
            @RequestParam(value = "state") String state, RedirectAttributes err) {
        
        Event newEvent = new Event(name, location, state, date);
        Event event = eventService.findEventById(id);
        // if (result.ha {
        //     model.addAttribute("states", state);
        // }
        if (!name.isEmpty()) {
            System.out.print(name);
            System.out.print("name");
            event.setName(name);
        } if (!location.isEmpty()) {
            System.out.print(location);
            System.out.print("location");
            event.setLocation(location);
        } if (!state.isEmpty()) {
            System.out.print(state);
            System.out.print("state");
            event.setState(state);
        } if (!date.equals("")) {
            System.out.print(date);
            System.out.print("date");
            event.setDate(date);
        }
        eventService.saveEvent(event);
        return "redirect:/dashboard";
    }

    @PostMapping("/user/{user_id}/event/{event_id}/post/{id}")
    public String createMessage(Model model, @PathVariable("event_id") Long event_id, @PathVariable("user_id") Long user_id, @PathVariable(value ="id") Long id, @RequestParam(value="message") String message) {
        System.out.println("hello there");
        Event event = eventService.findEventById(event_id);
        User user = userService.findUserById(id);
        Message current = new Message(message, user, event);
        event.getMessages().add(current);
        messageService.saveMessage(current);
        System.out.println("hello there");
        eventService.updateEvent(event);


        return "redirect:/user/" + user_id + "/event/" + event_id;
    }
}

package com.project.EventScheduler.controllers;

import com.project.EventScheduler.models.Event;
import com.project.EventScheduler.models.User;
import com.project.EventScheduler.services.EventService;
import com.project.EventScheduler.services.UserService;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class DashboardController {
    private final EventService eventService;
    private final UserService userService;

    public DashboardController(EventService eventService, UserService userService) {
        this.userService = userService;
        this.eventService = eventService;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }

    @PostMapping("/dashboard/newEvent/{id}")
    public String createEvent(Model model, @PathVariable("id") Long id, 
        @RequestParam(value="name") String name, 
        @RequestParam(value="date") Date date, 
        @RequestParam(value = "location") String location,
        @RequestParam(value = "state") String state, RedirectAttributes err){

        User user = userService.findUserById(id);
        System.out.println(user);
        Event event = new Event(name, location, state, date, user);
        eventService.saveEvent(event);
        return "redirect:/dashboard";
    }
}


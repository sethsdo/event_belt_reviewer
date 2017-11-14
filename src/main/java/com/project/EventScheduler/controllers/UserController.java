package com.project.EventScheduler.controllers;



import com.project.EventScheduler.models.User;
import com.project.EventScheduler.services.EventService;
import com.project.EventScheduler.services.UserService;
import com.project.EventScheduler.validators.UserValidator;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {
    public List<String> state = Arrays.asList("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL",
            "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NV", "NE", "NH", "NJ", "NM",
            "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI",
            "WY");
    private UserService userService;
    private UserValidator userValidator;
    private EventService eventService;

    public UserController(UserService userService, UserValidator userValidator, EventService eventService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.eventService = eventService;
    }

    @RequestMapping(value = { "/", "/dashboard" })
    public String home(Principal principal, Model model) {
        String username = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(username));
        model.addAttribute("events", eventService.allEvents());
        model.addAttribute("states", state);
        return "dashboard";
    }

    @RequestMapping("/loginAndReg")
    public String logingAndReg(@Valid @ModelAttribute("user") User user, Model model) {
        model.addAttribute("states", state);
        System.out.println(state);
        return "index";
    }

    // @RequestMapping("/registration")
    // public String registerForm(@Valid @ModelAttribute("user") User user) {
    //     return "registrationPage";
    // }

    @PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model,
            HttpSession session) {
        userValidator.validate(user, result);
        if (result.hasErrors()) {
            model.addAttribute("states", state);
            // System.out.println("not successfull");
            return "index";
        }
            // System.out.println("length is less then 0");
        userService.saveUser(user);
        return "redirect:/dashboard";
        // } else {
        //     // System.out.println("length is greater then 0");
        //     userService.saveUserWithAdminRole(user);
        //     return "redirect:/dashboard";
        // }
    }

    // @RequestMapping("/admin")
    // public String adminPage(Principal principal, Model model) {
    //     String username = principal.getName();
    //     model.addAttribute("currentUser", userService.findByUsername(username));
    //     model.addAttribute("users", userService.allUsers());
    //     return "adminPage";
    // }

    @RequestMapping("/login")
    public String login(@ModelAttribute("user") User user,
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout, Model model) {
        model.addAttribute("registered", "Successful Registration! Please Login...");
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "Logout Successfull!");
        }
        model.addAttribute("states", state);
        return "index";
    }

    // @RequestMapping("/admin/removeUser/{id}")
    // public String removeUser(@PathVariable("id") Long id) {

    //     System.out.println("in remove");
    //     userService.destroyUser(id);
    //     return "redirect:/admin";
    // }

    // @RequestMapping("/admin/addAdmin/{id}")
    // public String addAdmin(@PathVariable("id") Long id) {
    //     User current = userService.findUserById(id);
    //     userService.saveUserWithAdminRole(current);
    //     return "redirect:/admin";
    // }

}
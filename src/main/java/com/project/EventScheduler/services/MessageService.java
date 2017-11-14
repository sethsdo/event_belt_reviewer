package com.project.EventScheduler.services;

import com.project.EventScheduler.models.Message;
import com.project.EventScheduler.repositories.MessageRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    private MessageRepository messageRepo;

    public MessageService(MessageRepository messageRepo) {
        this.messageRepo = messageRepo;
    }

    public List<Message> allMessages() {
        return messageRepo.findAll();
    }

    public void saveMessage(Message message) {
        messageRepo.save(message);
    }
}
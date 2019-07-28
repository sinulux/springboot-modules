package com.springboot.websocket.disruptor;

import com.lmax.disruptor.EventHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

/**
 * Content :广播消息处理器
 */
@Component
public class ActiveMQEventHandler implements EventHandler<ActiveMQEvent> {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public void onEvent(ActiveMQEvent activeMQEvent, long l, boolean b) {
        messagingTemplate.convertAndSend("/topic/receiveMessage", activeMQEvent.getMessage());
    }
}

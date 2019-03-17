package com.springboot.websocket.disruptor;


import com.lmax.disruptor.EventHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

/**
 * Content :进程日志事件处理器
 */
@Component
public class LoggerEventHandler implements EventHandler<LoggerEvent> {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Override
    public void onEvent(LoggerEvent stringEvent, long l, boolean b) {
        messagingTemplate.convertAndSend("/topic/pullLogger",stringEvent.getLog());
    }
}

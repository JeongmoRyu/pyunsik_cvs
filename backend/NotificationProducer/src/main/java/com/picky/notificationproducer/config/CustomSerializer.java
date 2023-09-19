package com.picky.notificationproducer.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.common.errors.SerializationException;
import org.apache.kafka.common.serialization.Serializer;

import java.util.Map;

@Slf4j
public class CustomSerializer implements Serializer<Object> {
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {
        // do nothing
    }

    @Override
    public byte[] serialize(String topic, Object object) {
        try {
            if (object == null){
                log.info("[CustomSerializer] Null received at serializing");
                return null;
            }
            log.info("[CustomSerializer] Serializing...");
            return objectMapper.writeValueAsBytes(object);
        } catch (Exception e) {
            throw new SerializationException("[CustomSerializer] Error when serializing MessageDto to byte[]");
        }
    }

    @Override
    public void close() {
        // do nothing
    }
}

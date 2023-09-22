package com.picky.notificationproducer.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.common.errors.SerializationException;
import org.apache.kafka.common.serialization.Deserializer;

import java.nio.charset.StandardCharsets;
import java.util.Map;

@Slf4j
public class CustomDeserializer implements Deserializer<Object> {
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void configure(Map<String, ?> configs, boolean isKey) {
        // do nothing
    }

    @Override
    public Object deserialize(String topic, byte[] data) {
        try {
            if (data == null){
                log.info("[CustomDeserializer] Null received at deserializing");
                return null;
            }
            log.info("[CustomDeserializer] Deserializing...");
            return objectMapper.readValue(new String(data, StandardCharsets.UTF_8), Object.class);
        } catch (Exception e) {
            throw new SerializationException("[CustomDeserializer] Error when deserializing byte[] to MessageDto");
        }
    }

    @Override
    public void close() {
        // do nothing
    }
}

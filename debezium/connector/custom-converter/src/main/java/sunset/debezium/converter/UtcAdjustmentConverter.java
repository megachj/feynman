package sunset.debezium.converter;

import io.debezium.spi.converter.CustomConverter;
import io.debezium.spi.converter.RelationalColumn;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Properties;
import org.apache.kafka.connect.data.SchemaBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UtcAdjustmentConverter implements CustomConverter<SchemaBuilder, RelationalColumn> {

    private static final Logger logger = LoggerFactory.getLogger(Logger.ROOT_LOGGER_NAME);

    private static final List<DateTimeFormatter> DATE_TIME_FORMATTERS
        = List.of(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"), DateTimeFormatter.ISO_LOCAL_DATE_TIME);

    @Override
    public void configure(Properties props) {
    }

    @Override
    public void converterFor(RelationalColumn column, ConverterRegistration<SchemaBuilder> registration) {
        if ("DATETIME".equalsIgnoreCase(column.typeName())) {
            registration.register(SchemaBuilder.int64().optional(), value -> {
                if (value == null) {
                    return null;
                }

                for (DateTimeFormatter formatter : DATE_TIME_FORMATTERS) {
                    try {
                        return LocalDateTime
                            .parse(value.toString(), formatter)
                            .atZone(ZoneId.systemDefault())
                            .toInstant()
                            .toEpochMilli();
                    } catch (Exception ignored) {
                    }
                }

                logger.error("DatetimeStringTypeConverter parsing exception, value {}.", value);
                return null;
            });
        }
    }
}

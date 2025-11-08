package ${packageName}.dataobject.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import java.time.LocalDateTime;
import java.math.BigDecimal;

/**
* ${table.comment}
* @author ${author}
* @date ${date}
*/
@Data
@Schema(description="${table.comment}")
public class ${table.className} {

<#list table.columns as col>
    @Schema(description="${col.comment}")
    private ${col.javaType} ${col.propertyName};
</#list>

}

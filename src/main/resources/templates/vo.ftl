package ${packageName}.dataobject.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
* ${table.comment}视图对象
* @author ${author}
* @date ${date}
*/
@Data
@Schema(description="${table.comment}视图对象")
public class ${table.className}VO {

<#list table.columns as col>
    @Schema(description="${col.comment}")
    private ${col.javaType} ${col.propertyName};
</#list>

}

package ${packageName}.dataobject.bo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import jakarta.validation.constraints.NotNull;

/**
* ${table.comment}业务对象（用于新增/修改）
* @author ${author}
* @date ${date}
*/
@Data
@Schema(description="${table.comment}业务对象")
public class ${table.className}BO {

<#list table.columns as col>
    @Schema(description="${col.comment}")
    private ${col.javaType} ${col.propertyName};
</#list>

}

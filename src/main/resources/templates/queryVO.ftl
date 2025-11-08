package ${packageName}.dataobject.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
* ${table.comment}查询条件VO（分页查询参数）
* @author ${author}
* @date ${date}
*/
@Data
@Schema(description="${table.comment}查询条件")
public class ${table.className}QueryVO {

@Schema(description="页码")
private Integer pageNum = 1;

@Schema(description="每页数量")
private Integer pageSize = 10;

<#list table.columns as col>
    @Schema(description="${col.comment}")
    private ${col.javaType} ${col.propertyName};
</#list>
}

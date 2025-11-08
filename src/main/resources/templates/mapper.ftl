package ${packageName}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${packageName}.dataobject.entity.${table.className};
import org.apache.ibatis.annotations.Mapper;

/**
* ${table.comment}Mapper接口
* @author ${author}
* @date ${date}
*/
@Mapper
public interface ${table.className}Mapper extends BaseMapper<${table.className}> {
}

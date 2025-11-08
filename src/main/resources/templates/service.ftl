package ${packageName}.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${packageName}.dataobject.bo.${table.className}BO;
import ${packageName}.dataobject.vo.${table.className}VO;
import ${packageName}.dataobject.vo.${table.className}QueryVO;

import java.util.List;

/**
* ${table.comment}服务接口
* @author ${author}
* @date ${date}
*/
public interface ${table.className}Service {

Page<${table.className}VO> queryPage(${table.className}QueryVO queryVO);

    ${table.className}VO getDetailById(String id);

    Boolean save${table.className}(${table.className}BO bo);

    Boolean update${table.className}(${table.className}BO bo);

    Boolean deleteLogic(String id);

    Boolean batchDeleteLogic(List<String> ids);
        }

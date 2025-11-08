package ${packageName}.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import ${packageName}.dataobject.bo.${table.className}BO;
import ${packageName}.dataobject.vo.${table.className}VO;
import ${packageName}.dataobject.vo.${table.className}QueryVO;
import ${packageName}.dataobject.entity.${table.className};
import ${packageName}.mapper.${table.className}Mapper;
import ${packageName}.service.${table.className}Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* ${table.comment}服务实现类
* @author ${author}
* @date ${date}
*/
@Service
@RequiredArgsConstructor
public class ${table.className}ServiceImpl implements ${table.className}Service {

private final ${table.className}Mapper ${table.className?uncap_first}Mapper;

@Override
public Page<${table.className}VO> queryPage(${table.className}QueryVO queryVO) {
    // 示例分页逻辑，可根据实际项目调整
    Page<${table.className}> page = new Page<>(queryVO.getPageNum(), queryVO.getPageSize());
    Page<${table.className}> entityPage = ${table.className?uncap_first}Mapper.selectPage(page, null);
    // 转换为VO结果
    Page<${table.className}VO> voPage = new Page<>();
        voPage.setRecords(entityPage.getRecords().stream().map(e -> {
        ${table.className}VO vo = new ${table.className}VO();
        org.springframework.beans.BeanUtils.copyProperties(e, vo);
        return vo;
        }).toList());
        voPage.setTotal(entityPage.getTotal());
        return voPage;
        }

        @Override
        public ${table.className}VO getDetailById(String id) {
        ${table.className} entity = ${table.className?uncap_first}Mapper.selectById(id);
        ${table.className}VO vo = new ${table.className}VO();
        org.springframework.beans.BeanUtils.copyProperties(entity, vo);
        return vo;
        }

        @Override
        public Boolean save${table.className}(${table.className}BO bo) {
        ${table.className} entity = new ${table.className}();
        org.springframework.beans.BeanUtils.copyProperties(bo, entity);
        return ${table.className?uncap_first}Mapper.insert(entity) > 0;
        }

        @Override
        public Boolean update${table.className}(${table.className}BO bo) {
        ${table.className} entity = new ${table.className}();
        org.springframework.beans.BeanUtils.copyProperties(bo, entity);
        return ${table.className?uncap_first}Mapper.updateById(entity) > 0;
        }

        @Override
        public Boolean deleteLogic(String id) {
        return ${table.className?uncap_first}Mapper.deleteById(id) > 0;
        }

        @Override
        public Boolean batchDeleteLogic(List<String> ids) {
            return ${table.className?uncap_first}Mapper.deleteBatchIds(ids) > 0;
            }
            }

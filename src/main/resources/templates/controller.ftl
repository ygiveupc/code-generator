package ${packageName}.controller;

import ${packageName}.dataobject.bo.${table.className}BO;
import ${packageName}.dataobject.vo.${table.className}QueryVO;
import ${packageName}.dataobject.vo.${table.className}VO;
import ${packageName}.service.${table.className}Service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.alibaba.excel.read.listener.PageReadListener;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
* ${table.comment}控制器
* @author ${author}
* @date ${date}
*/
@RestController
@RequestMapping("/${moduleName}")
@RequiredArgsConstructor
@Tag(name = "${table.comment}管理", description = "${table.comment}增删改查及Excel导入导出接口")
public class ${table.className}Controller {

private final ${table.className}Service ${table.className?uncap_first}Service;

/*-------------------------------- 分页/CRUD --------------------------------*/

@GetMapping("/page")
@Operation(summary = "分页查询${table.comment}")
public ResponseEntity<Page<${table.className}VO>> queryPage(@Valid ${table.className}QueryVO queryVO) {
    return ResponseEntity.ok(${table.className?uncap_first}Service.queryPage(queryVO));
    }

    @GetMapping("/{id}")
    @Operation(summary = "根据ID获取${table.comment}详情")
    public ResponseEntity<${table.className}VO> getById(
        @Parameter(description = "${table.comment}ID") @PathVariable("id") String id) {
        return ResponseEntity.ok(${table.className?uncap_first}Service.getDetailById(id));
        }

        @PostMapping
        @Operation(summary = "新增${table.comment}")
        public ResponseEntity<Boolean> save(@Valid @RequestBody ${table.className}BO bo) {
            return ResponseEntity.ok(${table.className?uncap_first}Service.save${table.className}(bo));
            }

            @PutMapping
            @Operation(summary = "更新${table.comment}")
            public ResponseEntity<Boolean> update(@Valid @RequestBody ${table.className}BO bo) {
                return ResponseEntity.ok(${table.className?uncap_first}Service.update${table.className}(bo));
                }

                @DeleteMapping("/{id}")
                @Operation(summary = "逻辑删除${table.comment}")
                public ResponseEntity<Boolean> delete(
                    @Parameter(description = "${table.comment}ID") @PathVariable("id") String id) {
                    return ResponseEntity.ok(${table.className?uncap_first}Service.deleteLogic(id));
                    }

                    @PostMapping("/batch-delete")
                    @Operation(summary = "批量逻辑删除${table.comment}")
                    public ResponseEntity<Boolean> batchDelete(
                        @Parameter(description = "${table.comment}ID列表") @RequestBody List<String> ids) {
                            return ResponseEntity.ok(${table.className?uncap_first}Service.batchDeleteLogic(ids));
                            }

                            /*-------------------------------- Excel 导出 --------------------------------*/

                            @GetMapping("/export")
                            @Operation(summary = "导出${table.comment}Excel")
                            public void exportExcel(@Valid ${table.className}QueryVO queryVO, HttpServletResponse response) throws IOException {
                            // 查询数据
                            List<${table.className}VO> list = ${table.className?uncap_first}Service.queryPage(queryVO).getRecords();

                                // 设置响应头
                                String fileName = URLEncoder.encode("${table.className}数据.xlsx", StandardCharsets.UTF_8);
                                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                                response.setCharacterEncoding("utf-8");
                                response.setHeader("Content-Disposition", "attachment;filename*=utf-8''" + fileName);

                                // 写出 Excel
                                EasyExcel.write(response.getOutputStream(), ${table.className}VO.class)
                                .sheet("${table.comment}")
                                .doWrite(list);
                                }

                                /*-------------------------------- Excel 导入 --------------------------------*/

                                @PostMapping("/import")
                                @Operation(summary = "导入${table.comment}Excel")
                                public ResponseEntity<String> importExcel(@Parameter(description = "Excel文件") @RequestPart("file") MultipartFile file)
                                    throws IOException {
                                    EasyExcel.read(file.getInputStream(), ${table.className}VO.class, new PageReadListener<${table.className}VO>(dataList -> {
                                        // 将Excel中每页的数据转换为BO后批量保存；按你的项目需求调整
                                        dataList.forEach(item -> {
                                        ${table.className}BO bo = new ${table.className}BO();
                                        org.springframework.beans.BeanUtils.copyProperties(item, bo);
                                        ${table.className?uncap_first}Service.save${table.className}(bo);
                                        });
                                        })).sheet().doRead();
                                        return ResponseEntity.ok("导入成功");
                                        }
                                        }

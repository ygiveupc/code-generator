package com.example.codegenerator.service.impl;


import com.example.codegenerator.model.GeneratorRequest;
import com.example.codegenerator.model.TableInfo;
import com.example.codegenerator.util.SqlParseUtils;
import com.example.codegenerator.util.TemplateRenderUtils;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;

@Service
public class GeneratorServiceImpl implements com.example.codegenerator.service.GeneratorService {
    @Override
    public byte[] generateCodeZip(GeneratorRequest req) throws IOException {
        TableInfo table = SqlParseUtils.parse(req.getSql());
        Map<String, Object> data = Map.of(
                "packageName", req.getPackageName(),
                "author", req.getAuthor(),
                "moduleName", req.getModuleName(),
                "table", table,
                "date", LocalDate.now().toString()
        );
        Map<String, String> files = TemplateRenderUtils.renderAllTemplates(data);
        return TemplateRenderUtils.toZipBytes(files);
    }
}

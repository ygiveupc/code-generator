package com.example.codegenerator.util;

import com.example.codegenerator.model.TableInfo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Slf4j
public class TemplateRenderUtils {
    private static final Configuration cfg = new Configuration(Configuration.VERSION_2_3_32);

    static {
        cfg.setClassLoaderForTemplateLoading(Thread.currentThread().getContextClassLoader(), "templates");
        cfg.setDefaultEncoding("UTF-8");
    }

    public static Map<String, String> renderAllTemplates(Map<String, Object> data) throws IOException {
        String className = ((TableInfo) data.get("table")).getClassName();
        Map<String, String> files = new LinkedHashMap<>();
        String[] list = {"entity","controller","service","serviceImpl",
                "mapper","vo","bo","queryVO","mapperXml"};
        for (String name : list) {
            Template t = cfg.getTemplate(name + ".ftl");
            String path = name.startsWith("serviceImpl") ? "service/impl/" + className + "ServiceImpl.java"
                    : name.equals("controller") ? "controller/" + className + "Controller.java"
                    : name.equals("entity") ? "entity/" + className + ".java"
                    : name.equals("mapper") ? "mapper/" + className + "Mapper.java"
                    : name.equals("mapperXml") ? "mapper/xml/" + className + "Mapper.xml"   // ★添加这一行
                    : name.equals("service") ? "service/" + className + "Service.java"
                    : name.equals("vo") ? "vo/" + className + "VO.java"
                    : name.equals("bo") ? "bo/" + className + "BO.java"
                    : "vo/" + className + "QueryVO.java";
            files.put(path, render(t, data));
        }
        return files;
    }

    private static String render(Template template, Map<String, Object> data) throws IOException {
        try (StringWriter w = new StringWriter()) {
            template.process(data, w);
            return w.toString();
        } catch (TemplateException e) {
            throw new IOException(e);
        }
    }

    public static byte[] toZipBytes(Map<String, String> fileMap) throws IOException {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream();
             ZipOutputStream zos = new ZipOutputStream(baos)) {
            for (Map.Entry<String, String> e : fileMap.entrySet()) {
                zos.putNextEntry(new ZipEntry(e.getKey()));
                zos.write(e.getValue().getBytes(StandardCharsets.UTF_8));
                zos.closeEntry();
            }
            zos.finish();
            return baos.toByteArray();
        }
    }
}


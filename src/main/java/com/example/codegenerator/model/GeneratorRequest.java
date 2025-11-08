package com.example.codegenerator.model;

import lombok.Data;

@Data
public class GeneratorRequest {
    private String packageName;
    private String moduleName;
    private String author;
    private String sql;
}

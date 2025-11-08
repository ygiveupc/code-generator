package com.example.codegenerator.model;

import lombok.Data;

@Data
public class ColumnInfo {
    private String columnName;
    private String propertyName;
    private String jdbcType;
    private String javaType;
    private String comment;
}


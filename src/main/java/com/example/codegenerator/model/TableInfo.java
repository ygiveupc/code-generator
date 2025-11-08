package com.example.codegenerator.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TableInfo {
    private String tableName;
    private String className;
    private String comment;
    private List<ColumnInfo> columns = new ArrayList<>();
}


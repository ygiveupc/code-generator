package com.example.codegenerator.util;

import com.example.codegenerator.model.ColumnInfo;
import com.example.codegenerator.model.TableInfo;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SqlParseUtils {

    public static TableInfo parse(String sql) {
        TableInfo table = new TableInfo();
        sql = sql.replaceAll("\n", " ").replaceAll("\\s+", " ").trim();

        if (sql.toLowerCase().contains("comment on table")) {
            // PostgreSQL 语法解析
            parsePostgres(sql, table);
        } else {
            // 默认 MySQL 语法解析
            parseMysql(sql, table);
        }
        return table;
    }

    private static void parseMysql(String sql, TableInfo table) {
        Pattern tablePattern = Pattern.compile("CREATE TABLE [`\"]?(\\w+)[`\"]?.*COMMENT=['\"](.+?)['\"]", Pattern.CASE_INSENSITIVE);
        Matcher m = tablePattern.matcher(sql);
        if (m.find()) {
            table.setTableName(m.group(1));
            table.setClassName(toCamelCaseCap(table.getTableName()));
            table.setComment(m.group(2));
        }

        Pattern colPattern = Pattern.compile("`(\\w+)`\\s+(\\w+)(?:\\([^)]*\\))?.*?COMMENT\\s+['\"](.+?)['\"]", Pattern.CASE_INSENSITIVE);
        Matcher c = colPattern.matcher(sql);
        while (c.find()) {
            ColumnInfo col = new ColumnInfo();
            col.setColumnName(c.group(1));
            col.setJdbcType(c.group(2));
            col.setJavaType(sqlTypeToJava(col.getJdbcType()));
            col.setPropertyName(toCamelCase(c.group(1)));
            col.setComment(c.group(3));
            table.getColumns().add(col);
        }
    }

    private static void parsePostgres(String sql, TableInfo table) {
        Pattern tablePattern = Pattern.compile("CREATE TABLE\\s+(\\w+)", Pattern.CASE_INSENSITIVE);
        Matcher m = tablePattern.matcher(sql);
        if (m.find()) {
            table.setTableName(m.group(1));
            table.setClassName(toCamelCaseCap(table.getTableName()));
        }

        // 表注释
        Pattern tableComment = Pattern.compile("COMMENT ON TABLE\\s+(\\w+)\\s+IS\\s+'(.+?)'", Pattern.CASE_INSENSITIVE);
        Matcher tc = tableComment.matcher(sql);
        if (tc.find()) {
            table.setComment(tc.group(2));
        }

        // 字段定义基础解析
        Pattern colPattern = Pattern.compile("(\\w+)\\s+(\\w+)(?:\\([^)]*\\))?", Pattern.CASE_INSENSITIVE);
        Matcher cm = colPattern.matcher(sql);
        while (cm.find()) {
            ColumnInfo col = new ColumnInfo();
            col.setColumnName(cm.group(1));
            col.setJdbcType(cm.group(2));
            col.setJavaType(sqlTypeToJava(col.getJdbcType()));
            col.setPropertyName(toCamelCase(cm.group(1)));
            table.getColumns().add(col);
        }

        // 字段注释
        Pattern colComment = Pattern.compile("COMMENT ON COLUMN\\s+\\w+\\.(\\w+)\\s+IS\\s+'(.+?)'", Pattern.CASE_INSENSITIVE);
        Matcher cc = colComment.matcher(sql);
        Map<String, String> cmMap = new HashMap<>();
        while (cc.find()) {
            cmMap.put(cc.group(1), cc.group(2));
        }
        // 回填注释
        for (ColumnInfo c : table.getColumns()) {
            c.setComment(cmMap.getOrDefault(c.getColumnName(), ""));
        }
    }


    private static String sqlTypeToJava(String type) {
        type = type.toLowerCase();
        if (type.contains("bigint")) return "Long";
        if (type.contains("int")) return "Integer";
        if (type.contains("decimal") || type.contains("numeric")) return "BigDecimal";
        if (type.contains("date") || type.contains("time")) return "LocalDateTime";
        return "String";
    }

    private static String toCamelCase(String s) {
        StringBuilder sb = new StringBuilder();
        boolean upper = false;
        for (char c : s.toCharArray()) {
            if (c == '_') upper = true;
            else {
                sb.append(upper ? Character.toUpperCase(c) : c);
                upper = false;
            }
        }
        return sb.toString();
    }

    private static String toCamelCaseCap(String s) {
        String str = toCamelCase(s);
        return Character.toUpperCase(str.charAt(0)) + str.substring(1);
    }
}


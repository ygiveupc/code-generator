<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.${table.className}Mapper">
    <resultMap id="${table.className}Map" type="${packageName}.dataobject.entity.${table.className}">
        <#list table.columns as col>
            <result column="${col.columnName}" property="${col.propertyName}"/>
        </#list>
    </resultMap>

    <sql id="Base_Column_List">
        <#list table.columns as col>
            ${col.columnName}<#if col?has_next>,</#if>
        </#list>
    </sql>

    <select id="listAll" resultMap="${table.className}Map">
        SELECT <include refid="Base_Column_List"/> FROM ${table.tableName}
    </select>
</mapper>

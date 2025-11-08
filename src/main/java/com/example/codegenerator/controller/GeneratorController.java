package com.example.codegenerator.controller;


import com.example.codegenerator.model.GeneratorRequest;
import com.example.codegenerator.service.GeneratorService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/generator")
@RequiredArgsConstructor
public class GeneratorController {

    private final GeneratorService generatorService;

    @PostMapping("/create")
    public void create(@RequestBody GeneratorRequest request, HttpServletResponse response) throws IOException {
        byte[] zip = generatorService.generateCodeZip(request);
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"generated-code.zip\"");
        response.getOutputStream().write(zip);
    }
}


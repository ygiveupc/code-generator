package com.example.codegenerator.service;

import com.example.codegenerator.model.GeneratorRequest;

import java.io.IOException;

public interface GeneratorService {

    public byte[] generateCodeZip(GeneratorRequest req) throws IOException;
}

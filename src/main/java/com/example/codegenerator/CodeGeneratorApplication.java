package com.example.codegenerator;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 代码生成器启动类
 */
@SpringBootApplication(exclude = {org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration.class},scanBasePackages = {"com.example.codegenerator"})
public class CodeGeneratorApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(CodeGeneratorApplication.class);
        // 启动后打印访问地址
        application.addListeners(new ApplicationListener<ApplicationReadyEvent>() {
            @Override
            public void onApplicationEvent(ApplicationReadyEvent event) {
                Environment env = event.getApplicationContext().getEnvironment();
                String port = env.getProperty("server.port", "8080");
                String contextPath = env.getProperty("server.servlet.context-path", "");
                try {
                    String ip = InetAddress.getLocalHost().getHostAddress();
                    System.out.println("""
                            ----------------------------------------------------------
                            项目启动成功 ✅
                            本地访问地址: http://localhost:%s%s/index.html
                            局域网访问地址: http://%s:%s%s/index.html
                            ----------------------------------------------------------  
                            """.formatted(port, contextPath, ip, port, contextPath, port, contextPath));
                } catch (UnknownHostException e) {
                    System.err.println("无法获取本机IP地址: " + e.getMessage());
                }
            }
        });
        application.run(args);
    }
}

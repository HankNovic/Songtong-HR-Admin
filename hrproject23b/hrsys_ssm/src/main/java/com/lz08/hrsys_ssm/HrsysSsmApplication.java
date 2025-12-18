package com.lz08.hrsys_ssm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.lz08.hrsys_ssm.dao")
public class HrsysSsmApplication {

    public static void main(String[] args) {
        SpringApplication.run(HrsysSsmApplication.class, args);
    }

}

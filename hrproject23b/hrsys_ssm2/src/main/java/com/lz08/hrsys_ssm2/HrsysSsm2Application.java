package com.lz08.hrsys_ssm2;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.lz08.hrsys_ssm2.dao")
public class HrsysSsm2Application {

    public static void main(String[] args) {
        SpringApplication.run(HrsysSsm2Application.class, args);
    }

}

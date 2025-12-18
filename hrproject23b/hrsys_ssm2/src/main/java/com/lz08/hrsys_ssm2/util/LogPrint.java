package com.lz08.hrsys_ssm2.util;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogPrint {
    @Before("execution(* com.lz08.hrsys_ssm2.service.impl.*.*(..))")
    public void methodBegin(JoinPoint joinPoint) {
        System.out.println(joinPoint.getTarget()+" "+joinPoint.getSignature().getName()+"  开始");
    }

    @After("execution(* com.lz08.hrsys_ssm2.service.impl.*.*(..))")
    public void methodEnd(JoinPoint joinPoint) {
        System.out.println("方法结束了");
    }
}

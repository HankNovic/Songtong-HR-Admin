package com.lz08.hrsys_ssm2.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 密码工具类
 * 用于生成 BCrypt 加密密码（测试用）
 */
public class PasswordUtil {
    
    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    /**
     * 生成 BCrypt 加密密码
     * @param rawPassword 明文密码
     * @return 加密后的密码
     */
    public static String encode(String rawPassword) {
        return encoder.encode(rawPassword);
    }

    /**
     * 验证密码
     * @param rawPassword 明文密码
     * @param encodedPassword 加密后的密码
     * @return 是否匹配
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encoder.matches(rawPassword, encodedPassword);
    }

    /**
     * 测试方法：生成密码
     * 可以在 main 方法中运行来生成测试密码
     */
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法: java PasswordUtil <明文密码>");
            System.out.println("示例: java PasswordUtil 123456");
            return;
        }
        
        String rawPassword = args[0];
        String encodedPassword = encode(rawPassword);
        System.out.println("明文密码: " + rawPassword);
        System.out.println("BCrypt 加密密码: " + encodedPassword);
    }
}


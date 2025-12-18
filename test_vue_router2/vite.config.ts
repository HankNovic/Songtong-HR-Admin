import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import inject from '@rollup/plugin-inject'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(),
    inject({
      $: "jquery", // 这里会自动载入 node_modules 中的 jquery
      jQuery: "jquery",
      "windows.jQuery": "jquery"
    })],
  server: {
    host: '0.0.0.0', // 监听所有网络接口，允许局域网访问
    port: 5173, // 指定端口（可选，默认就是 5173）
  },
})

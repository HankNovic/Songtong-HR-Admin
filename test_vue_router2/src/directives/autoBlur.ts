import type { Directive } from "vue";

/**
 * v-auto-blur
 * 点击后自动让元素失去焦点，用于按钮点击后快速恢复样式
 */
export const autoBlur: Directive<HTMLElement, void> = {
  mounted(el) {
    const handler = () => {
      // 稍微延迟一下，再 blur，让用户有时间看到点击反馈
      window.setTimeout(() => {
        (el as HTMLElement).blur();
      }, 150);
    };
    // 将 handler 挂到元素上，卸载时移除
    (el as any).__autoBlurHandler__ = handler;
    el.addEventListener("click", handler);
  },
  beforeUnmount(el) {
    const handler = (el as any).__autoBlurHandler__;
    if (handler) {
      el.removeEventListener("click", handler);
      delete (el as any).__autoBlurHandler__;
    }
  },
};



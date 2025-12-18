<script lang="ts" setup>
withDefaults(
  defineProps<{
    show: boolean;
    text?: string;
  }>(),
  {
    text: "加载中...",
  }
);
</script>

<template>
  <div v-if="show" class="base-loading-overlay" aria-live="polite" aria-busy="true">
    <div class="base-loading-spinner" />
    <div v-if="text" class="base-loading-text">{{ text }}</div>
  </div>
</template>

<style>
.base-loading-overlay {
  position: absolute;
  inset: 0;
  z-index: 20;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 10px;
  background: rgba(255, 255, 255, 0.55);
  backdrop-filter: blur(1px);
}

:root[data-theme="dark"] .base-loading-overlay {
  background: rgba(0, 0, 0, 0.35);
}

.base-loading-spinner {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: 4px solid rgba(0, 0, 0, 0.12);
  border-top-color: var(--color-primary);
  animation: base-loading-spin 0.9s linear infinite;
}

:root[data-theme="dark"] .base-loading-spinner {
  border-color: rgba(255, 255, 255, 0.14);
  border-top-color: var(--color-primary);
}

.base-loading-text {
  font-size: 12px;
  color: var(--color-text);
  user-select: none;
}

@keyframes base-loading-spin {
  to {
    transform: rotate(360deg);
  }
}
</style>


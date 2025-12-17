import { Ref, onMounted, onUnmounted } from 'vue';

/**
 * 可复用的点击外部区域取消选中功能
 * @param selectedId 单个选中ID的ref
 * @param selectedIds 多个选中ID数组的ref（批量模式）
 * @param batchMode 批量模式标志的ref
 * @param excludeSelectors 需要排除的选择器数组（点击这些区域不会取消选中）
 */
export function useClickOutsideClearSelection(
  selectedId: Ref<number>,
  selectedIds: Ref<number[]>,
  batchMode: Ref<boolean>,
  excludeSelectors: string[] = [
    '.table',
    '#buttons',
    '.form-horizontal',
    '.modal-mask'
  ]
) {
  const clearSelection = () => {
    if (!batchMode.value) {
      selectedId.value = -1;
    } else {
      selectedIds.value = [];
      selectedId.value = -1;
    }
  };

  const handleClickOutside = (event: MouseEvent) => {
    const target = event.target as HTMLElement;
    
    // 检查是否点击在排除区域内
    const isInsideExcludedArea = excludeSelectors.some(selector => 
      target.closest(selector)
    );
    
    if (isInsideExcludedArea) {
      return;
    }
    
    clearSelection();
  };

  onMounted(() => {
    document.addEventListener('click', handleClickOutside);
  });

  onUnmounted(() => {
    document.removeEventListener('click', handleClickOutside);
  });
}

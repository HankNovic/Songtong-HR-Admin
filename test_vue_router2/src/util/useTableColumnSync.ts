import { onMounted, onUnmounted, nextTick, type Ref } from 'vue';

/**
 * 同步表头和表体的列宽
 * @param headerTableRef 表头表格的 ref
 * @param bodyTableRef 表体表格的 ref
 */
export function useTableColumnSync(
  headerTableRef: Ref<HTMLTableElement | null>,
  bodyTableRef: Ref<HTMLTableElement | null>
) {
  const syncColumnWidths = () => {
    const headerTable = headerTableRef.value;
    const bodyTable = bodyTableRef.value;
    
    if (!headerTable || !bodyTable) return;
    
    const headerCells = headerTable.querySelectorAll('thead th');
    const bodyCells = bodyTable.querySelectorAll('tbody tr:first-child td');
    
    if (headerCells.length !== bodyCells.length) return;
    
    // 同步每一列的宽度
    headerCells.forEach((headerCell, index) => {
      const bodyCell = bodyCells[index];
      if (bodyCell) {
        const width = headerCell.getBoundingClientRect().width;
        (bodyCell as HTMLElement).style.width = `${width}px`;
        (bodyCell as HTMLElement).style.minWidth = `${width}px`;
        (bodyCell as HTMLElement).style.maxWidth = `${width}px`;
      }
    });
  };

  // 初始化同步
  onMounted(() => {
    nextTick(() => {
      syncColumnWidths();
      // 监听窗口大小变化
      window.addEventListener('resize', syncColumnWidths);
    });
  });

  onUnmounted(() => {
    window.removeEventListener('resize', syncColumnWidths);
  });

  // 返回同步函数，供外部手动调用（例如数据更新后）
  return {
    syncColumnWidths,
  };
}


import { nextTick, onBeforeUnmount, onMounted, type Ref, watch } from "vue";

/**
 * 同步表头与表体列宽，并补偿滚动条宽度，保证表头与表体列完全对齐。
 *
 * 约定：
 * - headerComponentRef 指向 BaseTableHeader 组件实例，组件内部暴露 tableRef（defineExpose）。
 * - bodyTableRef 指向表体区域的 table 元素。
 * - bodyWrapperRef 指向包裹表体的滚动容器（用来计算滚动条宽度）。
 */
export function useSyncTableHeader(
  headerComponentRef: Ref<any | null>,
  bodyTableRef: Ref<HTMLTableElement | null>,
  bodyWrapperRef: Ref<HTMLElement | null>,
  watchSources: Ref<unknown>[] = []
) {
  const sync = () => {
    const headerInstance = headerComponentRef.value as any;
    const headerTable: HTMLTableElement | null = headerInstance?.tableRef ?? null;
    const bodyTable = bodyTableRef.value;
    const bodyWrapper = bodyWrapperRef.value;

    if (!headerTable || !bodyTable || !bodyWrapper) return;

    const bodyHead = bodyTable.tHead;
    const bodyFirstRow =
      (bodyHead && bodyHead.rows[0]) ||
      (bodyTable.tBodies[0] && bodyTable.tBodies[0].rows[0]);

    if (!bodyFirstRow) return;

    const headerRow = headerTable.tHead?.rows[0];
    if (!headerRow) return;

    const bodyCells = Array.from(bodyFirstRow.cells);
    const headerCells = Array.from(headerRow.cells);
    const len = Math.min(bodyCells.length, headerCells.length);

    if (!len) return;

    // 先清空宽度，避免历史宽度干扰
    headerCells.forEach((cell) => {
      (cell as HTMLElement).style.width = "";
    });

    // 读取表体每列宽度并设置到表头对应列
    for (let i = 0; i < len; i++) {
      const bodyWidth = (bodyCells[i] as HTMLElement).getBoundingClientRect().width;
      (headerCells[i] as HTMLElement).style.width = `${bodyWidth}px`;
    }

    // 处理滚动条宽度补偿，让表头总宽度与表体可视宽度一致
    const wrapper = bodyWrapper as HTMLElement;
    const scrollBarWidth = wrapper.offsetWidth - wrapper.clientWidth;
    const headerWrapper = headerTable.parentElement as HTMLElement | null;
    if (headerWrapper) {
      headerWrapper.style.paddingRight = scrollBarWidth > 0 ? `${scrollBarWidth}px` : "0px";
    }
  };

  const scheduleSync = () => {
    nextTick(() => {
      sync();
    });
  };

  onMounted(() => {
    scheduleSync();
    window.addEventListener("resize", scheduleSync);
  });

  onBeforeUnmount(() => {
    window.removeEventListener("resize", scheduleSync);
  });

  if (watchSources.length) {
    watch(
      watchSources,
      () => {
        scheduleSync();
      },
      { deep: true }
    );
  }
}



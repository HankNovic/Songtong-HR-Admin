import { computed, ref, Ref, watch } from "vue";

export interface PaginationConfig<T> {
  source: Ref<T[]>;
  pageSizeOptions?: number[];
  defaultPageSize?: number;
  storageKey?: string; // 用于本地记录每页条数，不同页面使用不同的key
}

export function usePagination<T>(config: PaginationConfig<T>) {
  const { source, pageSizeOptions = [5, 10, 20, 50, 100], defaultPageSize = 10, storageKey } = config;

  const currentPage = ref(1);
  const pageSize = ref(defaultPageSize);

  // 初始化时从本地存储恢复每页条数
  if (storageKey && typeof window !== "undefined") {
    try {
      const saved = window.localStorage.getItem(storageKey);
      if (saved) {
        const parsed = parseInt(saved, 10);
        if (!Number.isNaN(parsed) && parsed > 0) {
          pageSize.value = parsed;
        }
      }
    } catch {
      // 忽略本地存储错误
    }
  }

  const total = computed(() => source.value.length);
  const totalPages = computed(() => {
    if (pageSize.value <= 0) return 1;
    return Math.max(1, Math.ceil(total.value / pageSize.value));
  });

  const pagedData = computed(() => {
    if (!Array.isArray(source.value)) return [];
    const start = (currentPage.value - 1) * pageSize.value;
    return source.value.slice(start, start + pageSize.value);
  });

  const setPage = (page: number) => {
    if (page < 1) page = 1;
    if (page > totalPages.value) page = totalPages.value;
    currentPage.value = page;
  };

  const setPageSize = (size: number) => {
    if (size <= 0) return;
    pageSize.value = size;
    // 重置到第一页，避免当前页超过新总页数
    currentPage.value = 1;
  };

  // 监听 pageSize 变化并持久化到本地存储
  if (storageKey && typeof window !== "undefined") {
    watch(pageSize, (val) => {
      try {
        window.localStorage.setItem(storageKey, String(val));
      } catch {
        // 忽略本地存储错误
      }
    });
  }

  const hasPrev = computed(() => currentPage.value > 1);
  const hasNext = computed(() => currentPage.value < totalPages.value);

  return {
    currentPage,
    pageSize,
    total,
    totalPages,
    pageSizeOptions,
    pagedData,
    setPage,
    setPageSize,
    hasPrev,
    hasNext,
  };
}



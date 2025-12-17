export type CreateInitialForm<T> = () => T;

/**
 * 通用搜索表单重置逻辑：
 * - 使用 Object.assign 把 form 恢复为初始状态
 * - 可选地在重置后执行额外逻辑（例如重新触发搜索）
 */
export function useSearchReset<T extends Record<string, any>>(
  form: T,
  createInitial: CreateInitialForm<T>,
  afterReset?: () => void
) {
  const reset = () => {
    Object.assign(form, createInitial());
    if (afterReset) afterReset();
  };

  return {
    reset,
  };
}



import { ref, reactive } from "vue";

export type EditMode = "create" | "edit";

/**
 * 通用单条编辑弹窗逻辑
 * createEmpty 用于返回一份空表单对象
 */
export function useEditDialog<T extends Record<string, any>>(createEmpty: () => T) {
  const showEditDialog = ref(false);
  const editMode = ref<EditMode>("create");
  const editForm = reactive<T>(createEmpty());

  const openCreate = () => {
    Object.assign(editForm, createEmpty());
    editMode.value = "create";
    showEditDialog.value = true;
  };

  const openEdit = (data: Partial<T>) => {
    Object.assign(editForm, createEmpty(), data);
    editMode.value = "edit";
    showEditDialog.value = true;
  };

  const close = () => {
    showEditDialog.value = false;
  };

  return {
    showEditDialog,
    editMode,
    editForm,
    openCreate,
    openEdit,
    close,
  };
}



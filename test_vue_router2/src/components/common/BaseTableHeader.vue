<script setup lang="ts">
import { ref } from "vue";

interface Column {
  key: string;
  title: string;
  className?: string;
}

const props = defineProps<{
  columns: Column[];
  showCheckbox?: boolean;
}>();

// 暴露内部 table 引用，便于父组件做列宽同步
const tableRef = ref<HTMLTableElement | null>(null);
defineExpose({
  tableRef,
});
</script>

<template>
  <div class="table-header-fixed">
    <table
      ref="tableRef"
      class="table table-striped table-bordered table-hover"
    >
      <thead>
        <tr>
          <th class="col-check" v-if="props.showCheckbox">
            <slot name="checkbox" />
          </th>
          <th
            v-for="col in props.columns"
            :key="col.key"
            :class="col.className"
          >
            {{ col.title }}
          </th>
        </tr>
      </thead>
    </table>
  </div>
</template>

<style scoped>
.table-header-fixed {
  flex: 0 0 auto;
}

.table-header-fixed .table {
  margin-bottom: 0;
}
</style>



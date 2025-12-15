<script lang="ts">
export default {
  name: "B",
  data() {
    return {
      message: "你好,我是 B 组件 23 XX",
    };
  },
  methods: {
    change: function () {
      this.message = "Hello,this is B component 23 XX";
    },
  },
};
</script>
<template>
  <div id="container">
    <div>
      {{ message }}
    </div>
    <button @click="change">点击</button>
  </div>
</template>
<style scoped></style>
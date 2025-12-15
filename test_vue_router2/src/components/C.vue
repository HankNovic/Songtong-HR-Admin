<script  lang="ts">
export default {
  name: "C",
  props: {
    name: String
  },
  data() {
    return {
      message: "你好,"+this.name+"，我是C组件 使用选项式API语法",
    }











  },
  methods: {
    change: function () {
      this.message = "Hello,"+this.name+"，this is C Component 使用选项式API语法"
    }








    
  }
}
</script>

<template>
    <div id="container">
      <div>
        {{message}}
      </div>
      <button @click="change">点击</button>
    </div>
  </template>

<style scoped>
</style>
  
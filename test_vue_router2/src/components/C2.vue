<script lang="ts" setup>
import {ref} from "vue";

const props = defineProps({name:String})
const message = ref("你好," + props.name + "，我是C2组件 使用setup语法糖");
const change = () => {
  message.value = "Hello," + props.name + "，this is C2 Component"
}
</script>

<template>
    <div id="container">
      <div>
        {{ message }}
      </div>
      <button @click="change">点击</button>
    </div>
  </template>
  
  
<style scoped>

</style>


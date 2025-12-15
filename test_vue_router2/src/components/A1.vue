<script  lang="ts">
import {ref} from "vue";

export default {
  setup() {
    const message = ref("你好，我是A1组件");
    // const change=function(){
    //     message.value = "Hello,this is A1 component";
    // }
    const change=()=> {
      message.value = "Hello,this is A1 component";
    }
    return {message,change};
  }
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
  

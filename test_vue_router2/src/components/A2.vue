<script setup  lang="ts">
import {ref} from "vue";
const message = ref("你好，我是A2组件");
const change = () => {
  message.value = "Hello,this is A2 component";
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
  
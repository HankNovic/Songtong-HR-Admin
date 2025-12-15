<script lang="ts">
import {ref} from "vue";

export default {
  name: "C1",
  props: {
    name: String
  },
  setup(props) {
    const message = ref("你好," + props.name + "，我是C1组件 组合式API");
    const change = () => {
      message.value = "Hello," + props.name + "，this is C1 Component"
    }
    return {message, change}
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
  

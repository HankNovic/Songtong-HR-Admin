<script>
export default {
  name: "ViewA",
  data() {
    return {
      message: "你好，我是ViewA组件",
    }
  }
}
</script>

<template>
  <div id="container">
    <div>
      {{message}}
    </div>
  </div>
</template>

<style scoped>

</style>
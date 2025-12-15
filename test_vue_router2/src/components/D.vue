<script  lang="ts">
export default {
  name: "D",

  data() {
    return {
      message: "你好，我是D组件",
    }
  },
  methods: {
    sendMes: function () {
      this.$emit("receiveMes","这是D组件发送到父组件的信息")
    }
  }
}
</script>

<template>
  <div id="container">
    <div>
      {{message}}
    </div>
    <button @click="sendMes">发送消息到父组件</button>
  </div>
</template>

<style scoped>
#container {
  width: 1000px;
  margin: 10px auto;
}
</style>
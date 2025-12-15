<script>
export default {
  name: "ViewB",
  data() {
    return {
      id:"",
      message: "你好，我是ViewB组件",
    }
  },
  mounted(){
    this.id=this.$route.query.id
  }
}
</script>

<template>
    <div id="container">
      <div>
        {{id}},{{message}}
      </div>
    </div>
  </template>

<style scoped>

</style>
  

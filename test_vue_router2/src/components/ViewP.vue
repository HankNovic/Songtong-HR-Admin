<script>
export default {
  name: "ViewP",
  methods: {
    routerLink: function (viewName) {
      this.$router.push({name:viewName,query:{id:1}});
    }
  }
}
</script>
<template>
  <div id="container">
    <div>这是ViewP视图组件</div>
    <hr/>
    <Button @click="routerLink('ViewA')">ViewA</Button>
    <Button @click="routerLink('ViewB')">ViewB</Button>
    <router-view/>
  </div>
</template>
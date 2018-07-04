<template>
  <div id="helloDiv">
    <div class="hello">
      <h1>{{ msg }}</h1>
      <p>
        For guide and recipes on how to configure / customize this project,<br>
        check out the
        <a href="https://cli.vuejs.org" target="_blank">vue-cli documentation</a>.
      </p>
      <h3>Installed CLI Plugins</h3>
      <ul>
        <li><a href="https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-babel" target="_blank">babel</a></li>
        <li><a href="https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-eslint" target="_blank">eslint</a></li>
      </ul>
      <h3>Essential Links</h3>
      <ul>
        <li><a href="https://vuejs.org" target="_blank">Core Docs</a></li>
        <li><a href="https://forum.vuejs.org" target="_blank">Forum</a></li>
        <li><a href="https://chat.vuejs.org" target="_blank">Community Chat</a></li>
        <li><a href="https://twitter.com/vuejs" target="_blank">Twitter</a></li>
      </ul>
      <h3>Ecosystem</h3>
      <ul>
        <li><a href="https://router.vuejs.org" target="_blank">vue-router</a></li>
        <li><a href="https://vuex.vuejs.org" target="_blank">vuex</a></li>
        <li><a href="https://github.com/vuejs/vue-devtools#vue-devtools" target="_blank">vue-devtools</a></li>
        <li><a href="https://vue-loader.vuejs.org" target="_blank">vue-loader</a></li>
        <li><a href="https://github.com/vuejs/awesome-vue" target="_blank">awesome-vue</a></li>
      </ul>
    </div>

    <div class="container">
      <div class="row">
        <div class="col-6">
          <button class="btn btn-primary">Hello</button>
        </div>
        <div class="col-6">
          <button class="btn btn-danger" v-on:click="helloFetch">{{ test }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

var axios = require('axios');

export default {
  name: 'HelloWorld',
  props: {
    msg: String,
  },
  data() {
    return {
      test: "pardner"
    }
    
  },
  methods:{
    helloFetch: function(){
      var self = this;
      //alert("in hello fetch");
      axios.get("http://localhost:8081/items")
      .then(function(data){
        //alert(data);
        //alert(data)
        //alert(data.first())
        
        if(self.test == data.data[0].title){
          self.test = data.data[1].title;
        }
        else{
          self.test = data.data[0].title;
        }
        


      });
      //alert("after fetch");
    }
  }


  
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>

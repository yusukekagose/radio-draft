import Vue from 'vue/dist/vue.js';
import Router from 'vue-router';

const Api = require('./api')

Vue.use(Router)
const router = new Router({
  
})

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#segment-form',
    data: {
      segments: [],
      segment:
        {
          name: ''
        },
      showForm: false,
      showButton: true,
      btnSegment: "追加",
      radioId: window.location.pathname.split('/')[2],
    },
    methods: {
      listSegments: function() {
        Api.listSegments(this.radioId).then(function(response){
            app.segments = response;
        })
      },
      clear: function() {
        this.segment = {};
      },
      toggleForm: function () {
        this.showForm = !this.showForm
        if(this.showForm) {
          this.btnSegment = "閉じる"
        } else {
          this.btnSegment = "追加"
        }
      },
      createTask: function(event) {
        Api.createSegment(this.segment, this.radioId).then(function(response){
          app.listSegments();
          app.clear();
          app.message = `Task ${response.id} created.`
        })
      },

    },
    beforeMount(){ this.listSegments(this.radioId) }
  })
})
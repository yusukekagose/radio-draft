import Vue from 'vue/dist/vue.js';

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#segment-form',
    data: {
      segment:
        {
          name: 'aaaa'
        },
      showForm: false,
      showButton: true,
    },
    methods: {
      toggleForm: function () {
        this.showForm = !this.showForm
      }
    }
  })
})
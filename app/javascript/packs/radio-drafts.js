import Vue from 'vue/dist/vue.js';
import radioDraft from '../radioDrafts.vue'

document.addEventListener('DOMContentLoaded', () => {
  var app = new Vue({
    el: '#radio-drafts',
    render: h => h(radioDraft)

  })

})
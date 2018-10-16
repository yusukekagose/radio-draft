import Vue from 'vue/dist/vue.js';

const Api = require('./api')

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#user-show',
    data: {
      drafts: [],
      segment:
        {
          name: ''
        },
      userId: window.location.pathname.split('/')[2],
    },
    methods: {
      listDrafts: function() {
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response;
        })
      },
      listDraftsDraft: function() {
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response.filter( item => item.status == "draft" );
        })
      },
      listDraftsSent: function() {
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response.filter( item => item.status == "sent" );
        })
      },
      toggleDraft: function(event, id) {
        Api.toggleDraft(id).then(function(response){
          app.listDrafts();
          app.message = `toggle status.`
        })
      },
      orderByCreate: function() {
        this.drafts.sort(function(a, b) {
          return new Date(a.create_at) - new Date(b.create_at);
        }).reverse();
      },
      orderByUpdate: function() {
        this.drafts.sort(function(a, b) {
          return new Date(a.updated_at) - new Date(b.updated_at);
        }).reverse();
      },
    },
    beforeMount(){ this.listDrafts(this.userId) }
  })
})
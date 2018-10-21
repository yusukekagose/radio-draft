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
      search: '',
      userShowTab: 'all',
      userShowTabOrder: 'new',
      userId: window.location.pathname.split('/')[2],
    },
    computed: {
      filteredDrafts:function() {
        return this.drafts.filter((draft) => {
          return draft.keyword.match(this.search);
        })
      }
    },
    methods: {
      listDrafts: function() {
        this.userShowTab = 'all'
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response;
        })
      },
      listDraftsDraft: function() {
        this.userShowTab = 'draft'
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response.filter( item => item.status == "draft" );
        })
      },
      listDraftsSent: function() {
        this.userShowTab = 'sent'
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
        this.userShowTabOrder = 'new'
        this.drafts.sort(function(a, b) {
          return new Date(a.create_at) - new Date(b.create_at);
        }).reverse();
      },
      orderByUpdate: function() {
        this.userShowTabOrder = 'update'
        this.drafts.sort(function(a, b) {
          return new Date(a.updated_at) - new Date(b.updated_at);
        }).reverse();
      },
    },
    beforeMount(){ this.listDrafts(this.userId) }
  })
})
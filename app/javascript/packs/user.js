import Vue from 'vue/dist/vue.js';

const Api = require('./api')

var filter = function(text, length, clamp){
    clamp = clamp || '...';
    var node = document.createElement('div');
    node.innerHTML = text;
    var content = node.textContent;
    return content.length > length ? content.slice(0, length) + clamp : content;
};

Vue.filter('truncate', filter);

document.addEventListener('DOMContentLoaded', () => {
  var app = new Vue({
    el: '#user-show',
    data() {
      return {
        loading: true,
        drafts: [],
        draftId: '',
        segment:
          {
            name: ''
          },
        search: '',
        userShowTab: 'all',
        userShowTabOrder: 'new',
        userId: window.location.pathname.split('/')[2],
        modalToggle: false,
        pageNumber: 0,
        pageSize: 20,
        visibleNextButton: true,

      }
    },
    computed: {
      filteredDrafts:function() {
        if(this.search.length > 1) {
          this.pageNumber = 0
        }
        const start = this.pageNumber * this.pageSize,
              end = start + this.pageSize;
        return this.drafts.filter((draft) => {
          return draft.keyword.match(this.search);
        }).slice(start, end);
      },
      vPagination: function() {
        return this.drafts.filter((draft) => {
          return draft.keyword.match(this.search);
        }).length > this.pageSize
      },
      pageCount: function(){
        let l = this.drafts.length,
            s = this.pageSize;
        return Math.floor(l/s);
      },
      vNext: function() {
        const draftNumber = this.drafts.filter((draft) => {
          return draft.keyword.match(this.search);
        }).length
        return draftNumber/(this.pageSize * (this.pageNumber  + 1)) <= 1
      }
    },
    methods: {
      truncate: function(text, stop, clamp) {
        return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
      },
      prevPage: function() {
        this.pageNumber--;
      },
      nextPage: function() {
        this.pageNumber++;
      },
      listDrafts: function() {
        this.userShowTab = 'all'
        Api.listDrafts(this.userId).then(function(response){
            app.drafts = response;
        })
        this.loading = false;
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
      deleteDraft: function(event, id) {
        event.stopImmediatePropagation();

        let draftIndex = this.drafts.findIndex(item => item.id == id);

        if(draftIndex > -1) {
          Api.deleteDraft(id).then(function(response){
            app.$delete(app.drafts, draftIndex)
            app.modalToggle = false
            app.message = `Draft ${id} deleted.`
          });
        }
      },
      toggleModal: function(id) {
        this.draftId = id
        if(this.modalToggle) {
          this.modalToggle = false
        } else {
          this.modalToggle = true
        }
      },
      orderByCreate: function() {
        this.userShowTabOrder = 'new'
        this.drafts.sort(function(a, b) {
          return new Date(a.created_at) - new Date(b.created_at);
        }).reverse();
      },
      orderByUpdate: function() {
        this.userShowTabOrder = 'update'
        this.drafts.sort(function(a, b) {
          return new Date(a.updated_at) - new Date(b.updated_at);
        }).reverse();
      },
      clearModal: function() {
        this.modalToggle = false
      },
    },
    beforeMount(){ this.listDrafts(this.userId)}
  })
})
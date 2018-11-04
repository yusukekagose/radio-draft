import Vue from 'vue/dist/vue.js';
const Api = require('./api')

document.addEventListener('DOMContentLoaded', () => {
  var app = new Vue({
    el: '#favorite',
    data() {
      return {
        favoriteId: "",
        count: 0,
        is_favorite: false,
        radioId: window.location.pathname.split('/')[2],
      }
    },
    methods: {
      FavoriteInfo: function() {
        Api.FavoriteInfo(this.radioId).then(function(response){
            app.favoriteId = response.id;
            app.count = response.count;
            app.is_favorite = response.is_favorite;
        })
      },
      createFavorite: function(event) {
        Api.createFavorite(this.radioId).then(function(response){
          app.FavoriteInfo();
        })
      },
      deleteFavorite: function(event, favoriteId) {
        event.stopImmediatePropagation();

        Api.deleteFavorite(favoriteId).then(function(response){
          app.FavoriteInfo();
          app.message = `favorite deleted.`
        });
      },
    },
    beforeMount(){ this.FavoriteInfo(this.radioId) }
  })
})
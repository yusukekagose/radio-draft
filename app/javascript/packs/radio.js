import Vue from 'vue/dist/vue.js';

const Api = require('./api')

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#radio-edit',
    data: {
      segments: [],
      segment:
        {
          name: ''
        },
      speakers: [],
      speaker:
        {
          name: ''
        },
      showSegmentForm: false,
      showSegmentButton: true,
      showSpeakerForm: false,
      showSpeakerButton: true,
      btnSegment: "追加",
      btnSpeaker: "追加",
      radioId: window.location.pathname.split('/')[2],
    },
    computed: {
        finishedSegments :function() {
          return this.segments.filter( item => item.status == "end" );
        },
        activeSegments: function() {
          return this.segments.filter( item => item.status ==  "active");
        },
    },
    methods: {
      listSegments: function() {
        Api.listSegments(this.radioId).then(function(response){
            app.segments = response;
        })
      },
      listSpeakers: function() {
        Api.listSpeakers(this.radioId).then(function(response){
            app.speakers = response;
        })
      },
      clearSegment: function() {
        this.segment = {};
      },
      clearSpeaker: function() {
        this.speaker = {};
      },
      toggleSegmentForm: function () {
        this.showSegmentForm = !this.showSegmentForm
        if(this.showSegmentForm) {
          this.btnSegment = "閉じる"
        } else {
          this.btnSegment = "追加"
        }
      },
      toggleSpeakerForm: function () {
        this.showSpeakerForm = !this.showSpeakerForm
        if(this.showSpeakerForm) {
          this.btnSpeaker = "閉じる"
        } else {
          this.btnSpeaker = "追加"
        }
      },
      createSegment: function(event) {
        Api.createSegment(this.segment, this.radioId).then(function(response){
          app.listSegments();
          app.clearSegment();
          app.message = `Task ${response.id} created.`
        })
      },
      toggleSegment: function(event, id) {
        Api.toggleSegment(id).then(function(response){
          app.listSegments();
          app.message = `toggle status.`
        })
      },
      deleteSegment: function(event, id) {
        event.stopImmediatePropagation();
        let segmentIndex = this.segments.findIndex(item => item.id == id);
        let draft_count = this.segments[segmentIndex].draft_count

        if(segmentIndex > -1 && !draft_count) {
          Api.deleteSegment(id).then(function(response){
            app.$delete(app.segments, segmentIndex)
            app.message = `Segment ${id} deleted.`
          });
        }
      },
      createSpeaker: function(event) {
        Api.createSpeaker(this.speaker, this.radioId).then(function(response){
          app.listSpeakers();
          app.clearSpeaker();
          app.message = `Speaker ${response.id} created.`
        })
      },
      deleteSpeaker: function(event, id) {
        event.stopImmediatePropagation();
        let speakerIndex = this.speakers.findIndex(item => item.id == id);

        if(speakerIndex > -1) {
          Api.deleteSpeaker(this.radioId, id).then(function(response){
            app.$delete(app.speakers, speakerIndex)
            app.message = `Speaker ${id} deleted.`
          });
        }
      },


    },
    beforeMount(){
      this.listSpeakers(this.radioId);
      this.listSegments(this.radioId);
    }
  })
})
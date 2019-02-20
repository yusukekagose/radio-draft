<template>
    <div class="mt-l ">
        <div v-for="(draft, index) in drafts" class="radio-show-draft-list" :key="index">
            <div class="mr-m">
                <i class="fas fa-user"></i>
            </div>
            <div class="word-wrap">
                {{ draft.content }}
                <span class="btn-primary-sm cl-white" v-if="draft.segment_name != null && draft.segment_name.length > 0">{{ draft.segment_name }}</span>
            </div>
        </div>
    </div>
</template>


<script>
import Vue from 'vue/dist/vue.js';
const Api = require('./packs/api')
export default {
    data() {
        return {
            drafts: [],
            radioId: window.location.pathname.split('/')[2],
        }
    },
    methods: {
        listDrafts() {
            let self = this
            Api.radioDrafts(this.radioId).then(function(response){
                self.drafts = response;
            });
        },
    },
    beforeMount(){ this.listDrafts(this.radioId)}

}
</script>

<style scoped>
    .draft-list {
        display: flex;
        color: red;
    }
    .segment {
        background: blue;
    }
</style>
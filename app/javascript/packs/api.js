import axios from 'axios';

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

///DRAFTS/////////////////
export function listDrafts (id) {
    return axios.get(`/users/${id}/drafts.json`)
           .then(function(response){
                return response.data;
            })
}
export function toggleDraft(id) {
    event.stopImmediatePropagation();

    return axios.patch(`/drafts/${id}/toggle_status.json`)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}
export function deleteDraft(id) {

    return axios.delete(`/drafts/${id}`)
            .then(function(response){
                return 'success'
            })
            .catch(function (error){
                console.log(error)
            })
}
///SEGMENTS///////////////
export function listSegments (id) {
    return axios.get(`/radios/${id}/segments.json`)
           .then(function(response){
                return response.data;
            })
}
export function createSegment(segment, id) {
    event.stopImmediatePropagation();

    var localSegment = segment;
    return axios.post(`/radios/${id}/segments.json`, localSegment)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}
export function deleteSegment(segment_id) {
    event.stopImmediatePropagation();

    return axios.delete(`/segments/${segment_id}`)
            .then(function(response){
                return 'success'
            })
            .catch(function (error){
                console.log(error)
            })
}

export function toggleSegment(id) {
    event.stopImmediatePropagation();

    return axios.patch(`/segments/${id}/toggle_status.json`)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}

///SPEAKERS///////////////
export function listSpeakers (id) {
    return axios.get(`/radios/${id}/speakers.json`)
           .then(function(response){
                return response.data;
            })
}

export function createSpeaker(speaker, id) {
    event.stopImmediatePropagation();

    var localSpeaker = speaker;
    return axios.post(`/radios/${id}/speakers.json`, localSpeaker)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}

export function deleteSpeaker(radio_id, speaker_id) {
    event.stopImmediatePropagation();

    return axios.delete(`/radios/${radio_id}/speaker/${speaker_id}`)
            .then(function(response){
                return 'success'
            })
            .catch(function (error){
                console.log(error)
            })
}

//Favorite///////////////////
export function createFavorite(radio_id) {
    event.stopImmediatePropagation();
    return axios.post(`/radios/${radio_id}/favorites.json`)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}
export function deleteFavorite(id) {
    event.stopImmediatePropagation();
    return axios.delete(`/favorites/${id}.json`)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}

export function FavoriteInfo (radioId) {
    return axios.get(`/radios/${radioId}/info.json`)
           .then(function(response){
                return response.data;
            })
}
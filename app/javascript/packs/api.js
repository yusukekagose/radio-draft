import axios from 'axios';


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
export function toggleSegment(id) {
    event.stopImmediatePropagation();

    return axios.patch(`/segment/${id}/toggle_status.json`)
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
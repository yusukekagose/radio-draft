import axios from 'axios';

export function listSegments (id) {
    return axios.get(`/radios/${id}/segments.json`)
           .then(function(response){
                return response.data;
            })
}
export function createSegment(segment, id) {
    var localSegment = segment;
    return axios.post(`/radios/${id}/segments.json`, localSegment)
        .then(function (response){
            return response.data
        })
        .catch(function(error){
            console.log(error);
        })
}

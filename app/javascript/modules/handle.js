import $ from 'jquery'
import axios from 'modules/axios'

const InactiveClipEvent = (eventId) => {
  $('.inactive-clip').on('click', () => {
    axios.post(`/events/${eventId}/clip`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-clip').removeClass('hidden')
          $('.inactive-clip').addClass('hidden')
        }
        console.log(response)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

const ActiveClipEvent = (eventId) => {
  $('.active-clip').on('click', () => {
    axios.delete(`/events/${eventId}/clip`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-clip').addClass('hidden')
          $('.inactive-clip').removeClass('hidden')
        }
        console.log(response)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

const InActiveJoinEvent = (eventId) => {
  $('.inactive-join').on('click', () => {
    axios.post(`/events/${eventId}/join`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-join').removeClass('hidden')
          $('.inactive-join').addClass('hidden')
        }
        console.log(response)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

const ActiveJoinEvent = (eventId) => {
  $('.active-join').on('click', () => {
    axios.delete(`/events/${eventId}/join`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $('.active-join').addClass('hidden')
          $('.inactive-join').removeClass('hidden')
        }
        console.log(response)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

export {
  InactiveClipEvent,
  ActiveClipEvent,
  InActiveJoinEvent,
  ActiveJoinEvent
}






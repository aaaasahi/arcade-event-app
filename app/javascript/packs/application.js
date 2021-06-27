// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap/dist/js/bootstrap"
import "chartkick/chart.js"

import $ from 'jquery'
import axios from 'modules/axios'
import {
  InactiveClipEvent,
  ActiveClipEvent,
  InActiveJoinEvent,
  ActiveJoinEvent
} from 'modules/handle.js'


Rails.start()
ActiveStorage.start()

const handleClipDisplay = (hasClipped) => {
  if (hasClipped) {
    $('.active-clip').removeClass('hidden')
  } else {
    $('.inactive-clip').removeClass('hidden')
  }
}

const handleJoinDisplay = (hasJoined) => {
  if (hasJoined) {
    $('.active-join').removeClass('hidden')
  } else {
    $('.inactive-join').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#event-show').data()
  const eventId = dataset.eventId

  axios.get(`/events/${eventId}/clip`)
    .then((response) => {
      console.log(response)
      const hasClipped = response.data.hasClipped
      handleClipDisplay(hasClipped)
    })

    axios.get(`/events/${eventId}/join`)
    .then((response) => {
      console.log(response)
      const hasJoined = response.data.hasJoined
      handleJoinDisplay(hasJoined)
    })

    $('.show-comment-form').on('click', () => {
      $('.show-comment-form').addClass('hidden')
      $('.comment-container').removeClass('hidden')
    })

  InactiveClipEvent(eventId)
  ActiveClipEvent(eventId)
  InActiveJoinEvent(eventId)
  ActiveJoinEvent(eventId)
})
require("trix")
require("@rails/actiontext")

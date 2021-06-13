// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap/dist/js/bootstrap"
import $ from 'jquery'
import axios from 'axios'

Rails.start()
ActiveStorage.start()

const handleClipDisplay = (hasClipped) => {
  if (hasClipped) {
    $('.active-clip').removeClass('hidden')
  } else {
    $('.inactive-clip').removeClass('hidden')
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
})
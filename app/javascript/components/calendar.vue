<template>
  <full-calendar :events="events" :config="config" default-view="month" />
</template>

<script>
import Vue from 'vue'
import FullCalendar from 'vue-full-calendar'
import 'fullcalendar/dist/fullcalendar.min.css'
import $ from 'jquery'
Vue.use(FullCalendar)

export default {
  data() {
    return {
      config: {},
      events: []
    }
  },
  mounted() {
    $.get('/loans.json').then(loans => {
      loans.forEach(loan => {
        // 返却日をイベント登録
        this.events.push({
          title: loan.book_title,
          url: `/loans/${loan.id}`,
          start: loan.ended_at,
          allDay: true,
          color: loan.returned ? 'grey' : 'red',
          textColor: 'white'
        })
      })
    })
  }
}
</script>

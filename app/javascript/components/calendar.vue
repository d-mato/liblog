<template>
  <full-calendar :options="calendarOptions" />
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'

export default {
  components: {
    FullCalendar
  },
  data() {
    return {
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        events: []
      }
    }
  },
  mounted() {
    fetch('/loans.json')
      .then(res => res.json())
      .then(loans => {
        loans.forEach(loan => {
          // 返却日をイベント登録
          this.calendarOptions.events.push({
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

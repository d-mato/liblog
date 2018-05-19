import Vue from 'vue/dist/vue.esm'
import FullCalendar from 'vue-full-calendar'
import 'fullcalendar/dist/fullcalendar.min.css'
Vue.use(FullCalendar)

const App = {
  el: '#app',
  data: {
    events: [],
    config: {
      eventClick (event) {
        console.log(event)
      }
    }
  },
  created () {
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

document.addEventListener('DOMContentLoaded', () => {
  new Vue(App)
})

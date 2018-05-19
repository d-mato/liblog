import Vue from 'vue/dist/vue.esm'
import FullCalendar from 'vue-full-calendar'
import 'fullcalendar/dist/fullcalendar.min.css'
Vue.use(FullCalendar)

const App = {
  el: '#app',
  data: {
    events: []
  },
  created () {
    $.get('/loans.json').then(loans => {
      loans.forEach(loan => {
        this.events.push({
          title: loan.book_title,
          // 貸出期間を全てイベント登録すると見辛い ...
          // start: loan.started_at,
          // end: loan.ended_at,
          start: loan.ended_at, // 返却日をイベント登録
          end: loan.ended_at,
          allDay: true,
          color: 'red',
          textColor: 'white'
        })

      })
    })
  }
}

document.addEventListener('DOMContentLoaded', () => {
  new Vue(App)
})

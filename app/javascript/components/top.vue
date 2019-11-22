<template>
  <div>
    <ul>
      <li>
        <router-link to="/">Top</router-link>
      </li>
      <li>
        <router-link to="/foo">Foo</router-link>
      </li>
      <li>
        <router-link to="/bar">Bar</router-link>
      </li>
    </ul>

    <div class="list-group">
      <a :href="`/loans/${loan.id}`" v-for="loan in loans" class="list-group-item text-decoration-none">
        <div class="d-flex align-items-center">
          <i class="far fa-comment-alt mx-1" v-if="loan.book_review" data-toggle="tooltip" title="レビューあり"></i>
          <div class="font-weight-bold">{{loan.book_title}}</div>
          <div class="text-right small">
            <div class="badge badge-secondary mx-1" v-if="loan.returned">返却済</div>
            <div class="badge badge-info mx-1" v-if="!loan.returned">{{loan.ended_at}}</div>
            <div class="d-inline ml-1 text-muted">{{loan.library.name}}</div>
          </div>
        </div>
      </a>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        loans: []
      }
    },
    mounted() {
      fetch('/loans.json').then(res => res.json()).then(data => {
        this.loans = data
      })
    }
  }
</script>

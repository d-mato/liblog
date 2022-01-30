<template>
  <div class="list-group py-4">
    <router-link :to="`/loans/${loan.id}`" v-for="loan in loans" class="list-group-item text-decoration-none" :style="{ background: loan.returned ? '' : 'aliceblue' }">
      <div class="d-flex align-items-center">
        <i class="far fa-comment-alt mx-1" v-if="loan.book_review" data-bs-toggle="tooltip" title="レビューあり"></i>
        <div class="fw-bold">{{ loan.book_title }}</div>
        <div class="text-end small">
          <div class="badge bg-secondary mx-1" v-if="loan.returned">返却済</div>
          <div class="badge bg-info mx-1" v-if="!loan.returned">{{ loan.ended_at }}</div>
          <div class="d-inline ms-1 text-muted">{{ loan.library.name }}</div>
        </div>
      </div>
    </router-link>
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
    fetch('/loans.json')
      .then(res => res.json())
      .then(data => {
        this.loans = data
      })
  }
}
</script>

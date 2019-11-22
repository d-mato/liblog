<template>
  <div class="py-2" v-if="loan">
    <h3>貸出情報</h3>
    <table class="table">
      <tr>
        <th>book_title</th>
        <td>{{loan.book_title}}</td>
      </tr>
      <tr>
        <th>author</th>
        <td>{{loan.author}}</td>
      </tr>
      <tr>
        <th>isbn</th>
        <td>{{loan.isbn}}</td>
      </tr>
      <tr>
        <th>started_at</th>
        <td>{{loan.started_at}}</td>
      </tr>
      <tr>
        <th>ended_at</th>
        <td :class="{'bg-danger text-white': loan.arrears }">{{loan.ended_at}}</td>
      </tr>
      <tr>
        <th>library</th>
        <td>{{loan.library.name}}</td>
      </tr>
      <tr>
        <th>place_name</th>
        <td>{{loan.place_name}}</td>
      </tr>
      <tr>
        <th>last_fetched_at</th>
        <td>{{loan.last_fetched_at}}</td>
      </tr>
    </table>

    <div class="py-2">
      <a v-if="!loan.returned" href="#" class="btn btn-info mx-2">延長する</a>
      <a v-if="!loan.returned" href="#" class="btn btn-info mx-2">返却済みにする</a>
    </div>

    <div class="py-2">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">book_review</h5>
          <div v-if="loan.book_review">
            <p class="card-text">
              <span>★ {{loan.book_review.star}}</span>
            </p>
            <p class="card-text" v-html="render_review_comment"></p>
          </div>
          <a href="#">レビューを更新</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        loan: null
      }
    },
    mounted() {
      fetch(`/loans/${this.$route.params.id}.json`).then(res => res.json()).then(data => {
        this.loan = data
      })
    },
    computed: {
      render_review_comment() {
        if (!this.loan.book_review) return ''
        return this.loan.book_review.comment.replace(/\n/g, "<br>")
      }
    }
  }
</script>

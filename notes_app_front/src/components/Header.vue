<template>
  <header class="bg-blue-400 py-4">
    <div class="container m-auto flex flex-wrap items-center justify-end">
      <div class="flex-1 flex items-center">
        <!-- <svg class="fill-current text-indigo" viewBox="0 0 24 24" width="24" height="24"><title>Notes header</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"></path></svg> -->

        <a href="/" class="uppercase text-sm font-mono pl-4 font-semibold no-underline text-indigo-dark hover:text-indigo-darker">Notes app</a>
      </div>
      <div>
        <router-link to="/" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/users" class="link-grey px-2 no-underline" v-if="signedIn()">Users</router-link>
        <router-link to="/notes" class="link-grey px-2 no-underline" v-if="signedIn()">Notes</router-link>
        <a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline" v-if="signedIn()">Sign out</a>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  template: '<Header/>',
  name: 'Header',
  created () {
    console.log(localStorage.signedIn)
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      console.log(localStorage.signedIn)
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          console.log(localStorage.signedIn)
          this.$router.push('/')
          window.location.reload() // FIXME Need a better way of doing this
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>

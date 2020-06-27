<template>
  <div class="max-w-sm m-auto my8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb6 text-grey-darkest">Sign In</h3>
      <form @submit.prevent="signin">
        <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="username" class="label">Username</label>
          <input type="text" v-model="username" class="input" id="username" placeholder="Type your username">
        </div>

        <div class="mb-6">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="input" id="password">
        </div>

        <button type="submit" class="button">Sign In</button>

        <div class="signup-section pt-6">
          <p class="flex justify-center w-full text-gray-700 tracking-wide text-xs font-bold mb-2">Don't have an account? Why not!</p>
          <div class="flex justify-center">
            <router-link to="/signup" class="button-alt">Sign Up</router-link>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      username: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkUpdated()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { username: this.username, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/users')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/users')
      }
    }
  }
}
</script>

<style scoped>

</style>

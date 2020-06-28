<template>
  <div class="max-w-sm m-auto my8">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb6 text-grey-darkest">Sign Up</h3>
      <form @submit.prevent="signup">
        <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="username" class="label">Username</label>
          <input type="text" v-model="username" class="input" id="username" placeholder="Type your username">
        </div>

        <div class="mb-6">
            <label for="email" class="label">Email</label>
            <input type="text" v-model="email" class="input" id="email" placeholder="Type your email">
          </div>

        <div class="mb-6">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="input" id="password">
        </div>

        <button type="submit" class="button">Sign Up</button>

        <div class="signup-section pt-6">
          <p class="flex justify-center w-full text-gray-700 tracking-wide text-xs font-bold mb-2">Already have an account?</p>
          <div class="flex justify-center">
            <router-link to="/" class="button-alt">Sign In</router-link>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      username: '',
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signup () {
      console.log('here')
      this.$http.plain.post('/signup', { username: this.username, email: this.email, password: this.password })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.push('/users')
      window.location.reload() // FIXME Need a better way of doing this
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.push('/users')
        window.location.reload() // FIXME Need a better way of doing this
      }
    }
  }
}
</script>

<style scoped>

</style>

<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb4">All users</h3>
    <form action="" @submit.prevent="addUser">
      <div class="mb-6">
        <input
          id="user_username"
          type="text"
          class="input"
          autofocus autocomplete="off"
          placeholder="Type a users username"
          v-model="newUser.username" />
      </div>
      <div class="mb-6">
        <input
          id="user_email"
          type="text"
          class="input"
          autofocus autocomplete="off"
          placeholder="Type a users email"
          v-model="newUser.email" />
      </div>
      <div class="mb-6">
        <input
          id="user_password"
          type="text"
          class="input"
          autofocus autocomplete="off"
          placeholder="Type a users password"
          v-model="newUser.password" />
      </div>
      <input type="submit" value="Add User" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center" />
    </form>

    <hr class="border border-grey-light my-6" />

    <p class="pt-4">
      <router-link to="/users" class="link-grey">Add a user</router-link>
    </p>

    <ul class="list-reset mt-4">
      <li class="mb-6 border p-10 border-grey-light shadow rounded" v-for="user in users" :key="user.id" :user="user">
        <div class="flex items-center flex-wrap">
          <div v-if="userIsAdmin(user)" class="items-left">[A]</div>
          <router-link :to="{ name:'User', params: { user_id: user.id }}">{{user.username}}</router-link>
        </div>
        <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded" @click.prevent="editUser(user)">Edit</button>

        <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red" @click.prevent="removeUser(user)">Delete</button>

        <div v-if="user == editedUser">
          <form action="" @submit.prevent="updateUser(user)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="user.username" />
              <input class="input" v-model="user.email" />
              <input class="input" v-model="user.password" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Users',
  data () {
    return {
      users: [],
      newUser: [],
      error: '',
      editedUser: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.push('/')
      window.location.reload() // FIXME Need a better way of doing this
    } else {
      this.$http.secured.get('/api/v1/users')
        .then(response => { this.users = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addUser () {
      const value = this.newUser
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/users/', { user: { username: this.newUser.username, email: this.newUser.email, password: this.newUser.password } })
        .then(response => {
          this.users.push(response.data)
          this.newUser = ''
        })
        .catch(error => this.setError(error, 'Cannot create user'))
    },
    removeUser (user) {
      this.$http.secured.delete(`/api/v1/users/${user.id}`)
        .then(response => {
          this.users.splice(this.users.indexOf(user), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete user'))
    },
    editUser (user) {
      this.editedUser = user
    },
    updateUser (user) {
      this.editedUser = ''
      this.$http.secured.patch(`/api/v1/users/${user.id}`, { user: { username: user.username, email: user.email, password: user.password } })
        .catch(error => this.setError(error, 'Cannot update user'))
    },
    userIsAdmin (user) {
      return user.is_admin
    }
  }
}
</script>

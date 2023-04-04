<template>


    <nav class="border-gray-200 bg-blue-500 dark:bg-gray-800 dark:border-gray-700">
        <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
            <a href="#" class="flex items-center">
                <img src="../assets/factory.png" class="h-8 mr-3" alt="Flowbite Logo" />
                <span class="self-center text-2xl font-semibold whitespace-nowrap text-white">Projekt zespołowy</span>
            </a>
            <button data-collapse-toggle="navbar-solid-bg" type="button" class="inline-flex items-center p-2 ml-3 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-solid-bg" aria-expanded="false">
                <span class="sr-only">Open main menu</span>
                <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
            </button>
            <div class="hidden w-full md:block md:w-auto" id="navbar-solid-bg">
                <ul class="flex flex-col font-medium mt-4 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-transparent dark:bg-gray-800 md:dark:bg-transparent dark:border-gray-700">
                    <li>
                        <a href="#" class="block py-2 pl-3 pr-4 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Sterowanie</a>
                    </li>
                    <li>
                        <a href="#" class="block py-2 pl-3 pr-4 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Monitorowanie</a>
                    </li>
                    <li>
                        <a href="#" class="block py-2 pl-3 pr-4 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">Zarządzanie</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

  <!-- component -->
  <div class="w-1/2 mt-12 justify-center container mx-auto">
    <div class="flex flex-wrap w-full lg:w-auto">
      <div class="w-full lg:w-1/2 flex rounded-lg bg-auto"
           style="background-image: url('https://images.unsplash.com/photo-1559963110-71b394e7494d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80')">
        <div class="rounded-lg py-6 pl-8 pr-32 w-full bg-blue-400 opacity-90 text-white">
          <div class="mb-20">
            <h2 class="font-bold text-3xl leading-none pb-1">Fabryka</h2>
          </div>
          <div>
              <strong class="leading-none text-5xl block font-weight-bolder">Temperatura</strong>
            <strong class="leading-none text-4xl block font-weight-bolder">{{ temp }}°C</strong>
          </div>
        </div>
      </div>

      <div class="w-full lg:w-1/2 flex ml-0">
        <div class="lg:my-3 bg-gray-800 text-white p-8 lg:rounded-r-lg w-full">
          <div class="flex justify-between w-64 mb-4 w-full">
            <div class="w-auto text-3xl font-bold uppercase text-90">Wilgotność</div>
            <div class="w-auto text-3xl text-right">{{ hum }}%</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios"
import {initFlowbite} from 'flowbite'

export default {
  name: 'HelloWorld',
  data() {
    return {
      temp: "0..",
      hum: "0..",

    };
  },
  async mounted() {
    initFlowbite()

    window.setInterval(async () => {
      await axios.get('http://localhost:3000/api/temp').then(resp => {
        this.temp = resp.data[0].temperature
        this.hum = resp.data[0].humidity
        console.log(resp.data[0])
      }).catch(error => {
        console.warn(error)
      })
    }, 1000)

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>

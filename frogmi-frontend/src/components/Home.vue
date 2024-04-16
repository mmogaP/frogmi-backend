<template>
  <div class="bg-gray-800 text-white p-4">
    <h1 class="text-2xl font-bold">Frogmi</h1>
  </div>
  <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
    <div v-for="feature in features" :key="feature.id" class="my-4 mx-4 p-4 border border-gray-200 rounded shadow">
      <h2 class="text-xl font-bold">{{ feature.attributes.title }}</h2>
      <p class="text-gray-600">{{ feature.attributes.place }}</p>
      <p class="text-sm text-gray-500">Magnitude: {{ feature.attributes.magnitude }}</p>
      <p class="text-sm text-gray-500">Time: {{ feature.attributes.time }}</p>
      <p class="text-sm text-gray-500">Tsunami: {{ feature.attributes.tsunami }}</p>
      <p class="text-sm text-gray-500">Mag Type: {{ feature.attributes.mag_type }}</p>
      <p class="text-sm text-gray-500">Coordinates: {{ feature.attributes.coordinates.latitude }}, {{ feature.attributes.coordinates.longitude }}</p>
      <a :href="feature.links.external_url" class="text-blue-500" target="_blank">External Link</a>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      features: [],
        };
    },
    methods: {
        async fetchData() {
        const response = await axios.get('http://localhost:3000/features');
        this.features = response.data.data;
        },
    },
    mounted() {
        this.fetchData();
    },
};
</script>
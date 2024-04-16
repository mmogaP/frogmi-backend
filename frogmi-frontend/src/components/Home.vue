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
      <p class="text-sm text-gray-500">Coordinates: {{ feature.attributes.coordinates.latitude }}, {{
        feature.attributes.coordinates.longitude }}</p>
      <a :href="feature.links.external_url" class="text-blue-500" target="_blank">External Link</a>
      <div class="mt-4">
        <h3 class="text-lg font-bold">Comentarios</h3>
        <ul>
          <li v-for="comment in feature.comments" :key="comment.id" class="text-sm text-gray-500">{{ comment.body }}
          </li>
        </ul>
        <input type="text" v-model="commentBody" class="border border-gray-200 rounded p-2 w-full mt-2"
          placeholder="Agregar comentario...">
        <button class="bg-green-900 hover:bg-green-500 text-white font-bold py-2 px-4 rounded mt-2"
          @click="addComment(feature.id, commentBody)">Agregar comentario</button>

      </div>

    </div>
  </div>
  <div class="flex justify-between items-center bg-gray-800 text-white p-4 mt-4">
    <button class="bg-green-900 hover:bg-green-500text-white font-bold py-2 px-4 rounded"
      v-if="pagination.current_page > 1" @click="fetchData(pagination.current_page - 1)">Anterior</button>
    <span class="text-white">Página {{ pagination.current_page }} de {{ pagination.total }}</span>
    <button class="bg-green-900 hover:bg-green-500text-white font-bold py-2 px-4 rounded"
      v-if="pagination.current_page < pagination.total"
      @click="fetchData(pagination.current_page + 1)">Siguiente</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      features: [],
      pagination: {
        current_page: 1,
        total: 1,
      },
    };
  },
  methods: {
    async fetchData(page = 1) {
      const response = await axios.get(`http://localhost:3000/features?page=${page}`);
      this.features = response.data.data;
      console.log(response.data);
      this.pagination = response.data.pagination;
    },
    async addComment(featureId, commentBody) {
      const response = await axios.post(`http://localhost:3000/features/${featureId}/comments`, {
        comment: {
          body: commentBody
        }
      });

      if (response.status === 201) {
        const newComment = response.data;
        const feature = this.features.find(feature => feature.id === featureId);
        if (feature) {
          if (!feature.comments) {
            feature.comments = [];
          }
          feature.comments.push(newComment);
          this.commentBody = '';
        }
      }

    },
  },
  mounted() {
    this.fetchData();
  },
};
</script>
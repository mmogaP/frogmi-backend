<script>
import { onBeforeMount } from 'vue'
import { useRouter } from 'vue-router'
export default {
  setup() {
    const router = useRouter()

    onBeforeMount(() => {
      router.push('/')
    })

    return {}
  },
}
</script>

<template>
  <div>
    <router-view />
  </div>
</template>
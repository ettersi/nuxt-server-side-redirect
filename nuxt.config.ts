// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  nitro: {
    static: true,
  },
  ssr: false,
  devtools: { enabled: true }
})

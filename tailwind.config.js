module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'custom-light-gray': '#EEEBE5', // カスタムカラーを追加
        'custom-brown': '#432C17',
        'custom-hover-brown': '#C16C27',
      },
    },
  },
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#432C17",
          "secondary": "#EEEBE5",
        },
      },
    ],
  },
  plugins: [require("daisyui")],
}

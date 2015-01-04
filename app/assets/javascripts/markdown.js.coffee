$ ->
  markdown = new Vue(
    el: '#marked'
    data:
      input: ''
    filters: {
      marked: marked
    }
  )

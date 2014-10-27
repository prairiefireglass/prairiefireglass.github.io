---
---

$ ->
  etsyURL = 'https://openapi.etsy.com/v2/shops/JimDowney/listings/active.js?limit=3&includes=Images:1&api_key=oo1odlylo4soh5rggyekdtfk'

  $.ajax
    url: etsyURL
    dataType: "jsonp"
    success: (data) ->
      if data.ok and data.count > 0
        $.each data.results, (i, item) ->
          console.log item.Images[0]
          $("<img/>").attr("src", item.Images[0].url_570xN).appendTo("[data-behavior~=etsy-items]").wrap "<a href='" + item.url + "'></a>"
          return
      else
        console.log data.error
      return
